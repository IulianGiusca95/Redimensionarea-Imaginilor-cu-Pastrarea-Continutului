function d = selecteazaDrumVertical2(E,metodaSelectareDrum,numarPixeliLatime)



switch metodaSelectareDrum
    case 'aleator'
        d = zeros(size(E,1),2);
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
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
        %determinam primele n valori minime din E pe care dorim sa le
        %alegem conform algoritmului greedy
        n = numarPixeliLatime;
        v_sort = sort(E(1,:));
        v_indici = zeros(1,n);
        for i = 1 : n
           for j = 1 : size(E,2)
               if(E(1,j))==v_sort(i)
                   v_indici(1,i) = j;
                   break;
               end
           end
        end
        
        
        d_start = sort(v_indici);
        d = zeros(n,size(E,1),2);
        
        
        %calculam fiecare drum in parte
        
        for k = 1:n
            d(k,1,:) = [1 d_start(k)];
        end
            
        for k = 1:n
            for i = 2:size(E,1)
                linia = i;
                if d(k,i-1,2) == 1 %pixelul e pozitionat la marginea din stanga
                    if (E(i,1) <= E(i,2))
                   coloana = 1;
                    else
                   coloana = 2;
                    end
                elseif d(k,i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                if (E(i,size(E,2))<= E(i,size(E,2)-1))
                    coloana = size(E,2);
                else
                    coloana = size(E,2)-1;
                end
                else
                    
                    if E(i,d(k,i-1,2)) < E(i,d(k,i-1,2)- 1) && E(i,d(k,i-1,2)) < E(i,d(k,i-1,2)+ 1)
                        coloana = d(k,i-1,2);
                    elseif E(i,d(k,i-1,2)-1) < E(i,d(k,i-1,2)) && E(i,d(k,i-1,2)-1) < E(i,d(k,i-1,2)+ 1)
                        coloana = d(k,i-1,2)-1;
                    else
                        coloana = d(k,i-1,2)+1;
                    end
                
                end
                d(k,i,:) = [linia coloana];
            end
        end
        
        %deplasam fiecare drum la dreapta, in afara de primul
        for k = 2:n
            for i = 1:size(E,1)
                d(k,i,2) = d(k,i,2) + (k-1);
            end
        end
            

    case 'programareDinamica'
        
        M = zeros (size(E));
        M(1,:) = E(1,:);
        for i = 2 : size(E,1)
            for j = 1: size(E,2)
                if(j == 1)
                    M(i,j) = E(i,j) + min(M(i-1,j),M(i-1,j+1));
                elseif(j == size(E,2))
                    M(i,j) = E(i,j) + min(M(i-1,size(E,2)),M(i-1,size(E,2)-1));
                else
                    M(i,j) = E(i,j) + min( M(i-1,j) , min( M(i-1,j-1)  , M(i-1,j+1) ));
                end
            end
        end
        
        %determin primele n drumuri de cost minim
        
        n = numarPixeliLatime;
        v_sort = sort(M(size(E,1),:));
        v_indici = zeros(1,n);
        for i = 1 : n
           for j = 1 : size(E,2)
               if(M(size(E,1),j))==v_sort(i)
                   v_indici(1,i) = j;
                   break;
               end
           end
        end
      
        
        d_start = sort(v_indici);
        d = zeros(n,size(E,1),2);
        
        for k = 1:n
            d(k,size(E,1),:) = [size(E,1) d_start(k)];
        end
      
        
        for k = 1 : n
            
            for i = size(E,1)-1 : -1 : 1

                if d(k,i+1,2)==1
                   if M(i,1) < M(i,2)
                   
                   d(k,i,:)=[i 1];
                else
                   
                   d(k,i,:)=[i 2];
                end
           elseif d(k,i+1,2) ==size(E,2)
               if M(i,size(E,2)) < M(i,size(E,2)-1)
                   d(k,i,:) = [i size(E,2)];
                  
               else
                   d(k,i,:) = [i size(E,2)-1];
                 
               end
           elseif M(i,d(k,i+1,2)+1) < M(i,d(k,i+1,2)) && M(i,d(k,i+1,2)+1) < M(i,d(k,i+1,2)-1)
                   d(k,i,:) = [i d(k,i+1,2)+1];
                  
           elseif M(i,d(k,i+1,2)-1) < M(i,d(k,i+1,2)+1) && M(i,d(k,i+1,2)-1) < M(i,d(k,i+1,2))
                   d(k,i,:) = [i d(k,i+1,2)-1];
                  
           else
                   d(k,i,:) = [i d(k,i+1,2)];
                  
               end
            end
            
        end
        
         %deplasam fiecare drum la dreapta, in afara de primul
        for k = 2:n
            for i = 1:size(E,1)
                d(k,i,2) = d(k,i,2) + (k-1);
            end
        end
        
        
        
    otherwise
        error('Optiune invalida');

end

