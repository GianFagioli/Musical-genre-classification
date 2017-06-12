function [envoCorrelacion]=autoCorrelacion(sumaEnvo, ampEnvoltorio, minBPM, maxBPM)

posFin=ceil((60*ampEnvolorio)/minBPM);
posInicio=ceil((60*ampEnvolorio)/maxBPM);

totalMuestra = length(sumaEnvo) - posFin;

envoCorrelacion = zeros (posFin, 1);

for pos=posInicio:posFin
    sum = 0;
    for i=1 : totalMuestra
        sum = sum + (sumaEnvoltorio(i) * sumaEnvoltorio(i+pos));
    end
    envoCorrelacion(pos)= envoCorrelacion(pos)+sum;
end
end
