%Program wylicza statyczn� zale�no�ci momentu postojowego silnika
%od k�ta wychylenia wirnika oraz prezentuje j� na tle analogicznej
%zale�no�ci pomiarowej (t� trzeba r�cznie wpisa� w tym programie)
clear; clear all;



%Wyniki pomiar�w:
%Uwaga: moment elektromagnetyczny silnika pomiarowy: Tepom = mgr - Ttarcia
fipom=[255.54,253.02,251.26,250.56,249.5,249.5,247.74,247.74,247.39,244.93,241.76,240]-240;	%k�ty zmierzone[deg]
mgr  =[ 0.0998337927,0.0903857997,0.0841921154,0.0766757121,0.0703770501, ...
0.0665978529,0.0602991909,0.0508511979,0.0445525359,0.0382538739,0.0319552119,0.0225072189];	%momenty zmierzone [Nm]


Ttarcia=0.0050;					%zmierzony moment si� tarcia statycznego [Nm]
Tepom=mgr-Ttarcia; Tepom(1)=0;




%Dane silnika oraz jego zasilania:
Zs=8;		%liczba z�b�w stojana
Zr=6;		%liczba z�b�w wirnika
Lmin=50e-3;	%38.4e-3minimalna indukcyjno�� pasma
Lmax=152e-3;	%maksymalna indukcyjno�� pasma
L1=(Lmax-Lmin)/2; %amplituda 1 harmonicznej indukcyjno�ci pasma
ia=0.9;		%pr�dy pasm [A] 
ib=0; 
ic=0; 
id=0;



%Obliczenie zale�no�ci elektromagnetycznego momentu postojowego silnika od k�ta wychylenia wirnika:
for fist=1:30,	%k�t wychylenia wirnika w [deg]
    fi=fist*(2*pi/360);
    dLa=-L1*Zr*sin(Zr*fi);
    dLb=-L1*Zr*sin(Zr*(fi-1*2*pi/Zs));
    dLc=-L1*Zr*sin(Zr*(fi-2*2*pi/Zs));
    dLd=-L1*Zr*sin(Zr*(fi-3*2*pi/Zs));
    Te(fist)=0.5*(dLa*ia*ia+dLb*ib*ib+dLc*ic*ic+dLd*id*id);
    Fist(fist)=fist;
end;
figure(1); plot(Fist,abs(Te),fipom,Tepom,'+'); grid; ylabel('Te [Nm]'); xlabel('k�t [deg]');
