function [] = PSM_svd(N_mask, pz, r, pixel, k, NA, lamda, sigma, order, step, a, t_r, t_m, gamma_D, epsilon, maxloop);

% clc;
% clear;
% %%%%%%The initialization of the parameter in optical lithography system%%%%%%
% N_mask=51;   %Mask dimension
% pixel=11;   %Pixel size (nano meter)
% k=0.29;   %Process constant
% NA=1.35;   %Numerical aperture
% lamda=193;   %Wavelength (nano meter)
% sigma=0.3;   %Partial coherence factor
% order=1;   %Order of Bessel function

midway=(N_mask+1)/2;   %Middle point of mask

%%%%%%Calculate the transmission cross coefficients%%%%%%
disp('Calculating the transmission cross coefficients. Please wait...');
[TCC] = SOCS(N_mask, pixel, k, NA, lamda, midway, sigma, order);

%%%%%%Singular value decomposition of the partially coherent imaging system%%%%%%
[U,S,V]=svd(TCC);   %Singular value decomposition
h_1_fre=reshape(U(1:N_mask^2,1:1),N_mask,N_mask);
h_1=(fftshift(ifft2(ifftshift((h_1_fre)))));   %The impulse response of the first order approximation 
sum_eigenvalue=(sum(sum(S)));   %The summation of the eigenvalues 

%%%%%%The initialization of the parameter in the optimization%%%%%%
% step=0.2;   %Step size
% a=200;
% t_r=0.003;   %Global threshold of photoresist effect for the first eigen value
% t_m=0.33;   %Global threshold of the mask
% gamma_D=0.1;   %Weight of the discretization penalty
% epsilon=9;   %Tolerable output pattern error
% maxloop=300;   %Maximum iteration number

t_r_real=0;   %Global threshold of photoresist effect for all of the eigen value
d=zeros(N_mask,N_mask);   %Gradient of the cost function
d_D=zeros(N_mask,N_mask);   %Gradient of the discretization penalty
convergence=zeros(maxloop,1);   %Output pattern error in each iteration
count=0;   %Index of iteration number
sum6=100;   %Output pattern error corresponding to the optimized trinary mask
sum8=100;   %Output pattern error corresponding to the optimized real-valued mask

%%%%%%the amplitude impulse response of the partially coherent imaging system%%%%%%
h_1_1=h_1;

for ii=1:N_mask
    for jj=1:N_mask
        h_1_vector((ii-1)*N_mask+jj)=h_1_1(ii,jj);
    end
end
for ii=1:N_mask
    for jj=1:N_mask
        g_1(ii,jj)=h_1_vector((N_mask-ii)*N_mask+(N_mask+1-jj)); %inverse vector
    end
end

%%%%%%The desired output pattern%%%%%%
% pz=zeros(N_mask,N_mask);
% for ii=16:35
%     for jj=13:23
%         pz(ii,jj)=1;
%     end
% end
% for ii=16:35
%     for jj=29:39
%         pz(ii,jj)=1;
%     end
% end
 
%%%%%%The initialization of \theta, where r=\theta%%%%%%
% r=ones(N_mask,N_mask)*pi/2;
% for ii=16:35
%     for jj=13:23
%         r(ii,jj)=pi/5;
%     end
% end
% for ii=16:35
%     for jj=29:39
%         r(ii,jj)=pi/5;
%     end
% end

%%%%%%PSM optimization in partially coherent imaging system%%%%%%
m=zeros(N_mask,N_mask);   %Mask pattern
while (sum6>epsilon) & (count<maxloop)
    count=count+1;
    %%%%%%%%%%%%%%%%%%%calculate pattern error%%%%%%%%%%%%%%%%%%
    m=cos(r);   %Gray mask
    m_trinary_p=m>t_m;
    m_trinary_n=-1*(m<(-1*t_m));
    m_trinary=m_trinary_p+m_trinary_n;   %Trinary mask
    aerial=zeros(N_mask,N_mask);   %Aerial image 
    aerial=(  abs(imfilter(double(m_trinary),h_1_1)).^2   );
    z_trinary=aerial>t_r;   %Binary output pattern
    sum6=sum(sum(abs(abs(pz)-z_trinary)));   %Output pattern error of trinary mask 
    convergence(count,1)=sum6; 
  
    %%%%%%Gradient of cost function%%%%%%
    mid1=abs(imfilter(double(m),h_1_1)).^2;
    z=1./(  1+exp(-a*mid1+a*t_r)  ); 
    mid3=(pz-z).*z.*(1-z);   
    mid4=mid3.*imfilter(double(m),h_1_1);
    mid4_4=mid3.*imfilter(double(m),conj(h_1_1));
    mid5=real(imfilter(double(mid4),conj(g_1))+imfilter(double(mid4_4),g_1));
    
    %%%%%%Gradient of discretization penaly%%%%%%  
    d_D=( (-18)*m.^3+2*m ).*((-1)*sin(r));
   
    %%%%%%%Calculate whole revision vector%%%%%%%%%%
    d=2*a*mid5.*sin(r) + gamma_D*d_D;
    r=r-step*d;   %Update
    disp(strcat('iteration=',num2str(count)));
    disp(strcat('Output pattern error = ',num2str(sum6)));
