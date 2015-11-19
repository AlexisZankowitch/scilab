//xclick recuperation coordonnés clique souris

function T = pointPolyControle()
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
    courbeBezier([0:0.01:1],T)
endfunction

function pBernstein = bernstein(n,i,t)
    pBernstein = calculCoefBino(n,i)*(t).^i.*(1-t).^(n-i)
endfunction

function coefBino = calculCoefBino(n,i)
    coefBino = factorial(n)/(factorial(i)*factorial(n-i))
endfunction

function bezier = courbeBezier(t,P)
    bezier=0;
    for i=0:size(P,1)-1
        bezier = bezier + P(i+1,:)'*bernstein(size(P,1)-1,i,t)
    end
    plot2d(bezier(1,:),bezier(2,:))
endfunction
