function C=centroide_espectral(S)   %se pasa como parametro la transformada de tiempo corto
	numerador = 0;
	denominador = 0;
	for n=1:length(S)
		numerador=numerador + S(n)*n;
		denominador=denominador + S(n);
	end
	C=numerador/denominador;
end
