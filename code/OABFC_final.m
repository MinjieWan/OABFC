%******************************************%
%Paper: An optimized additive bias field correction model for infrared image segmentation with intensity non-uniformity
%Journal: Expert Systems With Applications
%******************************************%
% In case of slight deviations in IoU, DSC, or MHD values, 
% please kindly rerun the case several times to achieve consistent results as reported in the paper.
% Thank you for reviewing our code, and we wish you a happy day!
%******************************************%
close all;clear all;clc
path='test_images_IR/'; %Please load your path
addpath 'test_images_IR/'; %Please load your path

imgID= 9069; %Choose different images

Img1 = imread([num2str(imgID),'.bmp']); c0=1; 
initialLSF = ones(size(Img1(:,:,1))).*c0;

b0 = 1;
initialLSF1 = ones(size(Img1(:,:,1))).*b0; 
Img2=Img1;
Img2 = (Img2(:,:,1));
Img2 = double(Img2);

switch imgID
 %%%Demo
    case 9069
        sigma=1;alfa=1.78; iterNum=200;k=3;lambda=0.3;
        initialLSF(110:135,90:125) = -c0; 

    case 9071
          sigma=3;alfa=3.4; iterNum=90;k=11; lambda=0.08;
          initialLSF(310:345,80:140) = -c0;

    case 9224
        sigma=1;alfa=0.65; iterNum=100;k=3;lambda=0.05; 
        initialLSF(220:265,180:340) = -c0;

end

Img=double(Img1(:,:,1)); 
Img=log(1+Img/255);
fmin  = min(Img(:));
fmax  = max(Img(:));
Img = 255*(Img-fmin)/(fmax-fmin);  
u=initialLSF;
timestep=1;
epsilon=1;
beta=std2(Img);
G=fspecial('average',k);

numComponents = 2; 
r = gmm_fitting(Img, numComponents);

Ksigma=fspecial('gaussian',round(2*sigma)*2+1,sigma); 
KONE=conv2(ones(size(Img)),Ksigma,'same');

[Gx, Gy] = gradient(Img2);
gradientMagnitude=sqrt(Gx.^2 + Gy.^2);
w22 = 1 ./ (1 + lambda * gradientMagnitude); 

for  n1=1:iterNum
    u=NeumannBoundCond(u);
    DrcU=(epsilon/pi)./(epsilon^2.+u.^2);
    Hu=0.5*(1+(2/pi)*atan(u./epsilon));
    I=Img.*Hu;
    ex1 = global_fitting(Img, I, Hu);
    ex2 = local_fitting(Img, r, Hu, Ksigma, KONE);
    dataForce2 = alfa*new_GMM((1*w22.*ex1 + 1*(1-w22).*ex2)./beta);

    u1 = u;
    DiracU = Dirac(u,epsilon);
    ImageTerm = -DiracU.*dataForce2;

    u = u+timestep*ImageTerm;
    phi=u;
    u=new_GMM3(9*u);
    phi_R=u;

    u=imfilter(u,G,'symmetric');
    phi_av=u;

if abs(u - u1)> 0.001
    break
end
end

Imseg=im2bw(-u,0);

figure;
subplot(1,2,1);
imagesc(Img1); colormap(gray); axis off; axis equal;
hold on;
contour(initialLSF,[0 0],'g','LineWidth',2);
title('Initial contour', 'FontSize', 14);  

subplot(1,2,2);
imagesc(Img1); colormap(gray); axis off; axis equal;
hold on;
contour(u,[0 0],'r','LineWidth',2);
title('Segmentation results', 'FontSize', 14); 

function y = new_GMM(x)
y=(1 - 2*exp(-2*x)) ./ (1 + 2*exp(-2*x));
end

function y = new_GMM3(x)
y = (3.^x - 1) ./ (1 + 3.^x);
end

function f = Dirac(x, epsilon)
f=(epsilon/pi)./(epsilon^2.+x.^2);
end

function g = NeumannBoundCond(f)
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);
end








