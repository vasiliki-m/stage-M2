function time = change_integr(D)
    A=size(D);
    %h={'Test' 'Start'  'End' 'Integral'};
    time=[];
   
    integral=[];
    for i=1:A(2)
        last_j=1;
        for j=2:A(1)
            if D(j-1,i) >0 && D(j,i) <= 0 %if there is a change in the sign
                integral = trapz(D(last_j:j-1,i));
                time = cat(1,time,[i,last_j,j-1,integral]); %create a table with 4 columnes with: 'N°Test','Start','End','Integral' 
                last_j = j; %update the 1st point
            end
            if D(j-1,i) <0 && D(j,i) >= 0 
                integral = trapz(D(last_j:j-1,i));
                time = cat(1,time,[i,last_j,j-1,integral]);
                last_j = j;
            end
        end
        integral = trapz(D(last_j:100,i));%j-1  %calculate if there is not a change in the sign
        time =cat(1,time,[i,last_j, 100,integral]); 
    end
    %time = [h;num2cell(time)];
 end
