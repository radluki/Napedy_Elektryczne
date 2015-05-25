function dX=Rsrmi(t,X)
%Liniowy model silnika skokowego reluktancyjnego 8/6 (SRM 8/6)
%z zasilaniem pr¹dowym
%Dotyczy silnika LD20ACM-25 (obecnie produkowany odpowiednik: LD20ACM-9)
%w - prêdkoœæ, fi - k¹t po³o¿enia wirnika (mechaniczny)
dX=zeros(2,1);
global Zs Zr L1 J I D Tz wo

w=X(1); fi=X(2);
X=[w;
   fi]; 

%Poni¿ej wklej zasilanie pasm silnika:
%Sterowanie unipolarne pe³noskokowe pr¹dowe:
%wo=0.5*2*pi;
warunek=sin(45*pi/180);
if sin(wo*t+(45-0)*pi/180)>warunek, id=I; else id=0; end;
if sin(wo*t+(45-90)*pi/180)>warunek, ic=I; else ic=0; end;
if sin(wo*t+(45-180)*pi/180)>warunek, ib=I; else ib=0; end;
if sin(wo*t+(45-270)*pi/180)>warunek, ia=I; else ia=0; end;

%Równania silnika:
dLa=-L1*Zr*sin(Zr*fi);
dLb=-L1*Zr*sin(Zr*(fi-1*2*pi/Zs));
dLc=-L1*Zr*sin(Zr*(fi-2*2*pi/Zs));
dLd=-L1*Zr*sin(Zr*(fi-3*2*pi/Zs));
Te=0.5*(dLa*ia*ia+dLb*ib*ib+dLc*ic*ic+dLd*id*id);
dX(1)=(Te-D*w+Tz)/J;
dX(2)=w;
fist=fi*180/pi; %k¹t po³o¿enia wirnika w stopniach
