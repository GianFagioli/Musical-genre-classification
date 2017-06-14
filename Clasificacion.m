function [] = Clasificacion(red, divi)

tamVent = 1024; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap
aciertos = 0; %inicializo el contador de aciertos de prediccion

%cargo todaos los nombres de las canciones 
nomCanciones = ls ('cPrueba/*.wav');

%extraigo las caracteristicas
for i=1:length(nomCanciones(:,1))
    [cancion, fm_cancion] = audioread(strcat('cPrueba/',nomCanciones(i,:)));
    carac = extraerCaract(cancion,tamVent,paso,fm_cancion);
    etiqueta = char(cellstr(nomCanciones(i,(1:3))));
    
    %Normalizo las columnas
    carac = carac ./ divi;
    
    %Predigo el genero
    resultado = predict (red, carac);
    
    %cuento la cantidad de errores en la prediccion
    if (etiqueta == resultado)
        aciertos = aciertos + 1;
    end
end

porcentajeAciertos = aciertos * 100 / i;
fpritf('Porcentaje aciertos= ', int2str(porcentajeAciertos));