%load the file 
f = 'test';
Data = load(f);

%change the coordinates of x (in the canals that are copied and not in the initial canals)

% Data.C12= (-1)*Data.C12(:, :);
% Data.C15= (-1)*Data.C15(:, :);
% Data.C18= (-1)*Data.C18(:, :);

Data.CE= (-1)*Data.CE(:, :);
Data.CH= (-1)*Data.CH(:, :);
Data.CK= (-1)*Data.CK(:, :);


%choose the canals (for x choose the canal that the coordinates are
%multipied by -1)

%for the head
%x= Data.C12(:,:);
%y= Data.C13(:, :);
%z= Data.C14(:, :);

%for the rod (tige)
%x= Data.C15(:,:);
%y= Data.C16(:, :);
%z= Data.C17(:, :);


%for the hand
% x = Data.C18(:, :);
% y = Data.C19(:, :);
% z = Data.C1A(:, :);

x = Data.CK(:, :);
y = Data.CL(:, :);
z = Data.CM(:, :);



%call the function "correction" for the correction of the tranjectories
[xcor,ycor,zcor] = correction(x,y,z);

%update after correction
%Data.C12 = xcor;
%Data.C13 = ycor;
%Data.C14 = zcor;


% Data.C15 = xcor;
% Data.C16 = ycor;
% Data.C17 = zcor;


% Data.C18 = xcor;
% Data.C19 = ycor;
% Data.C1A = zcor;

Data.CK = xcor;
Data.CL = ycor;
Data.CM = zcor;


%save in a new file
save('test_cor.mat', '-struct', 'Data');

%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotation of the target

%load the file 
f_cor = 'test_cor.mat';
Data_cor = load(f_cor);
a = 0;

%coordinates of the center (casquette)
Cx = Data_cor.CE(:, :);
Cz = Data_cor.CG(:, :);

%coordinates of the target (tige)
Px = Data_cor.CH(:, :);
Pz = Data_cor.CJ(:, :);

%for a = 16:16:300
[Rx,Rz] = rotation_target(a,Cx,Cz,Px,Pz);
%Px = Rx;
%Pz=Rz;
%end

Data_cor.CN = Rx;
Data_cor.CO = Rz;

%save in a new file
save('test_cor_rot.mat', '-struct', 'Data_cor');


