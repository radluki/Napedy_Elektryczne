%Skrypt rozwi¹zuje równania pe³nodynamicznego modelu 4-pasmowego silnika
%skokowego reluktancyjnego (SRM) o zasilaniu napiêciowym, zawartego 
%w pliku Rsrmu.m. 
%Wszystkie wartoœci w jednostkach uk³adu SI.
clear; clear all;

global Zs Zr R L0 L1 J U D Tz wo


%Dane silnika oraz jego zasilania i obci¹¿enia:
Zs=8;			%liczba zêbów stojana
Zr=6;			%liczba zêbów wirnika
R=20;			%rezystancja pasma [om]
Lmin=38.4e-3;		%minimalna indukcyjnoœæ pasma [H]
Lmax=152e-3;		%maksymalna indukcyjnoœæ pasma [H]
L0=(Lmax+Lmin)/2;	%wartoœæ œrednia indukcyjnoœci pasma 
L1=(Lmax-Lmin)/2;	%amplituda 1 harmonicznej indukcyjnoœci pasma
J=6.4e-6;		%moment bezw³adnoœci silnika (napêdu) [kg*m^2]
U=20;			%napiêcie zasilaj¹ce pasmo [V]
wo=2*pi*60;		%55/50(102mH)rusza pulsacja pr¹du jednego pasma [Hz]
			%70/60(102 mH) przy 102 mH rusza
D=0.0000001;		%wspó³czynnik t³umienia prêdkoœciowego ruchu [Nm/(rad/sec)] 
			% - trzeba dobraæ go tak, aby nie by³o oscylacji po³o¿enia wirnika 
			%   po wykonaniu skoku, ale te¿ ¿eby nie by³o nadmiernych oporów ruchu
Tz=-0.0052;		%moment zewnêtrzny [Nm] (tutaj maksymalny moment tarcia statycznego)


%Rozwi¹zanie uk³adu równañ ró¿niczkowych modelu silnika:
t0=0; tk=0.4;		%pocz¹tkowy i koñcowy czas symulacji [sec]
X0=[0 0 0 0 0 0];	%warunki pocz¹tkowe (pr¹dy pasm: A, B, C, D oraz prêdkoœæ i k¹t po³o¿enia wirnika)
blad=[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5];
options=odeset('RelTol',1e-5,'AbsTol',blad);
[t,X] = ode45('Rsrmu',[t0 tk],X0,options);



%Koñcowa obróbka wyników symulacji:
ia=X(:,1); ib=X(:,2); ic=X(:,3); id=X(:,4); w=X(:,5); fi=X(:,6);	%pr¹dy pasm: A, B, C, D oraz prêdkoœæ i k¹t po³o¿enia wirnika

for k=1:size(w),
    dLa=-L1*Zr*sin(Zr*fi(k));			%pochodna indukcyjnoœci pasma A po k¹cie po³o¿enia wirnika
    dLb=-L1*Zr*sin(Zr*(fi(k)-1*2*pi/Zs));	%pochodna indukcyjnoœci pasma B po k¹cie po³o¿enia wirnika
    dLc=-L1*Zr*sin(Zr*(fi(k)-2*2*pi/Zs));	%pochodna indukcyjnoœci pasma C po k¹cie po³o¿enia wirnika
    dLd=-L1*Zr*sin(Zr*(fi(k)-3*2*pi/Zs));	%pochodna indukcyjnoœci pasma D po k¹cie po³o¿enia wirnika

    Te(k)=0.5*(dLa*ia(k)*ia(k)+dLb*ib(k)*ib(k)+dLc*ic(k)*ic(k)+dLd*id(k)*id(k)); %moment elektromagnetyczny rozwijany przez silnik
    fist(k)=fi(k)*180/pi;			%k¹t po³o¿enia wirnika w stopniach [deg]
end;

figure(1); plot(t,fist); grid; ylabel('fi [deg]'); xlabel('t [sec]');
figure(2); plot(t,ia); grid; ylabel('ia [A]'); xlabel('t [sec]');
figure(3); plot(t,Te); grid; ylabel('Te [Nm]'); xlabel('t [sec]');
