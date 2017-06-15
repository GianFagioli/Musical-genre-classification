%Calcula el histograma de beat (que evidencia la frecuencia de beats y
%subbeats) en un tramo de la canción mediante la DWT. Una vez obtenido el
%histograma se calculan las características basadas en
%éste:
%A0-A1: amplitudes relativas del primer y segundo pico del histograma. 
%RA: Relación de la amplitud del segundo pico dividida por la amplitud del
%primero. 
%P1,P2: Período del primer y segundo pico en bpm. 
% SUM: Suma de todo el histograma

function [A0, A1, RA, P0, P1, SUM] = histogramaDWT (audio, fm)

% limite de BPM buscados
maxBPM=200;
minBPM=40;

%calcular 6 sub-bandas aplicando la transformada Wavelet con 6 niveles
nBandas = 6;
[C,L] = wavedec(audio,nBandas,'db4');
sBanda1 = upsample(C(L(2):L(3)),64);
sBanda2 = upsample(C(L(2):L(3)),32);
sBanda3 = upsample(C(L(2):L(3)),16);
sBanda4 = upsample(C(L(2):L(3)),8);
sBanda5 = upsample(C(L(2):L(3)),4);
sBanda6 = upsample(C(L(2):L(3)),2);

maxLength = max([length(sBanda1), length(sBanda2), length(sBanda3), length(sBanda4), length(sBanda5), length(sBanda6)]);
sBanda1(length(sBanda1)+1:maxLength) = 0;
sBanda2(length(sBanda2)+1:maxLength) = 0;
sBanda3(length(sBanda3)+1:maxLength) = 0;
sBanda4(length(sBanda4)+1:maxLength) = 0;
sBanda5(length(sBanda5)+1:maxLength) = 0;
sBanda6(length(sBanda6)+1:maxLength) = 0;

%construir las envolventes para cada sub-banda. procesamiento para cada
%sub-banda
envo1= envolventeDWT(sBanda1);
envo2= envolventeDWT(sBanda2);
envo3= envolventeDWT(sBanda3);
envo4= envolventeDWT(sBanda4);
envo5= envolventeDWT(sBanda5);
envo6= envolventeDWT(sBanda6);

%se submuestrean a 250hz las envolventes, para aumentar el rendimiento del
%algoritmo de la autocorrelacion
envo1=envo1(1:floor(fm/(2*250)):end);
envo2=envo2(1:floor(fm/(2*250)):end);
envo3=envo3(1:floor(fm/(2*250)):end);
envo4=envo4(1:floor(fm/(2*250)):end);
envo5=envo5(1:floor(fm/(2*250)):end);
envo6=envo6(1:floor(fm/(2*250)):end);

%Al tener todos envoltorios de la misma longitud para cada banda de
%frecuencia se pueden sumar directamente
sumaEnvo=envo1+envo2+envo3+envo4+envo5+envo6;

%se realiza la autocorrelacion de la suma de los envoltorios
envoCorrelacion=autoCorrelacion(sumaEnvo, 250, minBPM, maxBPM);

%calculo la salida que necesito para el clasificador
SUM=sum(envoCorrelacion);
[A0, pos]=findpeaks(envoCorrelacion);

%segun la cantidad de picos se asignan distintos valores a los maximos
if (isempty(A0))
    A0=0;
    A1=0;
    RA=1;
    P0=0;
    P1=0;
elseif (length(A0) == 1)
    A0 = A0(1)/SUM;
    A1=A0;
    RA=1;
    P0=pos(1);
    P1=P0;
else
    A1 = A0(2)/SUM;
    A0 = A0(1)/SUM;
    RA=A1/A0;
    P0=pos(1);
    P1=pos(2);
end
end