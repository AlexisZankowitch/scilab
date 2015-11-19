function a = lagBaseCanonique(f,n)
    h = 1/n;
    X = [0:h:1]';
    A = [];
    for i=0:n
        A=[A X.^i]
    end
    y = f(X);
    a = A\y
    
    x = [0:0.01:1];
    plot2d(x,f(x));
    p=0;
    for i=0:n
        p=p + a(i+1)*x.^i
    end
    plot2d(x,p,5);
endfunction
function y=f(x)
    y = sin(10*x.*cos(x));
endfunction
