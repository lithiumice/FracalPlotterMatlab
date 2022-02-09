function MandelbrotColor(res,iter,xc,yc,xoom,axs)
% Mandelbrot��Julia����
% Ѥ����ɫ���Լ����������ͼ����;����������������İ���
% ���²��޸������ϣ���һ���ڸ�ƽ������ɷ��εĵ�ļ���, z(n+1)=z^2+C
% res��Ŀ��ֱ��ʣ�iter��ѭ����������xc,yc����ͼ�����ģ�xoom�ǷŴ��� 

% �õ���xc,ycΪ���ĵ�,��͸߶�Ϊ4/xoom�ľ���
x0 = xc - 2 / xoom;
x1 = xc + 2 / xoom;
y0 = yc - 2 / xoom;
y1 = yc + 2 / xoom;

% xΪ��СΪres,ֵ��x0,x1������������; yͬ��
x = linspace(x0, x1, res);
y = linspace(y0, y1, res);
% ����ƽ������
[xx, yy] = meshgrid(x, y);
% �õ�C�ĸ�ƽ��
C = xx + yy * 1i;
z = zeros(size(C));
% NΪres x res x 3 ����ά������,������ά������������ɫ
N = uint8(zeros(res, res, 3));
% color Ϊ4x3��ֵ��0-255����������
color = uint8(round(rand(iter, 3) * 255));
escape_range=2;

for k = 1: iter
    z = z.^2 + C;
    % Mandelbrot �ĵ�����ʽ
    %�Կռ���ÿ�㶼���е���
    
    % ���ݰ뾶Ϊ2����ĳ�����ݣ���¼����ʱ��k
    [row, col] = find(abs(z) > escape_range);
    k1 = zeros(size(row)) + 1;
    k2 = zeros(size(row)) + 2;
    k3 = zeros(size(row)) + 3;

    % ����N���Ը������Ⱦɫ 
    p1 = sub2ind(size(N), row, col, k1);
    N(p1) = color(k, 1);
    p2 = sub2ind(size(N), row, col, k2);
    N(p2) = color(k, 2);
    p3 = sub2ind(size(N), row, col, k3);
    N(p3) = color(k, 3);
    
% 	N(abs(z) > escape_range) = k;

    % ���ݰ뾶Ϊ2��δ������ʱ��Ϊ0 
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
% N=zeros(res,res); %��ʼ��N�����ո���N���Ը������Ⱦɫ 
% tic                  % ��ʾtic��toc��ĳ�������ʱ��   
% for k=1:iter      
%    z=z.^2+C;        %�Կռ���ÿ�㶼���е��� 
%    N(abs(z)>4)=k;  %���ݰ뾶Ϊ4��ŵĳ�����ݣ���¼����ʱ��k,δ������ʱ��Ϊ0    
%    z(abs(z)>4)=0;    
%    C(abs(z)>4)=0; 
% end  
% colormap jet;
% axes(axs);
% image(x,y,N);
% axis square;
end