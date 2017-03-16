% Correction of the trajectories
function [xcor,ycor,zcor] = correction(x,y,z)
    
    xcor=x(:,:);
    ycor=y(:,:);
    zcor = z(:,:);
    A=size(xcor);
    e = 11; %nb of errors
    s = 0.02; %threshold
    %for each colonne (every test)
    for k=1:A(2)
        %for every line (time)
        for i=1:(length(xcor(:,k))-1)
            %calculate the difference of every couple of points 
            df_x = xcor(i+1,k)- xcor(i,k);
            df_y = ycor(i+1,k)- ycor(i,k);
            df_z = zcor(i+1,k)- zcor(i,k);
            
            %use a threshold
            %for the axe x0x'
            if abs(df_x)>=s 
                l = -1;
                t=0;
                for j=i+2:i+e
                    if j>length(xcor(:,k));
                        break;
                    end
                    df_x = xcor(i,k) - xcor(j,k);
                    t= t+1;
                    if abs(df_x)<=s
                        l = j;
                        
                        break   
                    end     
                 end
                 if l>0
                     gap_x =(xcor(l,k)- xcor(i,k))/t;
                     for m=i+1:l
                         xcor(m,k)=xcor(m-1,k)+ gap_x; 
                     end
                 end
            end
          
          
            %for the axe y0y'
            if abs(df_y)>=s
                l = -1;
                t=0;
                for j=i+2:i+e
                    if j>length(xcor(:,k));
                        break;
                    end
                    df_y = ycor(i,k) - ycor(j,k);
                    t=t+1;
                    if abs(df_y)<=s
                        l = j;
                        break 
                    end
                end
                if l>0
                    gap_y =(ycor(l,k)- ycor(i,k))/t;
                    for m=i+1:l
                        ycor(m,k)=ycor(m-1,k) + gap_y;
                    end
                end
            end
            
            %for the axe z0z'
            if abs(df_z)>=s
                l = -1;
                t=0;
                for j=i+2:i+e
                    if j>length(xcor(:,k));
                        break;
                    end
                    df_z = zcor(i,k) - zcor(j,k);
                    t=t+1;
                    if abs(df_z)<=s
                        l = j;
                        break
                    end
                end
                if l>0
                    gap_z = (zcor(l,k)- zcor(i,k))/t;
                    for m=i+1:l
                        zcor(m,k)=zcor(m-1,k) + gap_z;
                    end
                end
            end
        end
    end    
end
