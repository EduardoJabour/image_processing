clear all; close all; clc; pkg load image;
% Nˆymero de pixels N
N = 200;

% Leitura, redimensionamento e transforma??o de RGB para escala de cinza das 8 imagens de faces
I1 = imread("001.jpg"); I1 = imresize(I1, [N N]); I1 = rgb2gray(I1);
I2 = imread("002.jpg"); I2 = imresize(I2, [N N]); I2 = rgb2gray(I2);
I3 = imread("003.jpg"); I3 = imresize(I3, [N N]); I3 = rgb2gray(I3);
I4 = imread("004.jpg"); I4 = imresize(I4, [N N]); I4 = rgb2gray(I4);
I5 = imread("005.jpg"); I5 = imresize(I5, [N N]); I5 = rgb2gray(I5);
I6 = imread("006.jpg"); I6 = imresize(I6, [N N]); I6 = rgb2gray(I6);
I7 = imread("007.jpg"); I7 = imresize(I7, [N N]); I7 = rgb2gray(I7);
I8 = imread("008.jpg"); I8 = imresize(I8, [N N]); I8 = rgb2gray(I8);

% Mostrando as 8 figuras prontas para que sejam trabalhadas
figure(1);
subplot(2, 4, 1); imshow(I1); title('001.jpg');
subplot(2, 4, 2); imshow(I2); title('002.jpg');
subplot(2, 4, 3); imshow(I3); title('003.jpg');
subplot(2, 4, 4); imshow(I4); title('004.jpg');
subplot(2, 4, 5); imshow(I5); title('005.jpg');
subplot(2, 4, 6); imshow(I6); title('006.jpg');
subplot(2, 4, 7); imshow(I7); title('007.jpg');
subplot(2, 4, 8); imshow(I8); title('008.jpg');

% Calculando a transformada de Fourier e os valores absolutos correspondentes
V1 = fft2(I1); V1 = fftshift(V1); ABSV1 = abs(V1);
V2 = fft2(I2); V2 = fftshift(V2); ABSV2 = abs(V2);
V3 = fft2(I3); V3 = fftshift(V3); ABSV3 = abs(V3);
V4 = fft2(I4); V4 = fftshift(V4); ABSV4 = abs(V4);
V5 = fft2(I5); V5 = fftshift(V5); ABSV5 = abs(V5);
V6 = fft2(I6); V6 = fftshift(V6); ABSV6 = abs(V6);
V7 = fft2(I7); V7 = fftshift(V7); ABSV7 = abs(V7);
V8 = fft2(I8); V8 = fftshift(V8); ABSV8 = abs(V8);

% Mostrando as fotos das faces lado a lado com sua transformada e seu valor absoluto
figure(2);
subplot(4, 6, 1); imshow(I1); title('001.jpg'); subplot(4, 6, 2); imshow(real(V1)); title('DFT (V1)'); subplot(4, 6, 3); imshow(ABSV1,[]); title('ABS (V1)');
subplot(4, 6, 4); imshow(I2); title('002.jpg'); subplot(4, 6, 5); imshow(real(V2)); title('DFT (V2)'); subplot(4, 6, 6); imshow(ABSV2,[]); title('ABS (V2)');
subplot(4, 6, 7); imshow(I3); title('003.jpg'); subplot(4, 6, 8); imshow(real(V3)); title('DFT (V3)'); subplot(4, 6, 9); imshow(ABSV3,[]); title('ABS (V3)');
subplot(4, 6, 10); imshow(I4); title('004.jpg'); subplot(4, 6, 11); imshow(real(V4)); title('DFT (V4)'); subplot(4, 6, 12); imshow(ABSV4,[]); title('ABS (V4)');
subplot(4, 6, 13); imshow(I5); title('005.jpg'); subplot(4, 6, 14); imshow(real(V5)); title('DFT (V5)'); subplot(4, 6, 15); imshow(ABSV5,[]); title('ABS (V5)');
subplot(4, 6, 16); imshow(I6); title('006.jpg'); subplot(4, 6, 17); imshow(real(V6)); title('DFT (V6)'); subplot(4, 6, 18); imshow(ABSV6,[]); title('ABS (V6)');
subplot(4, 6, 19); imshow(I7); title('007.jpg'); subplot(4, 6, 20); imshow(real(V7)); title('DFT (V7)'); subplot(4, 6, 21); imshow(ABSV7,[]); title('ABS (V7)');
subplot(4, 6, 22); imshow(I8); title('008.jpg'); subplot(4, 6, 23); imshow(real(V8)); title('DFT (V8)'); subplot(4, 6, 24); imshow(ABSV8,[]); title('ABS (V8)');

% Dados estatˆqsticos da primeira imagem (001.jpg)
disp ("Dados estatisticos da primeira imagem (001.jpg) :")
MIN = min(ABSV1(:))
MAX = max(ABSV1 (:))
MEAN = mean(ABSV1(:))
STD = std(ABSV1(:))

% Concatenando os dados calculados em listas I, V e Labs
I = [I1, I2, I3, I4, I5, I6, I7, I8];
V = [V1, V2, V3, V4, V5, V6, V7, V8];
Labs = [ABSV1, ABSV2, ABSV3, ABSV4, ABSV5, ABSV6, ABSV7, ABSV8];

% Dados estatˆqsticos da lista Labs
disp ("Dados estatisticos da lista Labs :")
MIN = min(Labs(:))
MAX = max(Labs (:))
MEAN = mean(Labs(:))
STD = std(Labs(:))

% Truncamento (neste ponto o cˆudigo trata uma imagem de cada vez, para mudar a imagem a ser reconstruida modificar as linhas 68 atˆm TAL)
disp ("Truncamento V1 :")
TI = I1; % Aqui podem entrar: I1, ... , I8
ABSV = ABSV1; % Aqui podem entrar: ABSV1, ... , ABSV8
TVa = TVb = TVc = V1; % Aqui podem entrar: V1, ... , V8

MAX = max(ABSV(:)); MEAN = mean(ABSV(:)); parametroA = MAX/500; parametroB = MAX/50; parametroC = MAX/5;

for i = 1 : N
  for j = 1 : N
    if ( (ABSV(i,j)) > parametroA )
      TVa(i,j) = 0;
    endif
    if ( (ABSV(i,j)) > parametroB )
      TVb(i,j) = 0;
    endif
    if ( (ABSV(i,j)) > parametroC )
      TVc(i,j) = 0;
    endif
  endfor  
endfor

TVa = ifftshift(TVa); RTVa = ifft2(TVa);
TVb = ifftshift(TVb); RTVb = ifft2(TVb);
TVc = ifftshift(TVc); RTVc = ifft2(TVc);

figure(3);
subplot(1, 4, 1); imshow(TI); title('Imagem fonte');
subplot(1, 4, 2); imshow(RTVc,[]); title('Reconstrucao 1/5');
subplot(1, 4, 3); imshow(RTVb,[]); title('Reconstrucao 1/50');
subplot(1, 4, 4); imshow(RTVa,[]); title('Reconstrucao 1/500');

