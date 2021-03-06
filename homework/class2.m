% 0.1TS + 0.2*SC <= 1400
% TS <= 8000
% SC <= 5000
% max profit = 0.05*TS + 0.08*SC - 4000/30
c=-[0.05,0.08]';
A=[0.1 0.2];
b=[1400];
L=[8000;5000];
[x,fmin]=linprog(c,A,b,[],[],[],L);
% x = [8000; 3000]
% fmin = -640


% x1 , x2(int)
% 25*8*x1 + 15*8*x2 >= 1800
% x1 <= 8; x2 <= 10
% min (25*8*x1*0.02 + 15*8*x2*0.05)*2 + (8*x1*4 + 8*x2*3)
% min 1192*x1 + 588*x2
c=[40 ; 36];
A=-[200 120];
b=-[1800];
L=[0,0];
U=[8,10];
[x,fmin]=intlinprog(c,[1 2],A,b,[],[],L,U)

% x1 x2 x3
% 0 <= x1; 0 <= x2 <= 5; 0 <= x3
% 0 <= x1 < 7; 0 <= x2 <= 5; 0 <= x3 <=8
% 3*x1 + y12 + y13 <= 20 + y21 + y31
% 3*x2 + y23 + y21 <= 16 + y12 + y32
% 3*x3 + y31 + y32 <= 24 + y13 + y23
% x1 + z21 + z31 = 7
% x2 + z12 + z32 = 13
% x3 + z13 + z23 = 0
% z12 + z13 <= x1
% z21 + z23 <= x2
% z31 + z32 <= x3
% y12 y13 y23 y21 y31 y32
% z12 z13 z23 z21 z31 z32
% min (150*x1 + 120*x2 + 100*x3) + (y12*150 + y13*100 + y23*200 + y21*150 + y31*100 + y32*200)*5000
% + (z12*150 + z13*100 + z23*200 + z21*150 + z31*100 + z32*200)*6000
syms x1 x2 x3 y12 y13 y23 y21 y31 y32 z12 z13 z23 z21 z31 z32
c=[150 120 100 750000 500000 750000 1000000 500000 1000000 900000 600000 900000 1200000 600000 1200000]';
A=[3 0 0 1 1 0 -1 -1 0 0 0 0 0 0 0   
0 3 0 -1 0 1 1 0 -1 0 0 0 0 0 0
0 0 3 0 -1 -1 0 1 1 0 0 0 0 0 0];
b=[20;16;24];
VLB=[0;0;0];
VUB=[7 5 8];
min 150*x1 + 120*x2 + 100*x3 + 750000*y12 + 500000*y13 + 750000*y21 + 1000000*y23 + 500000*y31 + 1000000*y32 + 900000*z12 + 600000*z13 + 900000*z21 + 1200000*z23 + 600000*z31 + 1200000*z32

f=[75;75;50;50;100;100;150;240;210;120;160;220];
A=[1 -1 1 -1 0 0 3 3 0 0 0 0; -1 1 0 0 1 -1 0 0 3 3 0 0;0 0 -1 1 -1 1 0 0 0 0 3 3;0 0 0 0 0 0 0 0 1 1 0 0 ];
b=[20;16;24;5];
Aeq=[0 0 0 0 0 0 1 0 1 0 1 0;0 0 0 0 0 0 0 1 0 1 0 1 ];
beq=[7;13];
L=zeros(12,1);
[x,fval,exitflag,output,lambda]=linprog(f,A,b,Aeq,beq,L)

f=@(x)-x(1)*x(2)*x(3);  
x0=[4;5;6];      
lb=zeros(3,1);       
[x,fval]=fmincon(f,x0,[],[],[],[],lb,[],@cont)
Vmax=-fval
