function [s] = partes_senial (x, Fm)
    % extrae 3 fragmentos de la cancion, en 23%, 50% y 73% de 5 seg.
    % retorna la señal toda junta
    
    t_total = length(x)/Fm; %tiempo total de la señal
    
    % Calculo el tiempo y posicion de los valores de la señal para ese
    %tiempo
    t23= 23*t_total/100;
    x23= round(t23*Fm);
    
    t50= 50*t_total/100;
    x50= round(t50*Fm);
    
    t73= 73*t_total/100;
    x73= round(t73*Fm);
    
    % Obtengo 3 vectores de 5 seg de duracion
    x5= 5*Fm; %cantidad de elementos para una duracion de 5 seg
    
    vector_t1= x(x23 : x23+x5);    
    vector_t2= x(x50 : x50+x5);
    vector_t3= x(x73 : x73+x5);
    
    s= [vector_t1 vector_t2 vector_t3];
end