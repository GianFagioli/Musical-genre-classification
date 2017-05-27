function [filtro] = coeficientes_Mel (x, Fm)
X=fft(x);

% Se va a usar un banco de 26 filros
% El rango de frecuencia a filtrar es de 300 Hz a 10 KHz
%http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/

limSup= 10000;
limSupMel= 2595 * log10(1+limSup/700);

limInf= 300;
limInfMel= 2595 * log10(1+limInf/700);

paso= (limSupMel-limInfMel)/27;
centrosMel = (limInfMel:paso:limSupMel);

centrosHz = 700* (exp(centrosMel/1127.01048)-1);

f=floor((length(X)+1)*centrosHz/Fm); %no se porq hace esto

% Calculo los fitros, estan ordenados en una matriz por fila

filtro=zeros(26,length(X));
hold on;
for m=2 : 27 %recorre las filas / filtros
    for k=1 : length(X) %recorre las columnas
        if ( k < f(m-1) )
            filtro(m,k)=0;
        elseif (f(m-1) <= k && k <= f(m))
            filtro(m,k)= (k-f(m-1)) / (f(m)-f(m-1));
        elseif (f(m)<= k && k <= f(m+1))
            filtro(m,k)= (f(m+1)-k) / (f(m+1)-f(m));
        elseif (k > f(m+1))
            filtro(m,k)= 0;
        end
    end
    plot(filtro(m,:));
end

end