function imgRedimensionata = redimensioneazaImagine(img,parametri)
%redimensioneaza imaginea
%
%input: img - imaginea initiala
%       parametri - stuctura de defineste modul in care face redimensionarea 
%
% output: imgRedimensionata - imaginea redimensionata obtinuta


optiuneRedimensionare = parametri.optiuneRedimensionare;
metodaSelectareDrum = parametri.metodaSelectareDrum;
ploteazaDrum = parametri.ploteazaDrum;
culoareDrum = parametri.culoareDrum;

switch optiuneRedimensionare
    
    case 'micsoreazaLatime'
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = micsoreazaLatime(img,numarPixeliLatime,metodaSelectareDrum,...
                            ploteazaDrum,culoareDrum);
        
    case 'micsoreazaInaltime'
        %completati aici codul vostru
        numarPixeliInaltime = parametri.numarPixeliInaltime;
        imgRedimensionata = micsoreazaLatime(imrotate(img,90),numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum);
        imgRedimensionata = imrotate(imgRedimensionata,270);
        
    case 'maresteLatime'
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum);
        
    case 'maresteInaltime'
        %completati aici codul vostru
        numarPixeliInaltime = parametri.numarPixeliInaltime;
        imgRedimensionata = maresteLatime(imrotate(img,90),numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum);
        imgRedimensionata = imrotate(imgRedimensionata,270);
    case 'eliminaObiect'
        %completati aici codul vostru 
        imgRedimensionata = eliminaObiect(img,metodaSelectareDrum,ploteazaDrum,culoareDrum);
end