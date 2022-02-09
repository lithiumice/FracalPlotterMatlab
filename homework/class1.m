a=[0.8147    0.9058    0.1270    0.9134    0.6324    0.0975    0.2785    0.5469    0.9575    0.9649    0.1576    0.9706    0.9572    0.4854    0.8003    0.1419    0.4218    0.9157    0.7922    0.9595]
a_max = max(a)
a_min = min(a)
a_sum = sum(a)
a_mean = mean(a)
a_sort = sort(a)

rand_mat = randn(4,5) %随机矩阵
one_mat = ones(1,5) %行矩阵
five_mat = [rand_mat ; one_mat] %拼接
diag_mat = diag(five_mat) %对角矩阵
upper_mat = triu(five_mat) %上三角
lower_mat = tril(five_mat) %下三角
five_mat([4 2],:) = five_mat([2 4],:) %对换2,4行
inv_mat = inv(five_mat) %新矩阵逆矩阵

rand_num = rand(1,120)
[max_rand,max_pos] = max(rand_num)
[min_rand,min_pos] = min(rand_num)
[counts,center] = hist(rand_num,6)

syms x y
y = (1+x+atan(x))/(1+x^2)
h=ezplot(y,[-2,2])
set(h,'Color','g')
int(y,[-2,2])

syms x y
s = solve(y == cos(x), y == tan(x), x, y);
X1 = eval(s.x(3));
Y1 = eval(s.y(3));
s = solve(y == cos(x), y == sin(x), x, y);
X2 = eval(s.x(1)) + pi;
Y2 = eval(s.y(2));

figure
hold on
x = linspace(0,6,100);
y1 = sin(x);
y2 = cos(x);
y3 = tan(x);
figure
hold on
plot(x,y1,'red');
plot(x,y2,'black');
plot(x,y3,'blue');
ylim([-2,2]);
text(X1,Y1,'第四交点\rightarrow','FontSize',12,'HorizontalAlignment','right')
text(X2,Y2,'\leftarrow第六交点','FontSize',12,'HorizontalAlignment','left')

close all; clear all; clc
a=1
k=3/7;
theta=0:pi/100:7*pi;
rho=a*cos(k*theta);
h=polar(theta,rho)
set(h,'color',[1,0,0],'LineWidth',2)


a=0:0.001:2*pi;
for i=0:6
    r=cos(3*a+i*pi/6);  %这里的3为花瓣数，自己改吧
    polar(a,r,'r');
    hold on
end