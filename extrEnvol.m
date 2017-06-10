%Extrraccion del envoltorio de la banda y (recibe los coeficientes de detalle de la DWT).

function y = extrEnvol(dw)
   %Rectificacion de onda completa
   dw = abs(dw);
   %Filtrado pasa bajo
   alfa = 0.99;
   y = zeros(size(dw));
   for i=2:length(dw)
      y(i) = (1-alfa) * dw(i) + alfa * y(i-1);
   end
   %Submuestreo
   y = y(1:16:end);
   %Eliminacion de la media
   y = y - mean(y);
end