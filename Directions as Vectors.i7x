Directions as Vectors by David Corbett begins here.

Section - Angle kind (for use without Metric Units by Graham Nelson)

Angle is a kind of value.
1 degree (in degrees, singular) or 2 degrees (in degrees, plural) specifies an angle.

Section - Angles

A direction has an angle called the azimuth.
The azimuth of a direction is usually 0 degrees.

A direction has an angle called the inclination.
The inclination of a direction is usually 90 degrees.

Section - Default angles for the standard directions

The azimuth of northeast is 45 degrees.
The azimuth of east is 90 degrees.
The azimuth of southeast is 135 degrees.
The azimuth of south is 180 degrees.
The azimuth of southwest is 225 degrees.
The azimuth of west is 270 degrees.
The azimuth of northwest is 315 degrees.

The inclination of up is 0 degrees.
The inclination of down is 180 degrees.

Section - Transformations

To decide what K is (n - arithmetic value of kind K) modulo/mod (modulus - K):
	let the result be the remainder after dividing n by the modulus;
	if the result is less than the default value of K:
		let the result be the result plus the modulus;
	decide on the result.

To decide what direction is (alpha - angle) clockwise from/of (u - direction):
	decide on the direction at the azimuth of u + alpha and the inclination of u.

To decide what direction is (alpha - angle) anticlockwise/counterclockwise/widdershins from/of (u - direction):
	decide on the direction at the azimuth of u - alpha and the inclination of u.

To decide what direction is direction at (alpha - angle) and (i - angle):
	let i be i modulo 360 degrees;
	if i is at least 180 degrees:
		let i be 360 degrees minus i;
		let alpha be alpha plus 180 degrees;
	if i is 0 degrees or i is 180 degrees:
		let alpha be 0 degrees;
	otherwise:
		let alpha be alpha modulo 360 degrees;
	repeat with u running through directions:
		if the azimuth of u is alpha and the inclination of u is i:
			decide on u;
	decide on nothing.

Directions as Vectors ends here.
