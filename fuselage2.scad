//include<dotSCAD/src/bezier_curve.scad>;
//include<dotSCAD/src/hull_polyline3d.scad>;

use<2d_points/2d_points.scad>;
include<ag13.scad>;
include<es9051.scad>;
include<g-rx6.scad>;
include<lipo.scad>;

$fn=20;

points = [
    [0, 5],
    [2, 0],
    [0, -5]
];
//
//$fn=50;
//rotate_extrude(convexity = 10)
////translate([0, 0, 0])
//polygon(points = [[0,5],[2,0],[0, -5]]);
//

//t_step = 0.05;
//width = 2;
//
//p0 = [0, 0, 0];
//p1 = [40, 60, 35];
//p2 = [-50, 90, 0];
//p3 = [0, 200, -35];
//
//points = bezier_curve(t_step, 
//	    [p0, p1, p2, p3]
//	);
//    
//hull_polyline3d(points, width);

seg1=[[0,0], [0, 10], [10, 10], [10, 0]];
seg2=[[0,0], [-5, 10], [15, 10], [10, 0]];
seg3=[[0,0], [-5, 5], [15, 15], [10, 0]];
seg4=[[0,0], [0, 10], [5, 15], [10, 10], [10, 0]];
    
//    color([0.9,0.4,0.9]) polygon(seg1);
//    linear_extrude(height=2) polygon(bezier_points(seg1));
//    
//    translate([15, 0, 0]) {
//        color([0.9,0.4,0.9]) polygon(seg1);
//        linear_extrude(height=2) polygon(bezier_points(seg1, fn=5));
//    }
//    
//    translate([35, 0, 0]) {
//        color([0.9,0.4,0.9]) polygon(seg2);
//        linear_extrude(height=2) polygon(bezier_points(seg2));
//    }
//    
//    translate([60, 0, 0]) {
//        color([0.9,0.4,0.9]) polygon(seg3);
//        linear_extrude(height=2) polygon(bezier_points(seg3));
//    }
//    
//    translate([80, 0, 0]) {
//        color([0.9,0.4,0.9]) polygon(seg4);
//        linear_extrude(height=2) polygon(bezier_points(seg4));
//    }
    
fuse_points = [
    [0, 1],
    [1, 1],
    [2, 2],
    [3, 3],
    [2.0, 10],
    [2.6, 20],
    [0, 22],
    [0.65, 23],
    [0.65, 40]//,
    // [0, 40]
];

my_fn = 200;

function concatenate(L1, L2) = [for(L=[L1, L2], a=L) a];
function scale_2d(sx, sy, a) = [a[0]*sx, a[1]*sy];

fuse_points_scaled = [for (fp = fuse_points ) scale_2d(7.5, 10, fp) ];
bezier_points = bezier_points(fuse_points_scaled, fn=my_fn);
// add a point so the polygon starts and ends on the y-axis.
// otherwise the rotate_extrude won't render.
bezier_points_fix = concat( bezier_points, [[0,400]]);

module fuselage() {
    //polygon(fuse_points);
    //polygon(bezier_points(fuse_points, fn=50));
    rotate_extrude(convexity=2, $fn=my_fn)
    polygon(bezier_points_fix);
}

module half_wing() {
    scalexy = 157.5; // ag13 airfoil is 1mm root chord
    intersection() {
        translate([0,0,-10])
        rotate([-5, 0, 0])
        linear_extrude(height=scalexy) {
            scale([scalexy,scalexy]) {
                polygon(ag13);
            }
        };
        translate([0, -scalexy/2, 0])
        scale([scalexy, scalexy, scalexy])
        cube([1.5,1.5,1.5]);
    };
}

module wing () {
    half_wing();
    mirror(v=[0,0,1]) half_wing();
}

module saddle () {

    hull() {
        cylinder(h=20, r=5, $fn=my_fn);
        
        translate ([0, 120, 0])
        cylinder(h=25, r=5 , $fn=my_fn);
        // this smaller cylinder makes for a sort of ramp.
        translate ([0, -50, 0])
        cylinder(h=10, r=3, , $fn=my_fn);
    }

}

//intersection () {
    // select a segment for printing
    // lower half  (front)
    // translate([-50, -50, 0])
    // cube([100, 100, 100]);
    
    //middle
    // translate([-50, -50, 100])
    // cube([100, 100, 100]);

    //middle 2
//    translate([-50, -50, 200])
//    cube([100, 100, 50]);

    // tail
    // translate([-50, -50, 250])
    // cube([100, 100, 150]);    

    difference() {    
        union() {
            //scale([7.5,7.5,10])
            fuselage();

            // translate([0,13,100]) {
            //     rotate([90,0,0])
            //     rotate([0,0,90])
            //     color("gray")
            //     es9051();
            //     translate([8.5,0, 0])
            //     rotate([90,0,0])
            //     rotate([0,0,90])
            //     color("gray")
            //     es9051();
            // }

            // translate([7, 3.5, 20])
            // rotate([90,0,0])
            // rotate([0,0,90])
            // color("teal")
            // g_rx6();

            // translate([10, 3.5, 50])
            // rotate([90,0,0])
            // rotate([0,0,90])
            // color("green")
            // lipo();

            translate([0, 0, 155])
            rotate([90,0,0])
            saddle();
        }


        union() {
            // cut out the shape of the wing, and everything above it.
            hull () {
                translate([0, -16, 140])
                rotate([0,-90,180])
                wing();
                // translate([0, -15, 300])
                // rotate([0,-90,180])
                // wing();
            };

            //boom
            translate([0,0,20])
            color("red")
            cylinder(d=7.0, h=500);


        // //     //hatchs

        }

     }
//}

// translate([0,13,100]) {
//     rotate([90,0,0])
//     rotate([0,0,90])
//     color("gray")
//     es9051();
//     translate([8.5,0, 0])
//     rotate([90,0,0])
//     rotate([0,0,90])
//     color("gray")
//     es9051();
// }

// translate([7, 3.5, 20])
// rotate([90,0,0])
// rotate([0,0,90])
// color("teal")
// g_rx6();

// translate([10, 3.5, 50])
// rotate([90,0,0])
// rotate([0,0,90])
// color("green")
// lipo();

//boom
//color("blue")
//cylinder(r=0.5, h=80);