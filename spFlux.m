%{
Spectral Flux: El flujo espectral es una medida de cuan rápido cambia el 
espectro de la señal, comparando el espectro de un período con  el espectro 
anterior, más precisamente, es la norma 2 entre los dos espectros normaliza-
dos. Es usado para determinar el timbre de una señal de audio.
Esto se calcula luego de tener las transformadas de todas las ventanas, en-
tonces para cada par de ventanas se calcula el flujo en Ft(i). En tr_f ten-
go las transformadas de cada ventana de la señal, por lo tanto, normalizo 
cada transformada y comparo ventana a ventana (sus transformadas), haciendo
la sumatoria del cuadrado de la diferencia.
%}
function Ft = spFlux(tr_f)
	%Normalizo las transformadas: Divido cada fila (en val abs) por el maximo.
	vn_stft = zeros(size(tr_f));
	n = size(tr_f);
	for k=1:n
		vn_stft(k,:) = abs(tr_f(k,:));
	end

	vn_stft(1,:) = vn_stft(1,:) / max(vn_stft(1,:));
	for k=2:n
		vn_stft(k,:) = vn_stft(k,:) / max(vn_stft(k,:));
		Ft(k) = sum((vn_stft(k,:) - vn_stft(k-1,:)).^2);
	end
end
