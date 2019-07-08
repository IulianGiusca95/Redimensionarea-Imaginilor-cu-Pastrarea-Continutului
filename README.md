# Redimensionarea Imaginilor cu Pastrarea Continutului

Proiect de vedere artificiala prin care se redimensioneaza imagini, nedistorsionand elementele principale. Proiectul a fost realizat in anul 3 de studii, la cursul de Computer Vision, conf. dr. Alexe Bogdan.

# Cod

Fisierul principal de rulare: __proiect/cod/ruleazaTema.m__. In acest fisier setam parametrii (imaginea ce trebuie modificata, algoritmul de modificare, dimensiunile ce vor fi modificate).

Exista mai multe optiuni de redimensionare a imaginii: micsorare/marire pe lungime, micsorare/marire pe latime, sau eliminarea unui obiect din imagine. Pentru eliminarea unui obiect, se va selecta regiunea din imagine ce vrem sa fie eliminata.

Pentru eliminarea/adaugarea pixelilor, se calculeaza energia imaginii (aplicam un filtru Sobel pe imaginea grayscale pentru a calcula magnitudinea gradientului). Pixelii din zona energiei minime pot fi stersi, in cazul in care dorim sa micsoram imaginea, sau aici pot fi adaugati pixeli, in cazul unei mariri. Pixelii adaugati vor avea aceleasi valori ca si pixelii din jurul regiunii (se face o medie).

Am implementat mai multe strategii de redimensionare: 
- Aleator: alege pixelii ce vor fi eliminati la intamplare
- Greedy: alege cel mai bun pixel de eliminat de la pozitia urmatoare, netinand cont de viitoarele alegeri
- Programare dinamica: calculeaza drumul de "cost minim" ce va fi eliminat

# Fisiere si Rezultate

Enuntul amplu al temei se afla in fisierul __tema2.pdf__.

Tema a fost implementata urmand articolul stiintific _Seam Carving for Content-Aware Image Resizing_, autorii Shai Avidan si Ariel Shamir (__articol_engleza.pdf__).

Rezultate obtinute in urma rularii pot fi inspectate in fisierul __rezultate.pdf__ sau folder-ul __Imagini__.

# To Do

- De modificat path-ul imaginilor date ca parametru (sunt citite de pe localhost)
