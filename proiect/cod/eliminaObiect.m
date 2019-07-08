function img = eliminaObiect(img,metodaSelectareDrum,ploteazaDrum,culoareDrum)

imshow(img)
rect = getrect;
% rect = [xmin(Coloana) ymin(Linia) nrColoane nrLinii]
xmin=uint16(rect(1,1));
ymin=uint16(rect(1,2));
nrColoane = uint16(rect(1,3));
nrLinii = uint16(rect(1,4));
imgAux = zeros(nrLinii,nrColoane,3);

for i = 1:nrLinii
    for j = 1 : nrColoane
    imgAux(i,j,:) = img(ymin+(i-1),xmin+j-1,:);
    end
end


for i = 1 : nrColoane
    disp(['Eliminam drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(nrColoane)]);
    
    E = calculeazaEnergie(imgAux);
   
    %alege drumul vertical care conecteaza sus de jos imgAux
    d = selecteazaDrumVertical(E,metodaSelectareDrum);
    %extragem capetele drumului care taie pe imgAux, apoi generam drumul
    %pentru restul imaginii
    
    E1 = calculeazaEnergie(img);
    
    drum = selecteazaDrumVertical3(E1,metodaSelectareDrum,d,rect);
    %afiseaza drum
    %if ploteazaDrum
     %   ploteazaDrumVertical(img,E1,drum,culoareDrum);
      % pause(1);
       % close(gcf);
    %end
    
    %elimina drumul din imagine
    img = eliminaDrumVertical(img,drum);
    if i < nrColoane
    imgAux = eliminaDrumVertical(imgAux,d);
    rect = [xmin ymin nrColoane-1 nrLinii];
    else 
        break;
    end
    
    
    
end



end

