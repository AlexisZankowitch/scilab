//xclick recuperation coordonnés clique souris

function T = polyControleBezier(a,b)
    ibutton = 0;
    i=1;
    while (ibutton <> 2 & ibutton <> 5)
        plot2d(0,0,rect=[0,0,3,3])
        [ibutton,x,y]=xclick()
        T(i,:)=[x,y]
        plot(x,y,"ro");
        if(i>1)
            plot([T(i-1,1),T(i,1)],[T(i-1,2),T(i,2)])
        end
        i = i+1
    end
    //traçage B(n)
    courbeBezier([a:0.01:b],T,a,b)
    //question 1.2
    n = size(T,1)
    Q(1,:)=T(1,:)
    for i=2:n
        coef1 = i/(n+1)
        coef2 = 1-i/(n+1)
        Q(i,:)=coef1*T(i-1,:)+coef2*T(i,:)
    end
    Q(n+1,:)=T(n,:)
    //traçage B(n+1)
    courbeBezier([a:0.01:b],Q,a,b)
endfunction

function pBernstein = bernstein(n,i,t)
    pBernstein = calculCoefBino(n,i)*(t).^i.*(1-t).^(n-i)
endfunction

function coefBino = calculCoefBino(n,i)
    coefBino = factorial(n)/(factorial(i)*factorial(n-i))
endfunction

function bezier = courbeBezier(t,P,a,b)
    bezier=0;
    // question 1.1 on remplace t par t_second avec t appartient a [a,b] pour paramètre 
    t_second = (t-a)/(b-a)
    for i=0:size(P,1)-1
        bezier = bezier + P(i+1,:)'*bernstein(size(P,1)-1,i,t_second)
    end
    plot2d(bezier(1,:),bezier(2,:))
endfunction
