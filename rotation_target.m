function [Rx,Rz] = rotation_target(a,Cx,Cz,Px,Pz) %rotation of the target in 2D
    %a: angle 
    %C: center coordinates
    %P: target coordinates
    
    %a = a*pi/180; %(a in rad)
    %translation of the center
    x= Px- Cx;
    z= Pz- Cz;
    
    
    %Rotation around a point
    %x_ = x*cosa - z*sina
    %z_ = x*sina + z*cosa
    x_ =cosd(a)*(x+z) - z*(cosd(a)+ sind(a)); %cosd and sind for an argument in degrees (a=16°)
    z_ = x*(sind(a)-cosd(a))+(z+x)*cosd(a);
   
    
    
    %Translation of the center to the initial place
    Rx = x_ + Cx; 
    Rz = z_ + Cz;
   

end