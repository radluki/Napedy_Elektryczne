%Skrypt rozwi¹zuje pe³nodynamiczne równania modelu 4-pasmowego silnika
%skokowego reluktancyjnego (SRM) o zasilaniu pr¹dowym zawarte 
%w pliku Rsrmi.m
clear; clear all;



%Dane silnika oraz jego zasilania i obci¹¿enia:
Zs=8;		%liczba zêbów stojana
Zr=6;		%liczba zêbów wirnika
L1=33.8e-3;	%45.58e-3; L1=(Lmax-Lmin)/2
J=0.103e-6;	%moment bezw³adnoœci silnika (napêdu)
I=1.4;		%pr¹d pasma
D=0.001;	%wspó³czynnik t³umienia prêdkoœciowego
Tz=0;		%moment zewnêtrzny
wo=32*2*pi;

global Zs Zr L1 J I D Tz wo

t0=0; tk=0.08; X0=[0 0*2*pi/360];
	%blad=[1e-5 1e-5];
tic
	%options=odeset('RelTol',1e-5,'AbsTol',blad);
	%[t,X] = ode45('Rsrmi',[t0 tk],X0,options);
[t,X] = ode45('Rsrmi',t0,tk,X0,1e-5);
toc

w=X(:,1); fi=X(:,2);

for k=1:size(w),
    warunek=sin(45*pi/180);
    if sin(wo*t(k)+(45-0)*pi/180)>warunek, id(k)=I; else id(k)=0; end;
    if sin(wo*t(k)+(45-90)*pi/180)>warunek, ic(k)=I; else ic(k)=0; end;
    if sin(wo*t(k)+(45-180)*pi/180)>warunek, ib(k)=I; else ib(k)=0; end;
    if sin(wo*t(k)+(45-270)*pi/180)>warunek, ia(k)=I; else ia(k)=0; end;
    dLa=-L1*Zr*sin(Zr*fi(k));
    dLb=-L1*Zr*sin(Zr*(fi(k)-1*2*pi/Zs));
    dLc=-L1*Zr*sin(Zr*(fi(k)-2*2*pi/Zs));
    dLd=-L1*Zr*sin(Zr*(fi(k)-3*2*pi/Zs));
    Te(k)=0.5*(dLa*ia(k)*ia(k)+dLb*ib(k)*ib(k)+dLc*ic(k)*ic(k)+dLd*id(k)*id(k));
    fist(k)=fi(k)*180/pi;
end;

figure(1); plot(t,fist); grid; ylabel('fi [deg]'); xlabel('czas [sec]');
figure(2); plot(t,id); grid; ylabel('id [A]'); xlabel('czas [sec]');
figure(3); plot(t,Te); grid; ylabel('Te [Nm]'); xlabel('czas [sec]');

