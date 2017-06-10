%Calcula el histograma de beat (que evidencia la frecuencia de beats y
%subbeats) en un tramo de la canción mediante la DWT.
%La DWT da como resultado las bandas de frecuencia que corresponden a las
%octavas, que me permite armar el histograma. Por lo tanto, debo aplicar la
%DWT 3 veces (el autor sugiere tener 4 bandas) para luego hacer la
%extracción del envoltorio en cada banda y luego.
%La primera aplicacion de la DWT los coeficientes de detalle (cD) de
%las frecuencias más altas y los de aproximación de las más bajas, por lo
%que se sigue aplicando hastas llegar a 4 bandas.

function y = beathistogram(x)
   [cA1,cD1] = dwt(x,'db4');
   [cA2,cD2] = dwt(cA1,'db4');
   [cA3,cD3] = dwt(cA2,'db4');
   
   %Banda 1 (0 a Fm/16): cA3
   %Banda 2 (Fm/16 a Fm/8): cD3
   %Banda 3 (Fm/8 a Fm/4): cD2
   %Banda 4 (Fm/4 a Fm/2): cD1
   
   %Hago la extracción del envoltorio de las 4 bandas
   y1 = extrEnvol(cA3); 
   y2 = extrEnvol(cD3);
   y3 = extrEnvol(cD2);
   y4 = extrEnvol(cD1);
   
   
   
   %Autocorrelación "mejorada" de la combinación de las 4 bandas
   x = y;
   N = length(y);
   tic()
   for i=1:N
       if (toc() > 5)
           tic();
          fprintf(strcat(num2str(i*100/N),'%%\n')); 
       end
       y(i) = 1/N * (x' * circshift(x,i)); 
   end
   
end