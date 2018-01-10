resolution = 100;

thiccness = 0.04;
//for the 1 inch long piece, open on both ends
c1_inner = 0.5/2;
c1_outer = c1_inner + thiccness;
c1_len = 1;

c2_inner = 0.517/2;
c2_outer = c2_inner + thiccness;
c2_len = 1.4;

module pipe(outer,inner,length)
{
    linear_extrude(length, center = true)
        difference()
            {
                circle(r = outer, $fn = resolution, center = true);
                circle(r = inner, $fn = resolution, center = true);
            }
}

module tbone()
{
    difference(){
        hull()
        {
            pipe(c1_outer, c1_inner, c1_len);
                translate(v = [0,c2_len/2,0])
                    rotate([90,0,0])
                        pipe(c2_outer, c2_inner, c2_len);

        }
        union()
        {
            linear_extrude(c1_len+0.1, center = true)
                        circle(r = c1_inner, $fn = resolution, center = true);
            translate(v = [0,c1_outer+(c2_len),0])
                            rotate([90,0,0])
                                linear_extrude(c2_len)
                                    circle(r = c2_inner, $fn = resolution, center = true);
            
        }
        
                    }//difference
}

tbone();