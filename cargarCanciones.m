% Cargar las canciones en señales ya particionadas por fragmentos

% clasico
clasico=zeros(11, 661503); %matriz, las filas son las señales de las canciones
fm_clasico=clasico(11,1); %vector columna con las frecuencias de muestreo
for i=1 : 11
    [s_clasico, fm_clasico(i,1)] = audioread(strcat('Canciones/clasico' , int2str(i),'.mp3'));
    [clasico(i,:)] = partes_senial (s_clasico(:,1), fm_clasico(i,1));
    audiowrite(strcat('Canciones/clasico' , int2str(i),'_modificado','.wav'), clasico(i,:), fm_clasico(i,1));
end

% cumbia
cumbia=zeros(11, 661503); %matriz, las filas son las señales de las canciones
fm_cumbia=cumbia(11,1); %vector columna con las frecuencias de muestreo
for i=1 : 11
    [s_cumbia, fm_cumbia(i,1)] = audioread(strcat('Canciones/cumbia' , int2str(i),'.mp3'));
    [cumbia(i,:)] = partes_senial (s_cumbia(:,1), fm_cumbia(i,1));
    audiowrite(strcat('Canciones/cumbia' , int2str(i),'_modificado','.wav'), cumbia(i,:), fm_cumbia(i,1));
end


% folklore
folklore=zeros(12, 661503); %matriz, las filas son las señales de las canciones
fm_folklore=folklore(12,1); %vector columna con las frecuencias de muestreo
for i=1 : 12
    [s_folklore, fm_folklore(i,1)] = audioread(strcat('Canciones/folklore' , int2str(i),'.mp3'));
    [folklore(i,:)] = partes_senial (s_folklore(:,1), fm_folklore(i,1));
    audiowrite(strcat('Canciones/folklore' , int2str(i),'_modificado','.wav'), folklore(i,:), fm_folklore(i,1));
end

% rap
rap=zeros(12, 661503); %matriz, las filas son las señales de las canciones
fm_rap=rap(12,1); %vector columna con las frecuencias de muestreo
for i=1 : 12
    [s_rap, fm_rap(i,1)] = audioread(strcat('Canciones/rap' , int2str(i),'.mp3'));
    [rap(i,:)] = partes_senial (s_rap(:,1), fm_rap(i,1));
    audiowrite(strcat('Canciones/rap' , int2str(i),'_modificado','.wav'), rap(i,:), fm_rap(i,1));
end


% reggae
reggae=zeros(11, 661503); %matriz, las filas son las señales de las canciones
fm_reggae=reggae(11,1); %vector columna con las frecuencias de muestreo
for i=1 : 11
    [s_reggae, fm_reggae(i,1)] = audioread(strcat('Canciones/reggae' , int2str(i),'.mp3'));
    [reggae(i,:)] = partes_senial (s_reggae(:,1), fm_reggae(i,1));
    audiowrite(strcat('Canciones/reggae' , int2str(i),'_modificado','.wav'), reggae(i,:), fm_reggae(i,1));
end


% rock
rock=zeros(12, 661503); %matriz, las filas son las señales de las canciones
fm_rock=rock(12,1); %vector columna con las frecuencias de muestreo
for i=1 : 12
    [s_rock, fm_rock(i,1)] = audioread(strcat('Canciones/rock' , int2str(i),'.mp3'));
    [rock(i,:)] = partes_senial (s_rock(:,1), fm_rock(i,1));
    audiowrite(strcat('Canciones/rock' , int2str(i),'_modificado','.wav'), rock(i,:), fm_rock(i,1));
end
