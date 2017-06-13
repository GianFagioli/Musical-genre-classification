function [matriz, coef] = normColumn(matriz)
    [~,n] = size(matriz);
    coef = zeros(1,n);
    for i=1:n
       coef(i) = max(matriz(:,i));
       matriz(:,i) = matriz(:,i) / coef(i);
    end
end