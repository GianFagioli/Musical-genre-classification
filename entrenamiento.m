function [red,carac,divi] = entrenamiento()

tamVent = 1024; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap

%cargo todaos los nombres de las canciones 
nomCanciones = ls ('CancionesP/*.wav');

%inicializo la matriz de caracteristicas
carac=zeros(length(nomCanciones(:,1)),24);

%extraigo las caracteristicas
for i=1:length(nomCanciones(:,1))
    [cancion, fm_cancion] = audioread(strcat('CancionesP/',nomCanciones(i,:)));
    carac(i,:) = extraerCaract(cancion,tamVent,paso,fm_cancion);
    etiquetas(i) = cellstr(nomCanciones(i,(1:3)));
    
end

%Normalizo por columnas y guardo los mayores de cada uno para luego dividir
%en la etapa de prueba.
[carac, divi] = normColumn(carac);

etiquetas = char(etiquetas);
red = fitcdiscr(carac,char(etiquetas));