end

t_r_real=t_r*sum_eigenvalue;   %Global threshold of photoresist effect for all of the eigen value

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Display%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%Desired pattern%%%%%%
figure
imshow(pz,[-1,1]);
axis on;
title('Desired pattern');

%%%%%%Output pattern of desired pattern%%%%%%
aerial=zeros(N_mask,N_mask);
aerial_fre=zeros(N_mask,N_mask);
pz_fre=(fftshift(fft2(pz)));
for x=1:N_mask^2
    for y=1:N_mask^2
        index_1=mod(x-1,N_mask)+1;
        index_2=floor((x-1)/N_mask)+1;
        index_3=mod(y-1,N_mask)+1;
        index_4=floor((y-1)/N_mask)+1;
            aerial_fre(mod(index_1-index_3,N_mask)+1,mod(index_2-index_4,N_mask)+1)=aerial_fre(mod(index_1-index_3,N_mask)+1,mod(index_2-index_4,N_mask)+1)+TCC(x,y)*(pz_fre(index_1,index_2))*conj(pz_fre(index_3,index_4));
    end
    disp(x);
end
aerial=abs(ifft2(aerial_fre))/((N_mask)^2);
Output_desire=aerial >t_r_real;
sum10=sum(sum(abs(abs(pz)-Output_desire)));
figure
imshow(Output_desire,[-1,1]);
axis on;
title('Output of desired pattern');
xlabel(strcat('Error=',num2str(sum10)));
 
%%%%%%Gray optimized mask%%%%%%
figure
imshow(m,[-1,1]);
axis on;
title('Gray mask');

%%%%%%Output pattern of gray optimized mask%%%%%%
aerial=zeros(N_mask,N_mask);
aerial_fre=zeros(N_mask,N_mask);
m_fre=(fftshift(fft2(m)));
for x=1:N_mask^2
    for y=1:N_mask^2
        index_1=mod(x-1,N_mask)+1;
        index_2=floor((x-1)/N_mask)+1;
        index_3=mod(y-1,N_mask)+1;
        index_4=floor((y-1)/N_mask)+1;
            aerial_fre(mod(index_1-index_3,N_mask)+1,mod(index_2-index_4,N_mask)+1)=aerial_fre(mod(index_1-index_3,N_mask)+1,mod(index_2-index_4,N_mask)+1)+TCC(x,y)*(m_fre(index_1,index_2))*conj(m_fre(index_3,index_4));
    end
    disp(x);
end
aerial=abs(ifft2(aerial_fre))/((N_mask)^2);
Output_gray=aerial>t_r_real;
sum8=sum(sum(abs(abs(pz)-Output_gray)));%change pz from -1 to 1 to 0 to 1
figure
imshow(Output_gray,[-1,1]);
axis on;
xlabel(strcat('Error=',num2str(sum8)));
 
%%%%%%Trinary optimized mask%%%%%%
m_trinary_p=m>t_m;
m_trinary_n=-1*(m<(-1*t_m));
m_trinary=m_trinary_p+m_trinary_n;
figure
imshow(m_trinary,[-1,1]);
axis on;
title('Trinary mask');
 
%%%%%%Output pattern of trinary optimized mask%%%%%%
aerial=zeros(N_mask,N_mask);
aerial_fre=zeros(N_mask,N_mask);
m_trinary_fre=(fftshift(fft2(m_trinary)));
for x=1:N_mask^2
    for y=1:N_mask^2
        index_1=mod(x-1,N_mask)+1;
        index_2=floor((x-1)/N_mask)+1;
        index_3=mod(y-1,N_mask)+1;
        index_4=floor((y-1)/N_mask)+1;
            aerial_fre(mod(index_1-index_3,N_mask)+1,mod(index_2-index_4,N_mask)+1)=aerial_fre(mod(index_1-index_3,N_mask)+1,mod(index_2-index_4,N_mask)+1)+TCC(x,y)*(m_trinary_fre(index_1,index_2))*conj(m_trinary_fre(index_3,index_4));
    end
    disp(x);
end
aerial=abs(ifft2(aerial_fre))/((N_mask)^2);
Output_trinary=aerial>t_r_real;
sum6=sum(sum(abs(abs(pz)-Output_trinary)));
figure
imshow(Output_trinary,[-1,1]);
xlabel(strcat('Error=',num2str(sum6)));
 
%%%%%%Convergence of optimization algorithm%%%%%%
figure   
plot([1:count],convergence(1:count,:),'k');
title('Convergence of optimization algorithm');

%%%%%%Save all of the data%%%%%%
save Data_PSM_svd.mat;  