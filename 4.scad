/**
Your part should slide onto a 1x2” rectangular tube. It needs to have a crossways hole which is 1.125” in diameter to allow for the insertion of a bearing. And, it needs to have a location to insert/mount a 2.5” diameter CIM motor on top. The distance between the center of the shaft and the center of the bearing holes should correspond to 96 tooth spacing, which is 2.403”. The CIM motor requires two mounting holes that are 2” apart, diametrically opposed and 0.2” in diameter for its #10-32 screws, and also requires a 0.75” hole for its front. Also see: complete specs for the CIM motor, complete specs for the VEX Clamping Gearbox
Additionally, please remember that your (plastic) part is going to support the weight of the robot, so prefer thick walls to thin walls.
**/

//CIM motor insertion well is 2.5in diameter
resolution = 100;

base_dimensions = [1,2.5];
thickness = 0.2;

crossways_hole_offset = 0.4;
crossways_hole_radius = 1.125/2;

circle_transformation = [0,0,2*thickness + 2*crossways_hole_offset + 2*crossways_hole_radius + base_dimensions[1]/4];
circle_rotation = [90,0,90];

mounting_hole_radius = 0.1;
mounting_hole_spacing = 1-0.2; //from center of CIM

center_hole_radius = 0.75/2;

ventilation_strip_thickness = 0.2;

module solid_block()
{
    union()
    {
        //base "rectangular prism" section
        linear_extrude(circle_transformation[2])
            square(base_dimensions, center = true);
        
        translate(v=circle_transformation)
            rotate(circle_rotation)
                linear_extrude(base_dimensions[0], center = true)
                    circle(r=base_dimensions[1]/2, $fn = resolution);
    }
}

module circle_cutouts()
{
    translate(v=circle_transformation)
        rotate(circle_rotation)
            linear_extrude(base_dimensions[0], center = true)
                union()
                {
                    circle(r=base_dimensions[1]/2, $fn = resolution);
                }
}

module crossways_hole()
{
    translate(v=[0,0,crossways_hole_offset+crossways_hole_radius])
        rotate(circle_rotation)
            cylinder(h = base_dimensions[0]+0.1, r = crossways_hole_radius, center = true, $fn = resolution);
}

module mounting_well()
{
    translate([-thickness,0,0])
        translate(circle_transformation)
            rotate(circle_rotation)
                cylinder(h = base_dimensions[0], r = base_dimensions[1]/2 -thickness, center = true, $fn = resolution);
}


module mounting_holes()
{
    union()
    {
        translate([base_dimensions[0]/2 - thickness/2,mounting_hole_spacing,0])
            translate(circle_transformation)
                rotate(circle_rotation)
                    cylinder(h=thickness+0.1, r=mounting_hole_radius, center = true, $fn = resolution);
        translate([base_dimensions[0]/2 - thickness/2,-mounting_hole_spacing,0])
            translate(circle_transformation)
                rotate(circle_rotation)
                    cylinder(h=thickness+0.1, r=mounting_hole_radius, center = true, $fn = resolution);
    }
}


module center_CIM_hole()
{
    translate([base_dimensions[0]/2 - thickness/2,0,0])
        translate(circle_transformation)
            rotate(circle_rotation)
                cylinder(h = thickness+0.1, r = center_hole_radius, center = true, $fn = resolution);
}


module prism_cutout()
{
    translate(v=[0,0,thickness+crossways_hole_radius])
        cube(size=[base_dimensions[0]-(2*thickness),base_dimensions[1]+0.1,crossways_hole_radius * 2],center = true);
}


module ventilation_circle()
{
    translate(circle_transformation)
            rotate(circle_rotation)
                difference()
                {
                    cylinder(h = ventilation_strip_thickness, r = 0.001 + base_dimensions[1]/2, center = true, $fn = resolution);
                    cylinder(h = ventilation_strip_thickness, r = -0.001 + base_dimensions[1]/2 -thickness, center = true, $fn = resolution);
                }
}

module cutouts()
{
    union()
    {
        crossways_hole();
        mounting_well();
        mounting_holes();
        center_CIM_hole();
        prism_cutout();
        ventilation_circle();
    }
}

//TOP LEVEL GEOMETRY

difference(){
    solid_block();
    cutouts();
}

//prism_cutout();
