%Calcular una subbanda aplicando filtros Butterworth, devolviendo una señal
%con la mitad de muestra de la señal original (fm/2) y los coeficientes del
%filtro pasa bajo (que son útiles para calcular luego la envolvente).

function [sBanda, numFiltro, denFiltro] = subBandaDWT (audio, fm, L, H)

%definir frecuencia de corte del filtro pasa bajo
FcPasaBajo = 2*L/fm;

%calculo de los coeficientes del filtro pasa alto orden 4
[numFiltro, denFiltro] = butter(2, FcPasaBajo, 'high');

%se le aplica el fitro pasa alto a la se�al
sFiltrada = filtfilt(numFiltro, denFiltro, audio);

%normalizar la banda de alta frecuencia
FcPasaAlto = 2*H/fm;

%lo mismo que hicimos arriba pero con la se�al filtrada
[numFiltro, denFiltro] = butter(2, FcPasaAlto, 'low');

%aplicar fitro pasa bajo a la se�al filtrada previamente
sBanda=filtfilt(numFiltro, denFiltro, sFiltrada);

end