resolution = 100;

body_ra = 0.5;
body_thickness = 0.4;

cone_height = 0.2;
cone_base_rad = 0.2;
bevel_height = 0.02;

axis_radius = 0.2;
axis_height = 0.8;


module axis(radius)
{
    translate(v=[0,0,cone_height+body_thickness])
    linear_extrude(axis_height, center = false)
    circle(axis_radius, $fn = resolution);
}

module body()
{
    translate(v=[0,0,cone_height])
    linear_extrude(body_thickness, center = false)
    circle(body_ra, $fn = resolution);
}

module cone()
{
    cylinder(r1=0, r2=cone_base_rad, h=cone_height, $fn = resolution, center = false);
}

module top()
{
    translate(v=[0,0,-bevel_height])
    {
        
            axis(axis_radius);
            body();
            difference()
            {
                cone();
                linear_extrude(bevel_height, center = false)
                    circle(cone_base_rad, $fn = resolution, center = true);
            }
        
    }
}

top();