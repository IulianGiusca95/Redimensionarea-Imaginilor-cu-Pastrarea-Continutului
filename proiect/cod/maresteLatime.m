function img = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum)



switch metodaSelectareDrum
    case 'aleator'
for i = 1:numarPixeliLatime
    
    disp(['Adaugam drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
     %alege drumul vertical care conecteaza sus de jos
    drum = selecteazaDrumVertical2(E,metodaSelectareDrum,numarPixeliLatime);

    %afiseaza drum
    if ploteazaDrum
        ploteazaDrumVertical(img,E,drum,culoareDrum);
        pause(1);
        close(gcf);
    end
    
    %elimina drumul din imagine
    img = adaugaDrumVertical(img,drum);
end

    
    otherwise
   
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
     %alege drumul vertical care conecteaza sus de jos
    d = selecteazaDrumVertical2(E,metodaSelectareDrum,numarPixeliLatime);
    
    for k = 1:size(d,1)
        drum = zeros(size(E,1),2);
        for i = 1 : size(E,1)
                drum(i,:) = [d(k,i,1) d(k,i,2)];
        end
       
        
        disp(['Adaugam drumul vertical numarul ' num2str(k) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
    
        
        
         %afiseaza drum
    %if loteazaDrum
    %    ploteazaDrumVertical(img,E,drum,culoareDrum);
    %    pause(1);
    %    close(gcf);
    %end
    
    %elimina drumul din imagine
    img = adaugaDrumVertical(img,drum);
    end

end

end

