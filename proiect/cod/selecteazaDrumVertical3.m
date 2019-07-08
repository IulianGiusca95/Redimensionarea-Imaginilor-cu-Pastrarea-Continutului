function drum = selecteazaDrumVertical3(E,metodaSelectareDrum,d,rect)

xmin=uint16(rect(1,1)); %coloana
ymin=uint16(rect(1,2)); %linia
nrColoane = uint16(rect(1,3));
nrLinii = uint16(rect(1,4));

drum = zeros(size(E,1),2);

for i = 1 : size(d,1)
    drum(ymin+i-1,1) = ymin + i - 1;
    drum(ymin+i-1,2) = xmin+d(i,2)-1;
    
end

switch metodaSelectareDrum
    case 'aleator'
       %adaugam drumul de deasupra obiectului
       for i = ymin-1: -1 :1
           linie = i+1;
           if(drum(linie,2)) == 1 %pixel localizat la marginea din stanga
               optiune=randi(2)-1; %genereaza 0 sau 1 cu probabilitati egale
           elseif drum(linie,2) == size(E,2) %pixelul e la marginea din dreapta
               optiune=randi(2)-2; %%genereaza -1 sau 0
           else
               optiune=randi(3)-2;%genereaza -1,0 sau 1
           end
           coloana = drum(linie,2) + optiune;
           drum(i,:) = [i coloana];
       end
       
       %adaugam drumul de sub obiect
       val = ymin+nrLinii;
       for j = ymin+nrLinii:1:uint16(size(E,1))
           linie = j-1;
           if drum(linie,2) == 1 %pixel la marginea din stanga
               optiune = randi(2)-1;
           elseif drum(linie,2) == size(E,2)
               optiune = randi(2)-2;
           else
               optiune = randi(3)-2;
           end
           coloana = drum(linie,2) + optiune;
           drum(j,:) = [j coloana];
       end
       
   case 'greedy'
       
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
        
        
       %adaugam drumul de deasupra obiectului
       for i = ymin-1 :-1:1
          linie = i+1;
          if drum(linie,2) == 1 %cazul in care pixelul e la marginea din stanga
              if M(i,1) < M(i,2)
                  coloana = 1;
              else 
                  coloana = 2;
              end
          elseif drum(linie,2) == size(E,2)
              if M(i,size(E,2)) < M(i,size(E,2)-1)
                  coloana = size(E,2);
              else
                  coloana = size(E,2)-1;
              end
          elseif M(i,drum(i+1,2)+1) < M(i,drum(i+1,2)) && M(i,drum(i+1,2)+1) < M(i,drum(i+1,2)-1)
              coloana = drum(i+1,2)+1;
          elseif M(i,drum(i+1,2)-1) < M(i,drum(i+1,2)+1) && M(i,drum(i+1,2)-1) < M(i,drum(i+1,2))
              coloana = drum(i+1,2)-1;
          else
              coloana = drum(i+1,2);
          end
          drum(i,:) = [i coloana];
       end
          
          %adaugam drumul de dedesubt
          
           for j = ymin+nrLinii:1:uint16(size(E,1))
               linie = j-1;
               if drum(j,2) == 1
                   if E(j,1) < E(j,2)
                       coloana = 1;
                   else
                       coloana = 2;
                   end
               elseif drum (linie,2) == size(E,2)
                   if E(j,size(E,2)) < E(j,size(E,2)-1)
                       coloana = size(E,2);
                   else
                       coloana = size(E,2)-1;
                   end
              else
                
                    if E(j,drum(j-1,2)) < E(j,drum(j-1,2)- 1) && E(j,drum(j-1,2)) < E(i,drum(j-1,2)+ 1)
                        coloana = drum(j-1,2);
                    elseif E(j,drum(j-1,2)-1) < E(j,drum(j-1,2)) && E(j,drum(j-1,2)-1) < E(j,drum(j-1,2)+ 1)
                        coloana = drum(j-1,2)-1;
                    else
                        coloana = drum(j-1,2)+1;
                    end
                
            end
                   
           drum(j,:) = [j coloana];            
               
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
        
        
       %adaugam drumul de deasupra obiectului
       for i = ymin-1 :-1:1
          linie = i+1;
          if drum(linie,2) == 1 %cazul in care pixelul e la marginea din stanga
              if M(i,1) < M(i,2)
                  coloana = 1;
              else 
                  coloana = 2;
              end
          elseif drum(linie,2) == size(E,2)
              if M(i,size(E,2)) < M(i,size(E,2)-1)
                  coloana = size(E,2);
              else
                  coloana = size(E,2)-1;
              end
          elseif M(i,drum(i+1,2)+1) < M(i,drum(i+1,2)) && M(i,drum(i+1,2)+1) < M(i,drum(i+1,2)-1)
              coloana = drum(i+1,2)+1;
          elseif M(i,drum(i+1,2)-1) < M(i,drum(i+1,2)+1) && M(i,drum(i+1,2)-1) < M(i,drum(i+1,2))
              coloana = drum(i+1,2)-1;
          else
              coloana = drum(i+1,2);
          end
          drum(i,:) = [i coloana];
       end
          
          %adaugam drumul de dedesubt
          
           for j = ymin+nrLinii:1:uint16(size(E,1))
               linie = j-1;
               if drum(j,2) == 1
                   if E(j,1) < E(j,2)
                       coloana = 1;
                   else
                       coloana = 2;
                   end
               elseif drum (linie,2) == size(E,2)
                   if E(j,size(E,2)) < E(j,size(E,2)-1)
                       coloana = size(E,2);
                   else
                       coloana = size(E,2)-1;
                   end
              else
                
                    if E(j,drum(j-1,2)) < E(j,drum(j-1,2)- 1) && E(j,drum(j-1,2)) < E(i,drum(j-1,2)+ 1)
                        coloana = drum(j-1,2);
                    elseif E(j,drum(j-1,2)-1) < E(j,drum(j-1,2)) && E(j,drum(j-1,2)-1) < E(j,drum(j-1,2)+ 1)
                        coloana = drum(j-1,2)-1;
                    else
                        coloana = drum(j-1,2)+1;
                    end
                
            end
                   
           drum(j,:) = [j coloana];            
               
           end
        
    otherwise 
        error ('Metoda de selectie invalida');
end

end

