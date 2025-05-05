Direction and Dimension by David Corbett begins here.

A direction has a list of numbers called the coordinate list.

The coordinate list of north is {100, 0, 0}.
The coordinate list of northeast is {71, 71, 0}.
The coordinate list of east is {0, 100, 0}.
The coordinate list of southeast is {-71, 71, 0}.
The coordinate list of south is {-100, 0, 0}.
The coordinate list of southwest is {-71, -71, 0}.
The coordinate list of west is {0, -100, 0}.
The coordinate list of northwest is {71, -71, 0}.
The coordinate list of up is {0, 0, 100}.
The coordinate list of down is {0, 0, -71}.

To decide what object is direction/-- at (X - list of numbers) (this is coordinate-direction conversion):
	change X to have 3 entries;
	repeat with U running through directions:
		if the coordinate list of U is X:
			decide on U;
	decide on nothing.

To decide what list of numbers is (u - direction) rotated (theta - number) half-quadrants/half-quadrant/-- around (v - direction) (this is three-dimensional direction rotation around a direction):
	decide on the coordinate list of u rotated theta half-quadrants around the coordinate list of v.

To decide what list of numbers is (u - direction) rotated (theta - number) half-quadrants/half-quadrant/-- around (axis - list of numbers) (this is three-dimensional direction rotation):
	decide on the coordinate list of u rotated theta half-quadrants around the axis.

To decide what list of numbers is (vector - list of numbers) rotated (theta - number) half-quadrants/half-quadrant/-- around (axis - list of numbers) (this is three-dimensional vector rotation):
	let u be entry 1 of the vector;
	let v be entry 2 of the vector;
	let w be entry 3 of the vector;
	let x be entry 1 of the axis;
	let y be entry 2 of the axis;
	let z be entry 3 of the axis;
	let theta be the remainder after dividing theta by 8;
	if theta is negative:
		now theta is theta plus 9;
	otherwise:
		now theta is theta plus 1;
[	let the sine be entry theta of {0, 1, 2, 1, 0, -1, -2, -1};
	let the cosine be entry theta of {2, 1, 0, -1, -2, -1, 0, 1};]
	let the sine be entry theta of {0, 71, 100, 71, 0, -71, -100, -71};
	let the cosine be entry theta of {100, 71, 0, -71, -100, -71, 0, 71};
	let the versine be 100 minus the cosine;
	showme u;
	showme v;
	showme w;
	showme x;
	showme y;
	showme z;
	showme sine;
	showme cosine;
	showme versine;
	let blah be ((u times x) plus (v times y) plus (w times z)) times the versine;
	showme blah;
	now entry 1 of the vector is
		(u times blah) plus
		(x times the cosine) plus
		(((v times z) minus (w times y)) times the sine);
	now entry 2 of the vector is
		(v times blah) plus
		(y times the cosine) plus
		(((w times x) minus (u times z)) times the sine);
	now entry 3 of the vector is
		(w times blah) plus
		(z times the cosine) plus
		(((u times y) minus (v times x)) times the sine);
[	now entry 1 of the vector is
		(u times ((x times x times the versine) plus the cosine) divided by 1) plus
		(v times ((x times y times the versine) minus (z times the sine)) divided by 1) plus
		(w times ((x times z times the versine) plus (y times the sine)) divided by 1);
	now entry 2 of the vector is
		(u times ((x times y times the versine) plus (z times the sine)) divided by 1) plus
		(v times ((y times y times the versine) plus the cosine) divided by 1) plus
		(w times ((y times z times the versine) minus (x times the sine)) divided by 1);
	now entry 3 of the vector is
		(u times ((x times z times the versine) minus (y times the sine)) divided by 1) plus
		(v times ((y times z times the versine) plus (x times the sine)) divided by 1) plus
		(w times ((z times z times the versine) plus the cosine) divided by 1);]
	showme vector;
	decide on the vector.

Direction and Dimension ends here.
