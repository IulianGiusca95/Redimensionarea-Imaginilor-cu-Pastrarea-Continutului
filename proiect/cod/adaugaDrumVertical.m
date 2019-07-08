function img1 = adaugaDrumVertical(img,drum)

img1 = zeros(size(img,1),size(img,2)+1,size(img,3),'uint8');

for i = 1:size(img1,1)
    coloana = drum(i,2);
    %copiem partea stanga
    img1(i,1:coloana,:) = img(i,1:coloana,:);
    %adaugam partea dreapta
    if (coloana == size(img,2))
        
        img1(i,coloana+1,:) = img(i,coloana,:);
    else
        
        img1(i,coloana+1,:) = double(img(i,coloana,:))/2 + double(img(i,coloana+1,:))/2;
        img1(i,coloana+2:size(img,2)+1,:) = img(i,coloana+1:size(img,2),:);
    end
    
end


end

