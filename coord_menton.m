A=size(Data_cor.CH);
d=zeros(A(1),A(2));
x_menton =zeros(A(1),A(2));


for i=1:A(2) %54
    for j=1:(A(1)-1) %600
        d(j,i) = Data_cor.CH(j+1,i)-Data_cor.CH(j,i);
        x_menton2 = x_menton(i,j) + d(j,i);
        
    end
end



x_menton2 = x_menton + d(1,1)