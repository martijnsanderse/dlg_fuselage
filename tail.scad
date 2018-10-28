//include<HT_05.scad>;
include<HT08.scad>;
include<splines.scad>;

function scale_2d(sx, sy, a) = [for (element = a) [element[0], element[1]] ];

points = HT08;

points10 = scale_2d(100, 100, points);
// points_spline = nSpline(points10, 30);

//echo("points");
//echo(points10);
//echo("points_spline");
//echo(points10);

// polygon(points_spline);

translate([0, 0.5, 0])
polygon(points10);