function a_rot = find_angle(p0,p1,c) 
  
    d_p0p1 = sqrt((p0(1)-p1(1))^2 + (p0(2)-p1(2))^2);
    d_cp0 = sqrt((c(1)-p0(1))^2 + (c(2)-p0(2))^2);
    d_cp1 = sqrt((c(1)-p1(1))^2 + (c(2)-p1(2))^2);
    a_rot = acosd((d_cp1^2 + d_cp0^2 - d_p0p1^2)/(2*d_cp0*d_cp1));
    %a_rot =mod(-180/pi * a_rot, 360);
    
  
end