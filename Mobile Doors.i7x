Mobile Doors by David Corbett begins here.

Chapter 1 - New properties

Include (-
with mobile false
with mobile_door nothing nothing nothing nothing
with mobile_door_dir [ loc; loc = location;
	if (loc == thedark) loc = real_location;
	if (loc == (self.&mobile_door)-->0) return (self.&mobile_door)-->3; return (self.&mobile_door)-->2;
]
with mobile_door_to [ loc; loc = location;
	if (loc == thedark) loc = real_location;
	if (loc == (self.&mobile_door)-->0) return (self.&mobile_door)-->1; return (self.&mobile_door)-->0;
]
-) when defining a door.

Chapter 2 - Mobility

Section 2.1 - Definition

Definition: a door is mobile rather than immobile if I6 routine "MobilizeDoor" makes it so (it has been moved or its mobile properties have been queried).

Section 2.2 - I6 implementation

Include (-
[ MobilizeDoor d set;
	if (set < 0) return d.mobile;
	if (set == true && d.mobile == false) {
		d.mobile = true;
		if (d provides found_in) { ! two-sided door
			(d.&mobile_door)-->0 = (d.&found_in)-->0;
			(d.&mobile_door)-->1 = (d.&found_in)-->1;
			@push location;
			location = LocationOf((d.&mobile_door)-->0);
			(d.&mobile_door)-->2 = d.door_dir();
			location = LocationOf((d.&mobile_door)-->1);
			(d.&mobile_door)-->3 = d.door_dir();
			@pull location;
		} else { ! one-sided door
			(d.&mobile_door)-->0 = parent(d);
			(d.&mobile_door)-->1 = d.door_to;
			(d.&mobile_door)-->2 = d.door_dir;
		}
		(d.&door_dir)-->0 = (d.&mobile_door_dir)-->0;
		(d.&door_to)-->0 = (d.&mobile_door_to)-->0;
	}
	! Once a mobile door, always a mobile door.
];
-).

Chapter 3 - Removal from play

Section 3.1 - Phrase

To remove (D - door) from play, preserving routes:
	(- RemoveFromPlay({D}, {phrase options}); -).

Section 3.2 - Modified AssertMapConnection

Include (-
Replace AssertMapConnection;
-) before "WorldModel.i6t".

Include (-
[ AssertMapConnection r1 dir r2 in_direction;
	SignalMapChange();
	in_direction = Map_Storage-->
		((r1.IK1_Count)*No_Directions + dir.IK3_Count);
	if ((in_direction == 0) || (in_direction ofclass (+ room +) or (+ door +))) {
		Map_Storage-->((r1.IK1_Count)*No_Directions + dir.IK3_Count) = r2;
		return;
	}
	RunTimeProblem(RTP_NOEXIT, r1, dir);
];
-).

Section 3.3 - Modified RemoveFromPlay

Include (-
Replace RemoveFromPlay;
-) before "WorldModel.i6t".

Include (-
[ RemoveFromPlay F preserve;
	if (F == nothing) return RunTimeProblem(RTP_CANTREMOVENOTHING);
	if (F == player) return RunTimeProblem(RTP_CANTREMOVEPLAYER);
	if (F ofclass (+ door +)) {
		MobilizeDoor(F, true);
		SignalMapChange();
		if (preserve) {
			if ((F.&mobile_door)-->0 ~= nothing && (F.&mobile_door)-->2)
				AssertMapConnection((F.&mobile_door)-->0, (F.&mobile_door)-->2, (F.&mobile_door)-->1);
			if ((F.&mobile_door)-->1 ~= nothing && (F.&mobile_door)-->3)
				AssertMapConnection((F.&mobile_door)-->1, (F.&mobile_door)-->3, (F.&mobile_door)-->0);
		} else {
			if ((F.&mobile_door)-->0 ~= nothing && (F.&mobile_door)-->2)
				AssertMapConnection((F.&mobile_door)-->0, (F.&mobile_door)-->2, nothing);
			if ((F.&mobile_door)-->1 ~= nothing && (F.&mobile_door)-->3)
				AssertMapConnection((F.&mobile_door)-->1, (F.&mobile_door)-->3, nothing);
		}
		! The door will keep the values in mobile_door after removal, but UpdateDoor relies on this.
	}
	give F ~worn; DetachPart(F);
	if (F ofclass K7_backdrop) give F absent;
	remove F;
];
-).

