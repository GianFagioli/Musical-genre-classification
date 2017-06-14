function [sEnvolvente]=envolventeDWT(sBanda)
%rectificacion de onda completa
sBanda=abs(sBanda);

%filtro pasa bajo
alfa = 0.99;
sFiltrada = zeros(size(sBanda));
for i=2:length(sBanda)
    sFiltrada(i) = sBanda(i) * (1-alfa) + alfa * sFiltrada(i-1);
end

%sub-muestreo
sFiltrada = sFiltrada(1:2:end);

%remover la media
sEnvolvente = sFiltrada - mean(sFiltrada);

end