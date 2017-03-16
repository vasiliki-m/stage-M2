function [a,b]=find_line(x1,z1,x2,z2) %find the line between two points
    a =( z2-z1)/(x2-x1);
    b= z2-a*x2;
end