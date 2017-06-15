function [Coeficientes] = coeficientes_Mel (X, Fm)

% Se va a usar un banco de 26 filros
% El rango de frecuencia a filtrar es de 300 Hz a 10 KHz
%http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/

limSup= Fm/2;
limSupMel= 2595 * log10(1+limSup/700);

limInf= 0;
limInfMel= 2595 * log10(1+limInf/700);

paso= (limSupMel-limInfMel)/27;
centrosMel = (limInfMel:paso:limSupMel);



%trasnformo los centros de los filtos de Mel a Hz
centrosHz = 700* (exp(centrosMel/1127.01048)-1);

% Se redondea la frecuencia de los filtros a la frecuencia de la FFT mas
% cercana
f=floor((length(X)+1)*centrosHz/Fm);

% Calculo los fitros, estan ordenados en una matriz por fila

filtro=zeros(26,length(X));

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
end

filtro = filtro (3:end,:); % le saco las primeras 2 filas que no tienen info

X = X/max(X); %Normalizo

Coeficientes = zeros(1,23);

for i=1 : length(Coeficientes)
    Coeficientes(i)= filtro(i,:)* abs(X)';
end

%Necesito solamente los 5 primeros coef segun el paper
Coeficientes = Coeficientes(1:5);
end
