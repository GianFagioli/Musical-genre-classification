function [] = Clasificacion(red, divi)

tamVent = 512; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap
aciertos = 0; %inicializo el contador de aciertos de prediccion

%cargo todaos los nombres de las canciones 
nomCanciones = ls ('musica/prueba/*.wav');

%extraigo las caracteristicas
for i=1:length(nomCanciones(:,1))
    [cancion, fm_cancion] = audioread(strcat('musica/prueba/',nomCanciones(i,:)));
    carac = extraerCaract(cancion,tamVent,paso,fm_cancion);
    etiqueta = cellstr(nomCanciones(i,(1:3)));
    
    %Normalizo las columnas
    carac = carac ./ divi;
    
    %Predigo el genero
    resultado = predict (red, carac);
    
    %cuento la cantidad de errores en la prediccion
    etiqueta = char(etiqueta);
    if (etiqueta == resultado)
        aciertos = aciertos + 1;
    end
end

porcentajeAciertos = aciertos * 100 / i;
fprintf(strcat('Porcentaje aciertos= ', int2str(porcentajeAciertos)));