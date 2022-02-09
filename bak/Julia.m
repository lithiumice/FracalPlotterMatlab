function Julia(c,res,iter,xc,yc,xoom) %Julia�� 
%cΪ������ res��Ŀ��ֱ��ʣ�iter��ѭ����������xc,yc����ͼ�����ģ�xoom�ǷŴ���
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
 