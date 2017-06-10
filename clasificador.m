load fisheriris %Cargo los datos al vector meas y species (largo y ancho de petalos y sepalos de tres especies de flores)
SL = meas(51:end,1); %separo los ultimos 51 largos de petalos
SW = meas(51:end,2);%separo los ultimos 51 anchos de petalos
group = species(51:end);%etiqueto esos ultimos 51 datos
h1 = gscatter(SL,SW,group,'rb','v^',[],'off');%grafico
set(h1,'LineWidth',2)
legend('Fisher versicolor','Fisher virginica',...
       'Location','NW')

%ahora clasifico


