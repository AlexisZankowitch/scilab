//ALEXIS ZANKOWITCH
// ROMAIN CARON


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

// question 1 t=7 k=1
// question 3 t = 7 k=2
function cx = homogene(t,k)
    cx = []
    interval = [0:1:t]
    for i = 0 : 0.01 : t 
        cx = [cx,intHomogene(i,interval,k)]
    end
    t=[0:0.01:t]
    for i=1 : size(cx,1)
        plot(t,cx(i,:))
    end
endfunction

function  cx = nonHomogene(t,k)
    cx = []
    for i = 0 : 0.01 : t 
        cx = [cx,intNonHomogene(i,t,k)]
    end
    t=[0:0.01:t]
    for i=1 : size(cx,1)
        plot(t,cx(i,:))
    end
endfunction

//T est un vecteur noeud k est le degré des bj on peut utiliser cette fonction pour generer les bj
function cx = bjk(t,k,col)
    cx = []
    taille = size(t,2)
    for i = 0 : 0.01 : taille
        cx = [cx,intHomogene(i,t,k)]
    end
    t=[0:0.01:size(t,2)]
    for i=1 : size(cx,1)
        plot(t,cx(i,:),col)
    end
endfunction

//les noeuds multiples sont confondus leur courbes n'est pas dérivable car on a un pique

//à ne pas appeler intHomogene et intNonHomogene avec k 3,4,etc... et j dernier chiffre de j
function base = intHomogene(t,m,n)
    base = baseBspline(t,m)
    for j = 1 : n
        for i = 1 : size(base,1)-j
            deno = (m(i+j)-m(i))
            denoNH = (m(i+j+1)-m(i+1))
            if(deno==0)
                coef1 = 0
            else
                coef1 = (t-m(i))/ deno
            end
            if(denoNH==0)
                coef2 = 0
            else
                coef2 = (m(i+j+1)-t)/ denoNH
            end
            base(i) = coef1 * base(i) + coef2 * base(i+1)
        end
    end
    taille = size(m,2)-n-1
    base =  base(1:taille,1)//recupere lignes
endfunction


function base = intNonHomogene(t,m,n)
    interval = [0,1,2,3,5,6,7]
    base = baseBspline(t,interval)
    for j = 1 : n
        for i = 1 : size(base,1)-j
            disp(size(base,1)-j)
            deno = (interval(i+j)-interval(i))
            denoNH = (interval(i+j+1)-interval(i+1))
            coef1 = (t-interval(i))/ deno
            coef2 = (interval(i+j+1)-t)/ denoNH
            base(i) = coef1 * base(i) + coef2 * base(i+1)
            //probleme calcul bj1
        end
    end
    taille = size(interval,2)-n-1
    base =  base(1:taille,1)
endfunction

function question1()
    bjk([0,1,2,3,4,5,6],1,'r-')
endfunction

function question2()
    bjk([0,1,2,3,5,6,7],1,'r-')
endfunction

function question3()
    bjk([0,1,2,3,4,5,6],2,'r-')
    bjk([0,1,2,3,5,6,7],2,'b-')
endfunction

function question4()
    bjk([0,1,2,3,5,8,9,11],3,'b-')
    bjk([0,1,2,3,4,5,6,7],3,'r-')
endfunction

function question5()
    disp("voir function bjk")
endfunction

function question6()
    bjk([0,1,2,3,3,3,4,5],3,'b-')
    bjk([1,1,1,1,2,3,4,5],3,'r-')
endfunction

function question7()
    disp("ça vaut 1 aux noeud multiples et la courbes est en triangle. ce nest pas derivable")
endfunction

function question8()
    
endfunction

function question9()
    bjk([0,0,0,0,1,1,1,1],3,'g-')
endfunction
