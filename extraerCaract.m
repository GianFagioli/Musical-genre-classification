%Extraer características: 
%Parámetros: cancion (señal de la cancion completa), tamVent (tamaño de la ventana), paso (avance de la ventana), fs (frecuencia de la señal)
%Algunas características se calculan por ventanas y luego se toma la media y varianza

function [m_sF,v_sF,m_sR,v_sR,m_cE,v_cE,m_zC,v_zC] = extraerCaract(cancion,tamVent,paso,fs)
	%Ventanear: Según el tamaño de la canción, su fs asociada, el tamaño de la ventana y el paso,  
	cant_frames = floor((length(cancion)-tamVent)/paso) + 1; %Frame: Ventana por señal
	H = hamming(tamVent);
	posAct = 1;	
	ventana = zeros(cant_frames,tamVent);
	tdf_v = ventana;

	for i=1:cant_frames
		ventana(i,:) = H.*(cancion(posAct:posAct+tamVent-1))';
		tdf_v(i,:) = abs(fft(ventana(i,:)));
		posAct = posAct + paso;
	end

	%Calcular características
	sF = spFlux(tdf_v); %Flujo espectral (vector de 1xcant_frames)
	m_sF = mean(sF);
	v_sF = var(sF);	

	for i=1:cant_frames %Para cada frame
		m_sRol(i) = spRoloff(tdf_v(i,:)); %Spectral Roloff para el frame i
		m_sR = mean(m_sRol);%Media
		v_sR = var(m_sRol);%Varianza

		cE(i) = centroide_espectral(tdf_v(i,:)); %Centroide Espectral para el frame i
		m_cE = mean(cE);%Media
		v_cE = var(cE);%Varianza

		zC(i) = zero_crossing(ventana(i,:)); %Zero crossing de la señal en el fame i
		m_zC = mean(zC);%Media
		v_zC = var(zC);%Varianza
	end
end
