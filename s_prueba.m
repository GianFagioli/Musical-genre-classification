[cancion, Fm] = audioread('song.wav'); %carga cancion y obtiene Fre. Muestreo
[cancion] = partes_senial (cancion, Fm); %extrae distintas partes de la cancion
tamVent = 512; %Tamaño de la ventana
paso = tamVent; %Overlap de ventanas: Si es igual al tamaño de la ventana no hay overlap

[m_sF,v_sF,m_sR,v_sR,m_cE,v_cE,m_zC,v_zC,m_cM,v_cM] = extraerCaract(cancion,tamVent,paso,Fm);

