function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru sobel pentru a calcula gradientul in directia x si y
%calculati magnitudiena gradientului
%E - energia = gradientul imaginii

%completati aici codul vostru

imgGrayscale = rgb2gray(img);
%imshow(imgGrayscale);
My = fspecial('sobel');
Mx = [-1,0,1 ;-2,0,2 ;-1,0,1];
outimX = imfilter(double(imgGrayscale),Mx);
outimY = imfilter(double(imgGrayscale),My);
outim=sqrt(outimX.^2 + outimY .^2);
%imagesc(outim);
%colormap gray;
E = outim;
