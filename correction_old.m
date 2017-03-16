% Correction of the trajectories
function [xcor,ycor,zcor] = correction(xtete,ytete,ztete)
    
    xcor=xtete;
    ycor=ytete;
    zcor = ztete;
    A=size(xcor);
    %for each colonne (every test)
    for k=1:A(2)
        %for every line (time)
        for i=1:(length(xcor(:,k))-1)
            %calculate the difference of every couple of points 
            df_x = xcor(i+1,k)- xcor(i,k);
            df_y = ycor(i+1,k)- ycor(i,k);
            df_z = zcor(i+1,k)- zcor(i,k);
            
            %use a threshold
            if abs(df_x)>=0.2;
                xcor(i+1,k)= mean(abs(xcor(i,k)):abs(xcor(i-1,k)));
            
            elseif abs(df_y)>=0.2;
                ycor(i+1,k)=  mean(abs(ycor(i,k)):abs(ycor(i-1,k)));
            
            elseif abs(df_z)>=0.2;
                zcor(i+1,k)= mean(abs(zcor(i,k)): abs(zcor(i-1,k)));
            end
        end

    end
    
    
end
