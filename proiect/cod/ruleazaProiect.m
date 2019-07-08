%Implementarea a proiectului Redimensionare imagini
%dupa articolul "Seam Carving for Content-Aware Image Resizing", autori S.
%Avidan si A. Shamir 
%%
%aceasta functie ruleaza intregul proiect 
%setati parametri si imaginile de redimensionat aici

%citeste o imagine
img = imread('C:\Users\Iulian\Desktop\tema2\data\raluca.jpg');

%reducem imaginea in latime cu 20 de pixeli
%seteaza parametri
parametri.optiuneRedimensionare = 'eliminaObiect';
parametri.numarPixeliLatime = 50;
parametri.numarPixeliInaltime = 50;
parametri.ploteazaDrum = 1;
parametri.culoareDrum = [255 0 0]';%culoarea rosie
parametri.metodaSelectareDrum = 'programareDinamica';%optiuni posibile: 'aleator','greedy','programareDinamica'


imgRedimensionata_proiect = redimensioneazaImagine(img,parametri);

imwrite(imgRedimensionata_proiect,'cp3.jpg');
figure, imshow(imgRedimensionata_proiect);

%foloseste functia imresize pentru redimensionare traditionala
imgRedimensionata_traditional = imresize(img,[ size(imgRedimensionata_proiect,1) size(imgRedimensionata_proiect,2)]);
imwrite(imgRedimensionata_traditional,'cpTrad.jpg');
%ploteaza imaginile obtinute
figure, hold on;

%1. imaginea initiala
h1 = subplot(1,3,1);imshow(img);
xsize = get(h1,'XLim');ysize = get(h1,'YLim');
xlabel('imaginea initiala');

%2. imaginea redimensionata cu pastrarea continutului
h2 = subplot(1,3,2);imshow(imgRedimensionata_proiect);
set(h2, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul nostru');

%3. imaginea obtinuta prin redimensionare traditionala
h3 = subplot(1,3,3);imshow(imgRedimensionata_traditional);
set(h3, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul imresize');
