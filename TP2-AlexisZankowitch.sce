//ALEXIS ZANKOWITCH

function T = polyControleBsplines()
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
    p=[0:0.01:1]
    eq=zeros(size(p,2),2)
    compteur = 1
    //nombre de clic = matrice coxDeBoor
    for i = 0 : 0.01 : 1 
        cx = coxDeBoor(i,2*size(T,1)-1,size(T,1)-1)
        for j = 1 : size(cx,1)
            eq(compteur,:) = eq(compteur,:) + T(j,:)*cx(j)
        end
        compteur = compteur + 1
    end
    plot(eq(:,1),eq(:,2),'Color',[1 0 0],'LineWidth',2)
endfunction

function base = baseBspline(t,interval)
    base = 0
    for i=1:size(interval,2)-1
        if t>= interval(i) & t < interval(i+1)
            base(i) = 1
        else 
            base(i) = 0
        end
    end
endfunction

function base = coxDeBoor(t,m,n)
    interval = [0:1/m:1]
    base = baseBspline(t,interval)
    a = 0
    for j = 1 : n
        for i = 1 : size(base,1)-j
            deno = (interval(i+j)-interval(i))
            denoNH = (interval(i+j+1)-interval(i+1))
            coef1 = (t-interval(i))/ deno
            coef2 = (interval(i+j+1)-t)/ deno //changer par denoNH si interval non homogene
            base(i) = coef1 * base(i) + coef2 * base(i+1)
        end
    end
    base =  base(1:m-n,1)//recupere quatres premieres lignes
endfunction

function base = question1()
    interval = [0:1:6]
    for t = 0 : 1 :6
        base = baseBspline(t,interval)
        a = 0
        for j = 1 : 1
            for i = 1 : size(base,1)-j
                deno = (interval(i+j)-interval(i))
                denoNH = (interval(i+j+1)-interval(i+1))
                coef1 = (t-interval(i))/ deno
                coef2 = (interval(i+j+1)-t)/ deno //changer par denoNH si interval non homogene
                base(i) = coef1 * base(i) + coef2 * base(i+1)
            end
        end
        plot(base)
        //base =  base(1:m-n,1)//recupere quatres premieres lignes
    end
endfunction
