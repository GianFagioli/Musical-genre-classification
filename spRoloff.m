% Spectral Roloff: Es la frecuencia en la cual se concentra el 85 porciento
% de la magnitud de la distribucion
function rol = spRoloff(v_stft) 
	rol = find(cumsum(v_stft) >= .85*sum(v_stft), 1);
% 	cumsum suma los valores hasta la posicion (cs[1] = v[1], cs[2] =
% 	v[1]+v[2] ...) por lo que lo que se hace es encontrar el valor
% 	acumulado (la frecuencia en este caso) en el cual se concentre el 85%
% 	del total (la suma de los valores)
end
