%Calcula el histograma de beat (que evidencia la frecuencia de beats y
%subbeats) en un tramo de la canción mediante la DWT. Una vez obtenido el
%histograma se calculan las características basadas en
%éste:
%A0-A1: amplitudes relativas del primer y segundo pico del histograma. 
%RA: Relación de la amplitud del segundo pico dividida por la amplitud del
%primero. 
%P1,P2: Período del primer y segundo pico en bpm. 
% SUM: Suma de todo el histograma

function [A0, A1, RA, P0, P1, SUM] = histograma (audio, fm)

% limite de BPM buscados
maxBPM=200;
minBPM=40;

fmNueva=fm/2;

%calcular 6 sub-bandas aplicando filtros en las bandas de Scheirer (200,
%400, 800, 1600, 3200, 6400). Esto da 6 se�ales de la misma cantidad de
%muestras de Fm/2 y los coeficientes del filtro pasa bajo (luego utilizados
%para el calculo de las envolventes.

[sBanda1, numFiltro1, denFiltro1] = subBandaDWT (audio, fm, 1, 200);
[sBanda2, numFiltro2, denFiltro2] = subBandaDWT (audio, fm, 200, 400);
[sBanda3, numFiltro3, denFiltro3] = subBandaDWT (audio, fm, 400, 800);
[sBanda4, numFiltro4, denFiltro4] = subBandaDWT (audio, fm, 800, 1600);
[sBanda5, numFiltro5, denFiltro5] = subBandaDWT (audio, fm, 1600, 3200);
[sBanda6, numFiltro6, denFiltro6] = subBandaDWT (audio, fm, 3200, 6400);

%construir las envolventes para cada sub-banda. procesamiento para cada
%sub-banda
envo1=envolvente(sBanda1, fmNueva, numFiltro1, denFiltro1);
envo2=envolvente(sBanda2, fmNueva, numFiltro2, denFiltro2);
envo3=envolvente(sBanda3, fmNueva, numFiltro3, denFiltro3);
envo4=envolvente(sBanda4, fmNueva, numFiltro4, denFiltro4);
envo5=envolvente(sBanda5, fmNueva, numFiltro5, denFiltro5);
envo6=envolvente(sBanda6, fmNueva, numFiltro6, denFiltro6);

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
[A0, pos]=sort(envoCorrelacion, 'descend');
A1=A0(2)/SUM;
A0=A0(1)/SUM;
RA=A1/A0;
%calcular las posiciones en x (osea en BPM) de los primeros 2 picos;
P0=pos(1);
P1=pos(2);

end