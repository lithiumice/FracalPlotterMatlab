function MandelbrotColor(res,iter,xc,yc,xoom,axs)
% Mandelbrot和Julia集合
% 绚丽的色彩以及无穷尽的生成图形所;这里面隐藏着宇宙的奥秘
% 曼德勃罗复数集合，是一种在复平面上组成分形的点的集合, z(n+1)=z^2+C
% res是目标分辨率，iter是循环次数，（xc,yc）是图像中心，xoom是放大倍数 

% 得到以xc,yc为中心的,宽和高都为4/xoom的矩形
x0 = xc - 2 / xoom;
x1 = xc + 2 / xoom;
y0 = yc - 2 / xoom;
y1 = yc + 2 / xoom;

% x为大小为res,值在x0,x1递增的行向量; y同理
x = linspace(x0, x1, res);
y = linspace(y0, y1, res);
% 生成平面坐标
[xx, yy] = meshgrid(x, y);
% 得到C的复平面
C = xx + yy * 1i;
z = zeros(size(C));
% N为res x res x 3 的三维零向量,第三个维度用来储存颜色
N = uint8(zeros(res, res, 3));
% color 为4x3的值在0-255间的随机矩阵
color = uint8(round(rand(iter, 3) * 255));
escape_range=2;

for k = 1: iter
    z = z.^2 + C;
    % Mandelbrot 的迭代公式
    %对空间上每点都进行迭代
    
    % 逃逸半径为2，若某点逃逸，记录逃逸时间k
    [row, col] = find(abs(z) > escape_range);
    k1 = zeros(size(row)) + 1;
    k2 = zeros(size(row)) + 2;
    k3 = zeros(size(row)) + 3;

    % 根据N，对各点进行染色 
    p1 = sub2ind(size(N), row, col, k1);
    N(p1) = color(k, 1);
    p2 = sub2ind(size(N), row, col, k2);
    N(p2) = color(k, 2);
    p3 = sub2ind(size(N), row, col, k3);
    N(p3) = color(k, 3);
    
% 	N(abs(z) > escape_range) = k;

    % 逃逸半径为2，未逃逸则时间为0 
    z(abs(z) > escape_range) = 0;
    C(abs(z) > escape_range) = 0;
end
axes(axs);
image(x,y,N);
axis square; 
% x0=xc-2/xoom;x1=xc+2/xoom; 
% y0=yc-2/xoom;y1=yc+2/xoom;
% x=linspace(x0,x1,res);
% y=linspace(y0,y1,res); 
% [xx,yy]=meshgrid(x,y); 
% z=xx+yy*1i;             
% C=z; 
% N=zeros(res,res); %初始化N，最终根据N，对各点进行染色 
% tic                  % 显示tic和toc间的程序运行时间   
% for k=1:iter      
%    z=z.^2+C;        %对空间上每点都进行迭代 
%    N(abs(z)>4)=k;  %逃逸半径为4，诺某点逃逸，记录逃逸时间k,未逃逸则时间为0    
%    z(abs(z)>4)=0;    
%    C(abs(z)>4)=0; 
% end  
% colormap jet;
% axes(axs);
% image(x,y,N);
% axis square;
end