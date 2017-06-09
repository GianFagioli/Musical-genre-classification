fs = 44000; %44Khz -> Frecuencia de muestreo de la canción
cancion = audioread('song.wav',fs*[3 5]); %Leo del segundo tres a cinco
tamVent = 512; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap

[m_sF,v_sF,m_sR,v_sR,m_cE,v_cE,m_zC,v_zC] = extraerCaract(cancion,tamVent,paso,fs);

