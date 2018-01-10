inner_radius = 3/8;
outer_radius = 0.5; 
length = 2.5;

module hex_projection(ra)
{
    circle(ra, $fn = 6, center = true);
    
    }
    
module flat_hex(ri,ro)
    {
            difference()
                {
                    hex_projection(ro);
                    hex_projection(ri);
                }
    }
    
module extruded_hex(radius, height)
    {
            linear_extrude(height = height,
        center = true, convexity = 10, twist = 0, slices = 40, 
        scale = 1.0) {hex_projection(radius);}
    }
    
module adapter_projection(inner,outer,le)
    {
        translate(v=[0,0,le/2])
        difference()
        {
            
            extruded_hex(outer, le);
            extruded_hex(inner, le+0.5);
            
        }
    }
    
//----------------
    
adapter_projection(inner_radius, outer_radius, length);
//flat_hex(inner_radius, outer_radius);