//Alexis Zankowitch

//Exercice 1 Courbes de Bézier sur [a,b]
//1-changement t vers t_seconde
function T = BezierQuestion1(a,b)
    //traçage B(n)
    T = polyControleBezier(a,b)
    courbeBezier([a:0.01:b],T,a,b)
endfunction

//2-Elevation du degré
function Q = BezierQuestion2(a,b)
    //question 1.2
    T = polyControleBezier(a,b)
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

//3-traçage et constatation de B(n) et B(n+1)
function BezierQuestion3(a,b)
    T = polyControleBezier(a,b)
    n = size(T,1)
    Q(1,:)=T(1,:)
    for i=2:n
        coef1 = i/(n+1)
        coef2 = 1-i/(n+1)
        Q(i,:)=coef1*T(i-1,:)+coef2*T(i,:)
    end
    Q(n+1,:)=T(n,:)
    //traçage B(n)
    courbeBezier([a:0.01:b],T,a,b)
    //traçage B(n+1)
    courbeBezier([a:0.01:b],Q,a,b)
    //Les deux courbes sont sensiblement identiques mais B(n+1) à l'air d'être plus précise, nous vérifirons cette hypothèse à la question 4
endfunction

//4-Generalisation à B(n+d)
function BezierQuestion4(a,b,d)
    T = polyControleBezier(a,b)
    n = size(T,1)
    //il faut repeter la generalisation d-1 fois
    for j=1:d-1
        Q(1,:)=T(1,:)
        for i=2:n
            coef1 = i/(n+1)
            coef2 = 1-i/(n+1)
            Q(i,:)=coef1*T(i-1,:)+coef2*T(i,:)
        end
        Q(n+1,:)=T(n,:)
        disp(Q)
        //A la prochaine iteration il faut utiliser les points de Q
        n=size(Q,1)
        T=Q
        courbeBezier([a:0.01:b],T,a,b)
    end
endfunction

//permet de recuperer les points de controle
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