Section 3.4 - Modified MoveFloatingObjects

Include (-
Replace MoveFloatingObjects;
-) before "WorldModel.i6t".

Include (-
[ MoveFloatingObjects i k l m address flag;
	if (real_location == nothing) return;
	objectloop (i) {
		if (i provides mobile && i.mobile) {
			if (real_location == (i.&mobile_door)-->0 && (i.&mobile_door)-->2 ~= nothing ||
				real_location == (i.&mobile_door)-->1 && (i.&mobile_door)-->3 ~= nothing) {
				if (i notin real_location) move i to real_location;
			}
		} else {
			address = i.&found_in;
			if (address ~= 0 && i hasnt absent) {
				if (ZRegion(address-->0) == 2) {
					m = address-->0;
					.TestPropositionally;
					if (m.call(real_location) ~= 0) move i to real_location;
					else remove i;
				} else {
					k = i.#found_in;
					for (l=0 : l<k/WORDSIZE : l++) {
						m = address-->l;
						if (ZRegion(m) == 2) jump TestPropositionally;
						if (m == real_location || m in real_location) {
							if (i notin real_location) move i to real_location;
							flag = true;
						}
					}
					if (flag == false) { if (parent(i)) remove i; }
				}
			}
		}
	}
];
-).

Chapter 4 - Updating

To replace (query - object) in (D - door) with (replacement - object),
	preserving routes, and/or
	on the opposite side:
	(- SearchDoor({D}, {query}, {replacement}, {phrase options}, true); -).

Chapter 5 - Querying

Section 5.1 - Room query

To decide what object is room matching (query - object) in (D - door):
	(- SearchDoor({D}, {query}, IK1_First, 2) -).

Section 5.2 - Direction query

To decide what object is direction matching (query - object) in (D - door):
	(- SearchDoor({D}, {query}, IK3_First, 2) -).

Section 5.2 - Predicate

To decide whether (query - object) is matched in (D - door):
	(- (SearchDoor({D}, {query})) -).

Chapter 6 - Searching a door

Include (-
[ SearchDoor d old new opt modify i j;
	if (old == nothing && new == nothing) return;
	RemoveFromPlay(d, opt);
	for (i = 0: i < 4: i++) {
		if ((d.&mobile_door)-->i ~= old) continue;
		if (opt & 2)
			j = (i | 1) & (~(i & 1)); ! on the opposite side
		else j = i;
		if ((new ofclass (+ room +) && (j & 2) == 2) || (new ofclass (+ direction +) && (j & 2) == 0)) {
			if (old == nothing) continue;
			j = (j | 2) & (~(j & 2)); ! of the other class (room vs. direction)
		}
		if (modify == true)
			(d.&mobile_door)-->j = new;
		else 
			return (d.&mobile_door)-->j;
	}
	if ((d.&mobile_door)-->0 ~= nothing && (d.&mobile_door)-->2 ~= nothing)
		AssertMapConnection((d.&mobile_door)-->0, (d.&mobile_door)-->2, d);
	if ((d.&mobile_door)-->1 ~= nothing && (d.&mobile_door)-->3 ~= nothing)
		AssertMapConnection((d.&mobile_door)-->1, (d.&mobile_door)-->3, d);
	MoveFloatingObjects();
	rfalse;
];
-).

Chapter 7 - Moving

Section 7.1 - Phrase

To move (D - door) to (C1 - object) from/of (R1 - object) and (C2 - direction) from/of (R2 - object), preserving routes:
	(- MoveDoor({D}, {R1}, {R2}, {C1}, {C2}, {phrase options}); -).

Section 7.2 - I6 implementation

Include (-
[ MoveDoor d room1 room2 dir1 dir2 opt;
	RemoveFromPlay(d, opt);
	(d.&mobile_door)-->0 = room1;
	(d.&mobile_door)-->1 = room2;
	(d.&mobile_door)-->2 = dir1;
	(d.&mobile_door)-->3 = dir2;
	if ((d.&mobile_door)-->0 ~= nothing && (d.&mobile_door)-->2 ~= nothing)
		AssertMapConnection((d.&mobile_door)-->0, (d.&mobile_door)-->2, d);
	if ((d.&mobile_door)-->1 ~= nothing && (d.&mobile_door)-->3 ~= nothing)
		AssertMapConnection((d.&mobile_door)-->1, (d.&mobile_door)-->3, d);
	MoveFloatingObjects();
];
-).

Mobile Doors ends here.
