function [] = Clasificacion(red, divi)

tamVent = 1024; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap

[s_cumbia, fm_c] = audioread(strcat('Canciones/reggae3_modificado.wav'));
desconocido(1,:) = extraerCaract(s_cumbia,tamVent,paso,fm_c);

%Normalizo las columnas
for i=1:length(divi)
    desconocido(i,:) = desconocido(i,:) ./ divi; 
end

resultado = predict (red, desconocido);
fprintf (resultado);