//include<dotSCAD/src/bezier_curve.scad>;
//include<dotSCAD/src/hull_polyline3d.scad>;

use<2d_points/2d_points.scad>;
include<ag13.scad>;
include<es9051.scad>;
include<g-rx6.scad>;
include<lipo.scad>;

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
    [1.5, 22],
    [1, 23],
    [1, 30]
];

module fuselage() {
    %polygon(fuse_points);
    polygon(bezier_points(fuse_points, fn=50));
    rotate_extrude(convexity=10, $fn=50)
    polygon(bezier_points(fuse_points, fn=50));
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

// difference() {
    
    union() {
        %scale([7.5,7.5,10])
        fuselage();

        translate([0,13,100]) {
            rotate([90,0,0])
            rotate([0,0,90])
            color("gray")
            es9051();
            translate([8.5,0, 0])
            rotate([90,0,0])
            rotate([0,0,90])
            color("gray")
            es9051();
        }

        translate([7, 3.5, 20])
        rotate([90,0,0])
        rotate([0,0,90])
        color("teal")
        g_rx6();

        translate([10, 3.5, 50])
        rotate([90,0,0])
        rotate([0,0,90])
        color("green")
        lipo();
        }

    union() {
        translate([0, -10, 150])
        rotate([0,-90,180])
        wing();

        //hatchs

    }
// }

//boom
//color("blue")
//cylinder(r=0.5, h=80);