function T = polyControleCasteljau()
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
    DeCasteljau(T,[0:0.1:1])
endfunction

function x = calcBarycentre(x,t)
    for i=1:size(x,1)-1
        barycentre(i,:) = (1-t)*x(i,:)+ t*x(i+1,:);
    end
    x = barycentre
    if((size(x,1)>1))
       x = calcBarycentre(x,t);
    end
endfunction

function y = DeCasteljau(P,T)
    for i=1:size(T,2)
        y(i,:)=calcBarycentre(P,T(i))
    end
    plot2d(y(:,1),y(:,2))
endfunction
