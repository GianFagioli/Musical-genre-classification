% Cargar las canciones en se�ales ya particionadas por fragmentos
% 
% cargo todaos los nombres de las canciones 
nomCanciones = ls ('music/*.au');

for i=1 : length(nomCanciones(:,1))
    [s_clasico, fm_clasico] = audioread(strcat('music/' , nomCanciones(i,:)));
    [s_clasico] = partes_senial (s_clasico(:,1), fm_clasico);
    etiqueta = cellstr(nomCanciones(i,(1:3)));
    etiqueta = char(etiqueta);
    audiowrite(strcat('musica/' ,etiqueta, int2str(i),'_modificado','.wav'), s_clasico, fm_clasico);
end