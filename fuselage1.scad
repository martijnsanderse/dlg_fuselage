


// experiment one. 
// place a bunch of points and hull them into a solid


points = [ [0,0,0],
           [10, 0, 0],
           [10, 10, 0],
           [0, 10, 0],
           [0,0, 10],
           [10, 0, 10],
           [10, 10, 10],
           [0, 10, 10] ];
           
hull() 
for (i = [0 : 1 : 8]) {
    translate(points[i]) sphere(r=1, $fn=20);
}

rs = [ 3, 3.1, 3.3, 3.7, 4.0, 3.7, 3.3, 3.1, 3.0, ];

hull() {
    for (i = [0 : 3 : 30]) {
        translate([0,30,i*15]) sphere(r=10*sin(i*5)+10, $fn=20);
    }
}