function Julia(c,res,iter,xc,yc,xoom) %Julia集 
%c为参数， res是目标分辨率，iter是循环次数，（xc,yc）是图像中心，xoom是放大倍数
x0=xc-2/xoom;
x1=xc+2/xoom;
y0=yc-2/xoom;
y1=yc+2/xoom; 
x=linspace(x0,x1,res);
y=linspace(y0,y1,res); 
[xx,yy]=meshgrid(x,y);
z=xx+yy*1i; 
N=zeros(res,res); 
C=c*ones(res,res); 
for k=1:iter    
   z=z.^2+C; 
   N(abs(z)>2)=k;    
   C(abs(z)>2)=0; 
   z(abs(z)>2)=0; 
end 
figure
colormap jet; 
image(x,y,N); 
axis square; 
end 
 