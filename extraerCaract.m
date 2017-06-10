%Extraer características: 
%Parámetros: cancion (señal de la cancion completa), tamVent (tamaño de la ventana), paso (avance de la ventana), fs (frecuencia de la señal)
%Algunas características se calculan por ventanas y luego se toma la media y varianza

function [m_sF,v_sF,m_sR,v_sR,m_cE,v_cE,m_zC,v_zC,m_cM,v_cM] = extraerCaract(cancion,tamVent,paso,fm)
    %{
    Lista de elementos que devuelve la funcion
    m_sF media flujo espectral
    v_sF varianza flujo espectral
    m_sR media rol off
    v_sR varianza rol off
    m_cE media centroide espectral
    v_cE varianza centroide espectral
    m_zC media de la cantidad de cruces por cero
    v_zC varianza de la cantidad de cruces por cero
    m_cM VECTOR de medias de los coeficientes de Mel ordenados por fila
    v_cM VECTOR de varianzas de los coeficientes de Mel ordenados por fila
    %}
	%Ventanear: Según el tamaño de la canción, su fs asociada, el tamaño de la ventana y el paso,  
	cant_frames = floor((length(cancion)-tamVent)/paso) + 1; %Frame: Ventana por señal
	H = hamming(tamVent);
	posAct = 1;	
	ventana = zeros(cant_frames,tamVent);
	tdf_v = ventana;
	for i=1:cant_frames
        %fprintf(strcat(int2str(length(cancion(posAct:posAct+tamVent-1))),'- ', int2str(cant_frames), '\n'));
		ventana(i,:) = H.*(cancion(posAct:posAct+tamVent-1));
		tdf_v(i,:) = abs(fft(ventana(i,:)));
		posAct = posAct + paso;
	end

	%Calcular características
	sF = spFlux(tdf_v); %Flujo espectral (vector de 1xcant_frames)
	m_sF = mean(sF);
	v_sF = var(sF);	
    
    %inicializo vectores con cero
    m_sRol = zeros(1,cant_frames);
	cE = zeros(1,cant_frames);
	zC = zeros(1,cant_frames);
    cM = zeros(cant_frames,5);

	for i=1:cant_frames %Para cada frame
		m_sRol(i) = spRoloff(tdf_v(i,:)); %Spectral Roloff para el frame i
		cE(i) = centroide_espectral(tdf_v(i,:)); %Centroide Espectral para el frame i
		zC(i) = zero_crossing(ventana(i,:)); %Zero crossing de la señal en el fame i
        cM(i,:) = coeficientes_Mel (tdf_v(i,:), fm); %Coeficientes de Mel
    end
        
    m_sR = mean(m_sRol);%Media
	v_sR = var(m_sRol);%Varianza
    m_cE = mean(cE);%Media
	v_cE = var(cE);%Varianza
    m_zC = mean(zC);%Media
    v_zC = var(zC);%Varianza
    
    %inicializo con cero los vectores
    m_cM = zeros(1,length(cM(1,:)));
    v_cM = zeros(1,length(cM(1,:)));
    
    for i=1:length(cM(1,:))
       m_cM(i) = mean(cM(:,i)); 
       v_cM(i) = var(cM(:,i)); 
    end
end
