function Mandelbrot(res,iter,xc,yc,xoom)
%Mandelbrot 
% res是目标分辨率，iter是循环次数，（xc,yc）是图像中心，xoom是放大倍数 
x0=xc-2/xoom;x1=xc+2/xoom; 
y0=yc-2/xoom;y1=yc+2/xoom;
x=linspace(x0,x1,res);
y=linspace(y0,y1,res); 
[xx,yy]=meshgrid(x,y); 
z=xx+yy*1i;             
C=z; 
N=zeros(res,res); %初始化N，最终根据N，对各点进行染色 
tic                  % 显示tic和toc间的程序运行时间   
for k=1:iter      
   z=z.^2+C;        %对空间上每点都进行迭代 
   N(abs(z)>4)=k;  %逃逸半径为4，诺某点逃逸，记录逃逸时间k,未逃逸则时间为0    
   z(abs(z)>4)=0;    
   C(abs(z)>4)=0; 
end 
figure
colormap jet
% imshow(N,[]);

image(x,y,N);
axis square;
toc 
end 