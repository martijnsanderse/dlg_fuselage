include<ag13.scad>;

// (x/a)^2 + (y/b)^2 = 1

// (y/b) = (1 - (x/a)2)^0.5
// y = b*(1 - )

stepsize = 2;
a = 8;
b = 2;

function ellipse_x(i) =  a * sin(i);
function ellipse_y(i) = b * cos(i);

function scale_2d(sx, sy, a) = [a[0]*sx, a[1]*sy];

points =  [ for (i = [0: stepsize: 90]) [ellipse_x(i), ellipse_y(i)] ];

echo(points);
//points_plot = concat(points, [[0,0]]);
//polygon (points_plot);
//polygon(ag13);

hull () {
    for (i = [0:len(points)-1]) {
//for (i = [0:1]) {
    //hull() {
        x_1 = points[i][0];
        y_1 = points[i][1];

        // x_2 = points[(i+1)][0];
        // y_2 = points[(i+1)][1];

        // echo (x_1, y_1, x_2, y_2);

        translate([ (-3*y_1/4), 0, x_1 ])
        linear_extrude(height = 0.01) {
            scale([y_1, y_1])
            polygon(ag13);
        }

        // translate([ (-1*y_2/2), 0, x_2 ])
        // linear_extrude(height = 0.1) {
        //     scale([y_2, y_2])
        //     %polygon(ag13);
        // }
    }
}

