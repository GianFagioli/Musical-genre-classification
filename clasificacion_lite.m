% Clasificación de un archivo de baja cantidad de muestras. Útil para ver
% rápido las características. Se sugiere probar 'Clasificacion.m'.

tamVent = 600; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap

[archi,fm] = audioread('B128.wav');
carac(1,:) = extraerCaract(archi,tamVent,paso,fm);
