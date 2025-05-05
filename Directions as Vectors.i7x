Directions as Vectors by David Corbett begins here.

Section - Angle (for use without Metric Units by Graham Nelson)

Angle is a kind of value.
1 degree (in degrees, singular) or 2 degrees (in degrees, plural) specifies an angle.

Section - The angle list

A direction has a list of angles called the angle list.

Section - Default angles for the standard directions

The angle list of north is {0 degrees, 90 degrees}.
The angle list of northeast is {45 degrees, 90 degrees}.
The angle list of east is {90 degrees, 90 degrees}.
The angle list of southeast is {135 degrees, 90 degrees}.
The angle list of south is {180 degrees, 90 degrees}.
The angle list of southwest is {225 degrees, 90 degrees}.
The angle list of west is {270 degrees, 90 degrees}.
The angle list of northwest is {315 degrees, 90 degrees}.
The angle list of up is {0 degrees, 0 degrees}.
The angle list of down is {0 degrees, 180 degrees}.

Section - Transformations

To decide what K is (n - arithmetic value of kind K) modulo/mod (modulus - K):
	let the result be the remainder after dividing n by the modulus;
	if the result is less than the default value of K:
		let the result be the result plus the modulus;
	decide on the result.

To decide what list of angles is (u - direction) plus/+ (v - direction):
	decide on the angle list of u plus the angle list of v.

To decide what list of angles is (u - direction) plus/+ (X - list of angles):
	decide on the angle list of u plus x.

To decide what list of angles is (X - list of angles) plus/+ (u - direction):
	decide on x plus the angle list of u.

To decide what list of angles is (X - list of angles) plus/+ (Y - list of angles):
	extend Y to the number of entries in X entries;
	repeat with n running from 1 to the number of entries in X:
		now entry n of X is entry n of X modulo 360 degrees;
		now entry n of Y is entry n of Y modulo 360 degrees;
		let the absolute difference be entry n of X minus entry n of Y;
		if the absolute difference is less than 0 degrees:
			let the absolute difference be 0 degrees minus the absolute difference;
		if entry n of X is 0 degrees and the number of entries in X is not n and entry (n plus 1) in X is 0 degrees:
			now entry n of X is entry n of Y;
		otherwise if entry n of Y is 0 degrees and the number of entries in Y is not n and entry (n plus 1) in Y is 0 degrees:
			do nothing;
		otherwise if the absolute difference is 0 degrees:
			do nothing;
		otherwise if the absolute difference is less than 180 degrees:
			now entry n of X is (entry n of X plus entry n of Y) divided by 2;
		otherwise if the absolute difference is 180 degrees:
			now entry n of X is (entry n of X plus entry n of Y) divided by 2;
		otherwise:
			now entry n of X is (entry n of X plus entry n of Y minus 360 degrees) divided by 2;
		now entry n of X is entry n of X modulo 360 degrees;
	decide on X.

To decide what list of angles is (u - direction) minus/- (v - direction):
	decide on the angle list of u minus the angle list of v.

To decide what list of angles is (u - direction) minus/- (X - list of angles):
	decide on the angle list of u minus X.

To decide what list of angles is (X - list of angles) minus/- (u - direction):
	decide on X minus the angle list of u.

To decide what list of angles is (X - list of angles) minus/- (Y - list of angles):
	extend Y to the number of entries in X entries;
	repeat with n running from 1 to the number of entries in X:
		now entry n of X is entry n of X modulo 360 degrees;
		now entry n of Y is entry n of Y modulo 360 degrees;
		if n is 1:
			now entry n of Y is entry n of Y plus 180 degrees modulo 360 degrees;
		otherwise:
			now entry n of Y is 180 degrees minus entry n of Y modulo 360 degrees;
		let the absolute difference be entry n of X minus entry n of Y;
		if the absolute difference is less than 0 degrees:
			let the absolute difference be 0 degrees minus the absolute difference;
		if entry n of X is 0 degrees and the number of entries in X is not n and entry (n plus 1) in X is 0 degrees:
			now entry n of X is entry n of Y;
		otherwise if the absolute difference is 0 degrees:
			do nothing;
		otherwise if the absolute difference is less than 180 degrees:
			now entry n of X is (entry n of X plus entry n of Y) divided by 2;
		otherwise if the absolute difference is 180 degrees:
			now entry n of X is (entry n of X plus entry n of Y) divided by 2;
		otherwise:
			now entry n of X is (entry n of X plus entry n of Y minus 360 degrees) divided by 2;
		now entry n of X is entry n of X modulo 360 degrees;
	decide on X.

To decide what list of angles is (X - list of angles) normalized:
	let p be false;
	let z be false;
	let n be the number of entries in X;
	while n is at least 1:
		if z is true:
			now entry n of X is 0 degrees;
			decrement n;
			next;
		if p is true:
			now entry n of X is entry n of X minus 180 degrees;
			now p is false;
		now entry n of X is entry n of X modulo 360 degrees;
		if entry n of X is 0 degrees or entry n of X is 180 degrees:
			now z is true;
		otherwise if n is not 1 and entry n of X is greater than 180 degrees:
			now entry n of X is 360 degrees minus entry n of X;
			now p is true;
		decrement n;
	decide on X.

To decide what object is direction/-- at (X - list of angles):
	now X is X normalized;
	if X is {}:
		decide on nothing;
	repeat with u running through directions:
		if the angle list of u is X:
			decide on u;
	decide on nothing.

Directions as Vectors ends here.
