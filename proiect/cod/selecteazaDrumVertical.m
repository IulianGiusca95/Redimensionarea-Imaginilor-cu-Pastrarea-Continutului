function d = selecteazaDrumVertical(E,metodaSelectareDrum)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

d = zeros(size(E,1),2);
daux = zeros(size(E,1),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            
            if size(E,2) == 1
                for j = 2:size(d,1)
                    d(j,:) = [j coloana];
                end
                break;
            end
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
        
    case 'greedy'
        %completati aici codul vostru
        linia = 1;
        %determinam valoarea minima din E pe care sa o alegem
        minim = min(E(linia,:));
        %Determinam de pe linia 1 toate pozitiile care au valoarea din
        %minim, acestea fiind puncte de pornire pentru algoritmul greedy
        for i=1:size(E,2)
           if E(1,i) == minim;
               break;
           end
        end
        coloana = i;
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            if size(E,2) == 1
                for j = 2:size(d,1)
                    d(j,:) = [j coloana];
                end
                break;
            end
            
            linia = i;
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
               %doua optiuni
               if (E(i,1) <= E(i,2))
                   coloana = 1;
               else
                   coloana = 2;
               end
               
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                if (E(i,size(E,2))<= E(i,size(E,2)-1))
                    coloana = size(E,2);
                else
                    coloana = size(E,2)-1;
                end
            else
                
                    if E(i,d(i-1,2)) < E(i,d(i-1,2)- 1) && E(i,d(i-1,2)) < E(i,d(i-1,2)+ 1)
                        coloana = d(i-1,2);
                    elseif E(i,d(i-1,2)-1) < E(i,d(i-1,2)) && E(i,d(i-1,2)-1) < E(i,d(i-1,2)+ 1)
                        coloana = d(i-1,2)-1;
                    else
                        coloana = d(i-1,2)+1;
                    end
                
            end
            d(i,:) = [linia coloana];
            
            
               
            end 
        
        
        
    case 'programareDinamica'
        
        
        M = zeros (size(E));
        M(1,:) = E(1,:);
        for i = 2 : size(E,1)
            for j = 1: size(E,2)
                if(j == 1) && size(E,2) == 1
                    M(i,j) = E(i,j) + M(i-1,j);
                elseif (j==1)
                    M(i,j) = E(i,j) + min(M(i-1,j),M(i-1,j+1));
                elseif(j == size(E,2))
                    M(i,j) = E(i,j) + min(M(i-1,size(E,2)),M(i-1,size(E,2)-1));
                else
                    M(i,j) = E(i,j) + min( M(i-1,j) , min( M(i-1,j-1)  , M(i-1,j+1) ));
                end
            end
        end
        
     
        
        minVal = min(M(size(E,1),:));
        for i = 1 : size(E,2)
           if M(size(E,1),i)==minVal
               break;
           end
        end
        coloana = i;
        linia = size(E,1);
        
        d(linia,:)= [linia coloana];
        
        for i = size(E,1)-1 : -1 : 1
            
            if size(E,2) == 1
                for j = 1:size(d,1)-1
                    d(j,:) = [j coloana];
                end
                break;
            end
           if d(i+1,2)==1
               if M(i,1) < M(i,2)
                   
                   d(i,:)=[i 1];
               else
                   
                   d(i,:)=[i 2];
               end
           elseif d(i+1,2) ==size(E,2)
               if M(i,size(E,2)) < M(i,size(E,2)-1)
                   d(i,:) = [i size(E,2)];
                  
               else
                   d(i,:) = [i size(E,2)-1];
                 
               end
           elseif M(i,d(i+1,2)+1) < M(i,d(i+1,2)) && M(i,d(i+1,2)+1) < M(i,d(i+1,2)-1)
                   d(i,:) = [i d(i+1,2)+1];
                  
           elseif M(i,d(i+1,2)-1) < M(i,d(i+1,2)+1) && M(i,d(i+1,2)-1) < M(i,d(i+1,2))
                   d(i,:) = [i d(i+1,2)-1];
                  
           else
                   d(i,:) = [i d(i+1,2)];
                  
               end
           end
        
        
        
           
        
    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end