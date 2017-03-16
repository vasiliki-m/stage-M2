f_cor = 'test_cor_angle2.mat';
Data_cor = load(f_cor);

A=size(Data_cor.Cb);
dx = size(Data_cor.Cb);
dz = size(Data_cor.Cb);
x = size(Data_cor.Cb);
z = size(Data_cor.Cb);
x_proj = Data_cor.Cr(:,:);
z_proj = Data_cor.Cs(:,:);
D = Data_cor.Cl(:,:);
x_vect = Data_cor.Ct(:,:);
z_vect = Data_cor.Cu(:,:);
alpha = size(Data_cor.Cb);
beta = Data_cor.Cv(:,:);
dif_angle = size(Data_cor.Cb);

for i=22:49
   

    for j=1:A(1)  
        x(1,i) = Data_cor.Cj(j,i); %x_menton
        z(1,i) = Data_cor.Ck(j,i);  %z_menton
        x(100,i) = Data_cor.Cp(j,i); %x_cible
        z(100,i) = Data_cor.Cq(j,i); %z_cible
        
        [a,b] = find_line(x(1,i),z(1,i),x(100,i),z(100,i));
        

        dx(j,i) = ( x(100,i)- x(1,i) )/100;
        dz(j,i) = (z(100,i) - z(1,i))/100;
        for k=1:A(1)-2
        %x(j+1,i) = a* x(j,i) + b;
            x(k+1,i) = x(k,i) + dx(j,i) ;
            z(k+1,i) = z(k,i) + dz(j,i);
        end
        
        [x_proj(j,i),z_proj(j,i)] = find_projection(a,b,Data_cor.Ce(j,i),Data_cor.Cg(j,i));
        
        alpha(j,i) = find_angle([Data_cor.Cb(j,i),Data_cor.Cd(j,i)],[Data_cor.Cp(j,i),Data_cor.Cq(j,i)],c);  %angle between tige and target
        beta(j,i) = find_angle([Data_cor.Cb(j,i),Data_cor.Cd(j,i)],[Data_cor.Ce(j,i),Data_cor.Cg(j,i)],c);  %angle between tige and hand
        dif_angle(j,i) = beta(j,i) - alpha(j,i); 

        
        D(j, i) = find_distance(x_proj(j,i),z_proj(j,i), Data_cor.Ce(j,i),Data_cor.Cg(j,i));

        
%         if dif_angle(j,i) < 0
%             D(j,i) = D(j,i)* (-1);
%             
%         end

        if (x_proj(j,i)-Data_cor.Ce(j,i)) < 0 
           
           D(j,i) = D(j,i)*(-1);
           
        end
        
        x_vect(j,i) = Data_cor.Ce(j,i)-x_proj(j,i); %difference between Xpoing and the projection of Xpoing in the line Xmenton-Xcible
        z_vect(j,i) = Data_cor.Cg(j,i)-z_proj(j,i);
       
  

        if i==25 & j==70
           
            subplot(2,1,1);
            plot(x(:,i), z(:,i),'color','red')
            hold on;

          
        end
        if i==25
            subplot(2,1,2);
            plot(x(:,i),z(:,i),'color','red')
            hold on;
        end
    end
    if i==25
        subplot(2,1,2);
        plot(Data_cor.Cj(:,i),Data_cor.Ck(:,i),'color','blue')
        hold on;
        plot(Data_cor.Cp(:,i),Data_cor.Cq(:,i),'color','black')
        hold on;
        plot(Data_cor.Ce(:,i),Data_cor.Cg(:,i),'color','green') %x-z poing
        hold on;
        plot(x_proj(:,i),z_proj(:,i), 'b*')
        hold on;
        %plot([x_vect(:,i),z_proj(:,i)],'g*')
        %disp(D(:,i));
    end
end

%save the data of the new canals
Data_cor.Cl = D(:,:);
Data_cor.Cr = x_proj(:,:); %projection of Xpoing in the line Xmenton - Xcible
Data_cor.Cs = z_proj(:,:);
Data_cor.Ct = x_vect(:,:); 
Data_cor.Cu = z_vect(:,:);
Data_cor.Cv = beta(:,:);

subplot(2,1,1);
plot(x_proj(70,25),z_proj(70,25),'b*')
hold on;
plot(Data_cor.Ce(70,25),Data_cor.Cg(70,25),'go')
hold on;
daspect([1 1 1])

save('test_cor_angle2.mat', '-struct', 'Data_cor');

