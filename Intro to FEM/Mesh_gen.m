clc
clear all
close all
Ri=6;  %inches
Ro=7;  %inches
THETAi=0;     %in radians
THETAf=pi/2;
NR=2;
NH=10;
DELTR=(Ro-Ri)/(2*NR);
DELTH=(pi/2)/(2*NH);
%% GLOABL-COORDINATES OF THE MESHES IN X-Y
ITRN=1;
IJK=0;
XX=@(r,theta) r*cos(theta);
YY=@(r,theta) r*sin(theta);
NUMNODES=((NH+1)*(2*NR+1)+ (NH*(NR+1)));
NUMELEM=NR*NH;      %%%WRITE THIS IN DAT.FILE
NODES=zeros(NUMNODES,5);     %%%WRITE THIS IN DAT.FILE
for COUNT1=1:(2*NH+1)
    %for odd numbering of the lines for THETA DIRECTIONS 2*NR+1 NODES
    if rem(COUNT1,2)~=0
        for COUNT2=1:(2*NR+1)
            R(ITRN)=Ri+(COUNT2-1)*DELTR;
            THETA(ITRN)=THETAi+(COUNT1-1)*DELTH  ; %H and THETA ARE USED INTERCHANGEABLY
            X(ITRN)=XX(R(ITRN),THETA(ITRN));
            Y(ITRN)=YY(R(ITRN),THETA(ITRN));
            rval=R(ITRN) ; thetaval=THETA(ITRN);
            xval=X(ITRN);  yval=Y(ITRN);
            IJK=IJK+1;
            ITRN=ITRN+1;
            NODES(IJK,:)=[IJK rval thetaval xval yval];
            
            
        end
        %for even numbering of the lines for THETA DIRECTIONS 2*NR+1 NODES
        
    elseif rem(COUNT1,2)==0
        for COUNT3=1:(NR+1)
            R(ITRN)=Ri+(COUNT3-1)*(2*DELTR);
            THETA(ITRN)=THETAi+(COUNT1-1)*DELTH ;  %H and THETA ARE USED INTERCHANGEABLY
            X(ITRN)=XX(R(ITRN),THETA(ITRN));
            Y(ITRN)=YY(R(ITRN),THETA(ITRN));
            rval=R(ITRN) ; thetaval=THETA(ITRN);
            xval=X(ITRN);  yval=Y(ITRN);
            IJK=IJK+1;
            ITRN=ITRN+1;
            NODES(IJK,:)=[IJK rval thetaval xval yval];
        end
    end
end
%%%
disp(NODES)


NPE=8;   %FOR Q8-RECTANGULAR/QUARDILATERAL ELEMENT NPE=8 NUMBER OF NODES
B=zeros(NH,NR);    %NODE CONNECTIVITY MATRIX

for COUNT4=1:NH    %NH:- NUMBER OF ELEMENTS IN THE HOOP OR THETA DIRECTION
    for COUNT5=1:NR
        ELENUM=(COUNT4-1)*NR+COUNT5;
        for LNUMNODES=1:NPE
            if LNUMNODES==1
                B(ELENUM,LNUMNODES)=COUNT4*(3*NR+2)+1+2*(COUNT5-1);
            elseif LNUMNODES==2
                B(ELENUM,LNUMNODES)=(COUNT4-1)*(3*NR+2)+1+2*(COUNT5-1);
            elseif LNUMNODES==3
                B(ELENUM,LNUMNODES)=(COUNT4-1)*(3*NR+2)+1+2*(COUNT5);
            elseif LNUMNODES==4
                B(ELENUM,LNUMNODES)=(COUNT4)*(3*NR+2)+1+2*(COUNT5);
            elseif LNUMNODES==5
                B(ELENUM,LNUMNODES)=(COUNT4)*(2*NR+1)+(COUNT4-1)*(NR+1)+COUNT5;
            elseif LNUMNODES==6
                B(ELENUM,LNUMNODES)=(COUNT4-1)*(3*NR+2)+2*COUNT5;
            elseif LNUMNODES==7
                B(ELENUM,LNUMNODES)=(COUNT4)*(2*NR+1)+(COUNT4-1)*(NR+1)+(COUNT5+1);
            elseif LNUMNODES==8
                B(ELENUM,LNUMNODES)=(COUNT4)*(3*NR+2)+2*COUNT5;
            end
        end
    end
end