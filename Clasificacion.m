function [] = Clasificacion(red)

tamVent = 1024; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap

[s_cumbia, fm_c] = audioread(strcat('Canciones/rap9_modificado.wav'));
desconocido(1,:) = extraerCaract(s_cumbia,tamVent,paso,fm_c);

resultado = predict (red, desconocido);
fprintf (resultado);