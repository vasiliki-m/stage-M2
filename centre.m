%load the file
f_cor = 'test_cor_angle.mat';
Data_cor = load(f_cor);

A=size(Data_cor.CH);

%the new canals
a_rot = Data_cor.CP(:,:);
x_cible = Data_cor.CQ(:,:);
z_cible = Data_cor.CR(:,:);
x_menton = Data_cor.CS(:,:);
z_menton = Data_cor.CT(:,:);
x_tige_calculate = Data_cor.CU(:,:);
z_tige_calculate = Data_cor.CV(:,:);


for i=22:49 
    
    
    n = 380;
   
    r = 450;
   
    m = 550;
    
    %choose 3 points of the courbe x-z tige
    P1 = [Data_cor.CH(n,i),Data_cor.CJ(n,i)];
    P2 = [Data_cor.CH(r,i),Data_cor.CJ(r,i)];
    P3 = [Data_cor.CH(m,i),Data_cor.CJ(m,i)];


    %find the point in the middle of 2 points
    M_P1P2 = [((P1(1)+P2(1))/2),((P1(2)+P2(2))/2)];
    M_P2P3 = [((P2(1)+P3(1))/2),((P2(2)+P3(2))/2)];

    %do the rotation of the points of the courbe for 90° and find the
    %perpendicular 
    a = 90;
    [Rx1,Rz1] = rotation_target(a,M_P1P2(1),M_P1P2(2),P1(1),P1(2));
    [Rx2,Rz2] = rotation_target(a,M_P1P2(1),M_P1P2(2),P2(1),P2(2));

    [Rx2b,Rz2b]=rotation_target(a,M_P2P3(1),M_P2P3(2),P2(1),P2(2));
    [Rx3,Rz3] = rotation_target(a,M_P2P3(1),M_P2P3(2),P3(1),P3(2));
    
    %draw the line 
    [a,b] = find_line(Rx1,Rz1,Rx2,Rz2);
    [k,l] = find_line(Rx2b,Rz2b,Rx3,Rz3);

    %find the center of the courbe
    Center_x = (l - b) / (a - k);
    Center_z = a * Center_x + b;
    c=[Center_x,Center_z];
    %r(:,i) = sqrt((c(1)- P2(1))^2+(c(2)- P2(2))^2 )
    
    %find rotation's angle
    for j=1:(A(1)-1)
        p0 = [Data_cor.CH(j,i),Data_cor.CJ(j,i)];
        p1 = [Data_cor.CH(j+1,i),Data_cor.CJ(j+1,i)]; 
        a_rot(j,i) = find_angle(p0,p1,c) ;
        
    end
%     MAX = max(a_rot(:,i));
%     pos = find(a_rot(:,i)==MAX);
%     
%     for t=pos:(A(1)-1)
%         a_rot(t,i)= 360-a_rot(t,i);
%     end
    
    
    %plot the results
    if i==35
        plot([Rx1 Rx2],[Rz1 Rz2],'color','red')
        hold on;
        plot([Rx2b Rx3],[Rz2b Rz3],'color','red')
        hold on;
        plot([Center_x],[Center_z],'*')
        hold on;
        plot(Data_cor.CH(:,i),Data_cor.CJ(:,i))
        hold on;
        plot([P1(1) P2(1)], [P1(2) P2(2)])
        hold on;
        plot([P2(1) P3(1)], [P2(2) P3(2)])
    end
    
    %initialization for the coordinates of the target 
    x_tige_init = Data_cor.CH(10,1); %Calibration x_tige
    z_tige_init = Data_cor.CJ(10,1); %Calibration z_tige
    
    x_cible(1,i)=0.2954;      %Calibration x_poing    
    z_cible(1,i) = 0.51866;     %Calibration z_poing   
    
    
    x_tige_rot = Data_cor.CH(10,i); %Initial x for the rotation
    z_tige_rot = Data_cor.CJ(10,i); %Initial z for the rotation
    
%     dx_init =abs(x_cible(1,i) - x_tige_init);
%     dz_init = abs(z_cible(1,i) - z_tige_init);  %z_tige_rot; 

%     dx_init = x_tige_rot - x_tige_init;
%     dz_init = z_tige_rot - z_tige_init;
% 
%     x_cible(1,i) = x_cible(1,i) + dx_init;
%     z_cible(1,i) = z_cible(1,i) + dz_init;
%     x_cible(1,i) = x_tige_rot + dx_init;
%     z_cible(1,i) = z_tige_rot + dz_init;

%     d = sqrt(((x_tige_init-x_tige_rot)^2)+((z_tige_init-z_tige_rot)^2));
%     
%     x_cible(1,i) = x_cible(1,i)+d;
%     z_cible(1,i) = z_cible(1,i)+d;
    
 
     angle_tige = find_angle([x_tige_init,z_tige_init],[x_tige_rot,z_tige_rot],c); %angle between the 'tige'
     [x_cible(1,i),z_cible(1,i)] = rotation_target(-angle_tige,Center_x,Center_z, x_cible(1,i), z_cible(1,i)); 

    
    
    %x_cible(1,i) = Data_cor.CH(1,i);%-0.2954; %(X_poing in Calibration)
    %z_cible(1,i) = Data_cor.CJ(1,i);%0.51866; %(Z_poing in Calibration)
    %[x_cible(1,i),z_cible(1,i)] = rotation_target(-16,Center_x,Center_z,Data_cor.CH(1,i),Data_cor.CJ(1,i));
    
    
    %[x_cible(1,i),z_cible(1,i)] = rotation_target(-16,Center_x,Center_z,x_cible(1,i),z_cible(1,i));

    
    x_menton(1,i) = Data_cor.CK(10,i); %X_poing in rotation
    z_menton(1,i) = Data_cor.CM(10,i);
    
    x_tige_calculate(1,i) = Data_cor.CH(1,i);
    z_tige_calculate(1,i) = Data_cor.CJ(1,i);


    %find all the coordinates of the courbe
    for j=1:A(1)-1
         [x_cible(j+1,i),z_cible(j+1,i)] = rotation_target( a_rot(j,i),Center_x,Center_z,x_cible(j,i),z_cible(j,i));
         [x_menton(j+1,i),z_menton(j+1,i)] = rotation_target(a_rot(j,i),Center_x,Center_z,x_menton(j,i),z_menton(j,i));
         [x_tige_calculate(j+1,i),z_tige_calculate(j+1,i)] = rotation_target(a_rot(j,i),Center_x,Center_z,x_tige_calculate(j,i),z_tige_calculate(j,i));
    end

