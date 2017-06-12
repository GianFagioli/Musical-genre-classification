function [sEnvolvente]=envolvente(sBanda, fmNueva, numFiltro, denFiltro)

%rectificacion de onda completa
sBanda=abs(sBanda);

%filtro pasa bajo
sFiltada=filtfilt(nunFiltro, denFiltro, sBanda);

%sub-muestreo
sFiltrada = sFiltrada(1:2:end);

%remover la media
sFiltrada = sFiltrada - mean(sFiltrada);

%envolvente rectificada
Tw = 0.1;
Nw = Tw * fmNueva;
w=ones(Nw,1)/Nw;

sEnvolvente = conv(sFiltrada, w, 'same');

end