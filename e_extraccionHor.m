%umbral Calculado
iBB=zeros(size(iB));
iBB=iB;
horHist=Px;
gem1=max(horHist);
gem=max(horHist)/2.3;
figure;
plot(horHist);
hstart=0;
heinde=0;
width=0;
hcounter=0;
arc=0;
hcoor=zeros(1,2);
%si el número de píxeles blancos para una cierta distancia (definida como un porcentaje) es mayor que el
%umbral, esta posición se almacena como la posición horizontal de la
%licencia
for i=1:w
    if horHist(i)>gem(1)
        if(hstart==0)
            hstart=i;
        end
        hcounter=0;
    else
        if hstart>0
            if hcounter>(w*0.07)
                heinde=i-hcounter;
                width=heinde-hstart;
                if(width>(w*0.1))
                    arc=arc+1;
                    hcoor(arc,1)=hstart;
                    hcoor(arc,2)=width;
                end
                hstart=37;
                hcounter=0;
                heinde=0;
                width=0;
            end
            hcounter=hcounter+1;
        end
    end
end
[ww,f]=size(hcoor);
hstart=0;
hwidth=0;
% En el caso de que haya una pluralidad de posiciones horizontales se han encontrado para la
% License entonces sólo escogemos la posición más amplia.
for i=1:ww
    if(hcoor(i,2)>hwidth)
        hwidth=hcoor(i,2);
        hstart=hcoor(i,1);
    end
end

iBB=iBB(:,hstart:(hstart+hwidth),:);
axes(handles.axes2);
figure;
imshow(iBB);