function[x1,x2]=randGenerator(no)

for counter=1:no
    x1(counter)=-2+4*rand(1,1,'unifor')
    x2(counter)=-2+4*rand(1,1,'unifor')
end
endfunction


function[sal]=FunObj(x1,x2)
for counter1=1:100
    sal(counter1)=abs(( 1+ (x1(counter1)+x2(counter1)+1)^2 * ( 19-14*x1(counter1)+ 13*x1(counter1)^2 -14*x2(counter1) + 6*x1(counter1)*x2(counter1) + 3*x2(counter1)^2  ) ) * ( 30 + (2*x1(counter1)-3*x2(counter1))^2*(18-32*x1(counter1) +12*x1(counter1)^2 - 48*x2(counter1) -36*x1(counter1)*x2(counter1) + 27*x2(counter1)^2 )  ))
 end 
endfunction

function [normal]= Normalizar(sal,suma)
    for counter=1:100
        normal(counter)= sal(counter)/suma
    end
endfunction

function [randomColumn]=  RandomColumn()
    for i=1:100
        randomColumn(i)=rand(1,1,'uniform')
    end
endfunction

function [decSum]= DecSum(normal,randomCol)
    for i=1:100
        decSum(i)= normal(i)-randomCol(i)
    end
endfunction

function [p1,p2,fx]= tournamentOperator(x1,x2,m,obj)
    for i=1:40
        fitness=0
        minIndex=1+round(98*rand(1,1,'unifor'))
        maxIndex= minIndex+2
        for j=minIndex:maxIndex
            if m(j)>fitness
                fitness=m(j)
                p1(i)=x1(j)
                p2(i)=x2(j)
                fx(i)=obj(j)
            end
        end
    end
endfunction

function [p1,p2,fx]= NewOperator(x1,x2,m,obj)
    indexSelected(1)=-1
     o=RandomColumn()
    fitness= DecSum(m,o)
    [value,index]= max(fitness)
    p1(1)=x1(index)
    p2(1)=x2(index)
    fx(1)=m(index)
    for i=1:40
        while find(indexSelected==index) ~= []
            o=RandomColumn()
            fitness=DecSum(m,o) 
            [value,index]= max(fitness)
            p1(i)=x1(index)
            p2(i)=x2(index)
            fx(i)=obj(index)
        end
        indexSelected(i)= index
        
    end
endfunction


[x1,x2]=randGenerator(100)
obj=FunObj(x1,x2)
//salO=gsort(obj)
suma= sum(obj)
m= Normalizar(obj,suma)
n= sum(m)
o= RandomColumn()
p=(DecSum(m,o))

[q,r,s]=NewOperator (x1,x2,m,obj)
t=[q;r;s]
u=matrix(t,40,3)

[v,w,x]=tournamentOperator(x1,x2,m,obj)
y=[v;w;x]
y=matrix(y,40,3)


/*
[maxValue,maxIndex]= max(p)

selectedParent1= x1(maxIndex)
selectedParent2= x2(maxIndex)*/




