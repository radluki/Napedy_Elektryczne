function dX=Rsrmu(t,X)
%Liniowy model silnika skokowego reluktancyjnego 8/6 (SRM 8/6)
%z zasilaniem napiêciowym.
%Dotyczy silnika LD20ACM-25 (LD20ACM-9).

dX=zeros(6,1);
global Zs Zr R L0 L1 J U D Tz wo
ia=X(1); ib=X(2); ic=X(3); id=X(4); w=X(5); fi=X(6);	%pr¹dy pasm: A, B, C, D oraz prêdkoœæ i k¹t po³o¿enia wirnika
X=[ia;
   ib;
   ic;
   id;
   w;
   fi]; 


%Poni¿ej nale¿y wybraæ rodzaj sterowania pasm silnika:

%Sterowanie unipolarne pe³noskokowe:
warunek=sin(45*pi/180);
if sin(wo*t+(45-0)*pi/180)>warunek,   Ud=U; else Ud=0; end;
if sin(wo*t+(45-90)*pi/180)>warunek,  Uc=U; else Uc=0; end;
if sin(wo*t+(45-180)*pi/180)>warunek, Ub=U; else Ub=0; end;
if sin(wo*t+(45-270)*pi/180)>warunek, Ua=U; else Ua=0; end;

%Sterowanie unipolarne pó³skokowe:
%warunek=sin(22.5*pi/180);
%if sin(wo*t+(22.5-0)*pi/180)>warunek,   Ud=U; else Ud=0; end;
%if sin(wo*t+(22.5-90)*pi/180)>warunek,  Uc=U; else Uc=0; end;
%if sin(wo*t+(22.5-180)*pi/180)>warunek, Ub=U; else Ub=0; end;
%if sin(wo*t+(22.5-270)*pi/180)>warunek, Ua=U; else Ua=0; end;


%Równania silnika:
dLa=-L1*Zr*sin(Zr*fi);			%pochodna indukcyjnosci pasma A po k¹cie po³o¿enia wirnika
dLb=-L1*Zr*sin(Zr*(fi-1*2*pi/Zs));	%pochodna indukcyjnosci pasma B po k¹cie po³o¿enia wirnika
dLc=-L1*Zr*sin(Zr*(fi-2*2*pi/Zs));	%pochodna indukcyjnosci pasma C po k¹cie po³o¿enia wirnika
dLd=-L1*Zr*sin(Zr*(fi-3*2*pi/Zs));	%pochodna indukcyjnosci pasma D po k¹cie po³o¿enia wirnika
La=L0+L1*cos(Zr*fi);			%indukcyjnoœæ pasma A
Lb=L0+L1*cos(Zr*(fi-1*2*pi/Zs));	%indukcyjnoœæ pasma B
Lc=L0+L1*cos(Zr*(fi-2*2*pi/Zs));	%indukcyjnoœæ pasma C
Ld=L0+L1*cos(Zr*(fi-3*2*pi/Zs));	%indukcyjnoœæ pasma D

dX(1)=(Ua-R*ia-dLa*w*ia)/La;		%równanie napiêciowe pasma A
dX(2)=(Ub-R*ib-dLb*w*ib)/Lb;		%równanie napiêciowe pasma B
dX(3)=(Uc-R*ic-dLc*w*ic)/Lc;		%równanie napiêciowe pasma C
dX(4)=(Ud-R*id-dLd*w*id)/Ld;		%równanie napiêciowe pasma D
Te=0.5*(dLa*ia*ia+dLb*ib*ib+dLc*ic*ic+dLd*id*id);	%moment elektromagnetyczny rozwijany przez silnik
dX(5)=(Te-D*w+Tz)/J;			%równanie momentów na wale silnika
dX(6)=w;				%prêdkoœæ obrotowa wirnika

fist=fi*180/pi;				%k¹t po³o¿enia wirnika w stopniach [deg]
