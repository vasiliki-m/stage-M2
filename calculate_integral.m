function [DD_pos,DD_neg] = calculate_integral(D)
    A=size(D);
    s1=D(:,:);
    s2=D(:,:);
    for i=1:A(2)
        for j=1:A(1)
            if D(j,i)>0 
                s2(j,i) =0; %set to 0 the D(j,i) that they are positive so as to calculate the integral of the D(j,i) negative
            end
            if D(j,i)<0
                s1(j,i) = 0;         
            end   
        end  

    end
    DD_pos = trapz(s1);
    DD_neg = trapz(s2); %calculate the integral of the negative only
end