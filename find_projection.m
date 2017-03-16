function [x_proj,z_proj] = find_projection(a,b,x,z)
%     x_proj = (x - a*b + a*z)/(1+a^2);
%     z_proj = a*x_proj+b;
    d = z + (1/a) * x;
    c = -1/a;
    x_proj = (d-b)/(a-c);
    z_proj = a*x_proj + b;
end

