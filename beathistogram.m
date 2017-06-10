%Calcula el histograma de beat (que evidencia la frecuencia de beats y
%subbeats) en un tramo de la canción mediante la DWT.
%La DWT da como resultado las bandas de frecuencia que corresponden a las
%octavas, que me permite armar el histograma. Por lo tanto, debo aplicar la
%DWT 3 veces (el autor sugiere tener 4 bandas) para luego hacer la
%extracción del envoltorio en cada banda y luego la inversa de la DWT.
%La primera aplicacion de la DWT los coeficientes de detalle (cD) de
%las frecuencias más altas y los de aproximación de las más bajas, por lo
%que se sigue aplicando hastas llegar a 4 bandas.
%Una vez obtenido el histograma se calculan las características basadas en
%éste:
%A0-A1: amplitudes relativas del primer y segundo pico del histograma. 
%RA: Relación de la amplitud del segundo pico dividida por la amplitud del primero. 
%P1,P2: Período del primer y segundo pico en bpm. 
%SUM: Suma de todo el hisograma

function [A0,A1,RA,P1,P2,SUM] = beathistogram(x)
   [cA1,cD1] = dwt(x,'db4');
   [cA2,cD2] = dwt(cA1,'db4');
   [cA3,cD3] = dwt(cA2,'db4');
   [cA4,cD4] = dwt(cA3,'db4');
   
   %Banda 1 (0 a Fm/16): cD4
   %Banda 2 (Fm/16 a Fm/8): cD3
   %Banda 3 (Fm/8 a Fm/4): cD2
   %Banda 4 (Fm/4 a Fm/2): cD1
   
   %Hago la extracción del envoltorio de las 4 bandas
   y1 = extrEnvol(cD4);
   y2 = extrEnvol(cD3);
   y3 = extrEnvol(cD2);
   y4 = extrEnvol(cD1);

   %Vuelvo a unir las partes mediante la inversa
   yA1 = idwt(cA4(1:16:end),y1,'db4'); %Genero unos nuevos coeficientes de aproximación
   yA2 = idwt(yA1,y2(1:length(yA1)),'db4');
   yA3 = idwt(yA2,y3(1:length(yA2)),'db4');
   y = idwt(yA3,y4(1:length(yA3)),'db4');%Señal reconstruida
   
   %Autocorrelación "mejorada" de la combinación de las 4 bandas
   x = y;
   N = length(y);
   tic();
   for i=1:N
       y(i) = 1/N * (x' * circshift(x,i)); 
   end
   
   %Caracterísitcas en base al histograma
   SUM=sum(y);
   A0=sort(y,'descend');
   A1=A0(2)/SUM;
   A0=A0(1)/SUM;
   RA=A1/A0;
   P1=0; %Cuando obtenga bien los bpm, esto sería la posición en X del pico del histograma.
   P2=0;
   
end