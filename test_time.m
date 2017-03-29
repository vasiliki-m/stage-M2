f_cor = 's10g1_cor_angle.mat';
Data_cor = load(f_cor);

time = change_integr(D);
A = size(time);
% B = size(Data_cor.CzF);
% int = Data_cor.CzG(:,:)*0;
B = size(Data_cor.C1H);
int = Data_cor.C1b(:,:)*0;
time_pos = Data_cor.C1c(:,:);
time_neg = Data_cor.C1d(:,:);

max=[];
st = [];
fin = [];
s_pos = [];
s_neg = [];
table = [];
for i=1:B(2) %B(2) = 55 all the tests
    max(i)=0;
    s_pos(i) = 0;
    s_neg(i) = 0;
    time_pos(:,i) = 0;
    time_neg(:,i) = 0;
    for j=1:A(1) %A(1) = 125 all the lines of the table time
        if time(j) == i
            
            if abs(time(j,4))>abs(max(i))
                max(i) = time(j,4);
                st(i) = time(j,2);
                fin(i) = time(j,3);
            end
            if time(j,4)>=0
                 s_pos(i) = s_pos(i) + time(j,4);
                 time_pos(:,i) = time_pos(:,i) + (time(j,3) - time(j,2))  ;
            else
                 s_neg(i) = s_neg(i) + time(j,4);
                 time_neg(:,i) = time_neg(:,i) + (time(j,3) - time(j,2)) ;
            end
        end
       
    end
    table = cat(1,table,[i,s_pos(i),time_pos(1,i),s_neg(i),time_neg(1,i)]);
    
    
end
for l=1:B(2)
    int(st(l):fin(l),l) = max(l);

end
Data_cor.C1b = int(:,:);
Data_cor.C1c = time_pos(:,:);
Data_cor.C1d = time_neg(:,:);

save('s10g1_cor_angle.mat', '-struct', 'Data_cor');

f = figure;
p = uitable(f, 'data', time,'Position',[20 20 420 300]);
p.ColumnName = {'i','start','end','integral'};

f = figure;
t = uitable(f, 'data', table,'Position',[20 20 420 300]);
t.ColumnName = {'i','sum_pos','time_pos','sum_neg','time_neg'};
