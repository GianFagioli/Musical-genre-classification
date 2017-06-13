function [envoCorrelacion]=autoCorrelacion(sumaEnvo, ampEnvoltorio, minBPM, maxBPM)

posFin=ceil((60*ampEnvoltorio)/minBPM);
posInicio=ceil((60*ampEnvoltorio)/maxBPM);

totalMuestra = length(sumaEnvo) - posFin;

envoCorrelacion = zeros (posFin, 1);

for pos=posInicio:posFin
    sum = 0;
    for i=1 : totalMuestra
        sum = sum + (sumaEnvo(i) * sumaEnvo(i+pos));
    end
    envoCorrelacion(pos)= envoCorrelacion(pos)+sum;
end
end