end


%find the coordinates of static in the beginning 
%angle2 = find_angle([Data_cor.CH(10,1),Data_cor.CJ(10,1)],[0.2954,0.51866],c); %angle between 'tige' and target in the calibration



for i=1:21
    x_cible(:,i)=0.2954;      %Calibration x_poing    
    z_cible(:,i) =0.51866;     %Calibration z_poing   
    
    angle_tige2 = find_angle([Data_cor.CH(10,1),Data_cor.CJ(10,1)],[Data_cor.CH(10,i),Data_cor.CJ(10,i)],c);
    [x_cible(:,i),z_cible(:,i)] = rotation_target(angle_tige2,Center_x,Center_z,x_cible(:,i),z_cible(:,i)); %rotation of the coordinates of the 'tige'

    
    x_menton(:,i) = Data_cor.CK(10,i); %Xpoing
    z_menton(:,i) = Data_cor.CM(10,i); %Zpoing


%     for j=2:A(1)
%         x_menton(j,i) = Data_cor.CK(10,i); %Xpoing
%         z_menton(j,i) = Data_cor.CM(10,i); %Zpoing
        
        
%         dx_init = Data_cor.CH(j,i) - Data_cor.CH(j,1);
%         dz_init = Data_cor.CJ(j,i) - Data_cor.CJ(j,1);
%     
%         x_cible(j+1,i) = x_cible(j,i) + dx_init;
%         z_cible(j+1,i) = z_cible(j,i) + dz_init;
% 
        
       % angle_tige2 = find_angle([Data_cor.CH(j,i),Data_cor.CJ(j,i)],[Data_cor.CH(j+1,i),Data_cor.CJ(j+1,i)],c); %angle between the 'tige'

      %  [x_cible(j,i),z_cible(j,i)] = rotation_target(-angle2,Center_x,Center_z,Data_cor.CH(j,1),Data_cor.CJ(j,1)); %rotation of the coordinates of the 'tige'
    %end
end

%find for the coordinates of static in the end
for i=50:54
    x_cible(:,i)=0.2954;      %Calibration x_poing    
    z_cible(:,i) = 0.51866;     %Calibration z_poing   
    
    angle_tige3 = find_angle([Data_cor.CH(10,1),Data_cor.CJ(10,1)],[Data_cor.CH(10,i),Data_cor.CJ(10,i)],c);
    [x_cible(:,i),z_cible(:,i)] = rotation_target(angle_tige3,Center_x,Center_z,x_cible(:,i),z_cible(:,i)); %rotation of the coordinates of the 'tige'

    
    
    x_menton(:,i) = Data_cor.CK(10,i);
    z_menton(:,i) = Data_cor.CM(10,i);


%     for j=2:A(1)
%         x_menton(j,i) = Data_cor.CK(10,i);
%         z_menton(j,i) = Data_cor.CM(10,i);
        

%         dx_init = Data_cor.CH(j,i) - Data_cor.CH(j,1);
%         dz_init = Data_cor.CJ(j,i) - Data_cor.CJ(j,1);
%     
%         x_cible(j+1,i) = x_cible(j,i) + dx_init;
%         z_cible(j+1,i) = z_cible(j,i) + dz_init;

        
       %angle_tige3 = find_angle([Data_cor.CH(j,1),Data_cor.CJ(j,1)],[Data_cor.CH(j+1,i),Data_cor.CJ(j+1,i)],c); %angle between the 'tige'

        %[x_cible(j,i),z_cible(j,i)] = rotation_target(-angle3,Center_x,Center_z,x_cible(j,1),z_cible(j,1)); %rotation of the coordinates of the 'tige'

        %[x_cible(j,i),z_cible(j,i)] = rotation_target(-16,Center_x,Center_z,Data_cor.CH(j,i),Data_cor.CJ(j,i));
    %end
end



%update data after rotation
Data_cor.CP = a_rot(:,:);

%plot(a_rot(:,35))
Data_cor.CQ = x_cible(:,:);
Data_cor.CR = z_cible(:,:);

%so the 'bidon' is not empty
Data_cor.CQ(:,29) = x_cible(:,28);
Data_cor.CQ(:,37) = x_cible(:,28);
Data_cor.CR(:,29) = z_cible(:,28);
Data_cor.CR(:,37) = z_cible(:,28);


Data_cor.CS = x_menton(:,:);
Data_cor.CT = z_menton(:,:);
%so the 'bidon' is not empty
Data_cor.CS(:,29) = x_menton(:,28);
Data_cor.CS(:,37) = x_menton(:,28);
Data_cor.CT(:,29) = z_menton(:,28);
Data_cor.CT(:,37) = z_menton(:,28);


Data_cor.CU = x_tige_calculate(:,:);
Data_cor.CV = z_tige_calculate(:,:);



%save in a new file
save('test_cor_angle3.mat', '-struct', 'Data_cor');


