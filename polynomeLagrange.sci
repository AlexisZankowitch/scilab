function p = polynomeLagrange(i,n)
    p = 1;
    x=[0:1/n:1];
    for j=1:n+1
        if i <> j then
            p = p * poly([-x(j) 1],"x","coeff")*(x(i)-x(j))^(-1);
        end
    end
endfunction

function P = polyLagrangeBase(f,n)
    P = 0;
    x = [0:1/n:1];
    for i=1:n+1
        P=P+f(x(i))* polynomeLagrange(i,n)
    end
endfunction
function y=f(x)
    y = sin(10*x.*cos(x));
endfunction
