W tym pliku s¹ sk³adowane ró¿ne sterowania silnika skokowego reluktancyjnego 
(SRM) o 8 zêbach na stojanie i 6 zêbach na wirniku (4-pasmowego), o skoku 15 stopni. 
Przeznaczone s¹ one do "wklejenia" w model takiego silnika zawarty w plikach:
srmi.t (zasilanie pr¹dowe) lub srmu.t (zasilanie napiêciowe - wymagana zamiana
symboli "ia, ib, ic, id" na "ua, ub, uc, ud" oraz symbolu "I" na "U").



%Sterowanie unipolarne pe³noskokowe pr¹dowe:
%wo=0.5*2*pi;
warunek=sin(45*pi/180);
if sin(wo*t+(45-0)*pi/180)>warunek, id=I; else id=0; end;
if sin(wo*t+(45-90)*pi/180)>warunek, ic=I; else ic=0; end;
if sin(wo*t+(45-180)*pi/180)>warunek, ib=I; else ib=0; end;
if sin(wo*t+(45-270)*pi/180)>warunek, ia=I; else ia=0; end;



%Sterowanie unipolarne pó³skokowe pr¹dowe:
%wo=0.5*2*pi;
warunek=sin(22.5*pi/180)
if sin(wo*t+(22.5-0)*pi/180)>warunek, id=I; else id=0; end;
if sin(wo*t+(22.5-90)*pi/180)>warunek, ic=I; else ic=0; end;
if sin(wo*t+(22.5-180)*pi/180)>warunek, ib=I; else ib=0; end;
if sin(wo*t+(22.5-270)*pi/180)>warunek, ia=I; else ia=0; end;



%Sterowanie unipolarne æwieræskokowe (mikroskokowe) pr¹dowe:
%wo=0.5*2*pi;
kat=mod(wo*t,pi/3)*180/pi

if kat<26.25, id=0.5*I; else id=0; end;
if kat<22.5,  id=I; 	end;
if kat<3.75,  id=0.5*I; end;


ic=if kat<15		then 0 else ic1
ic1=if kat<18.75	then 0.5*I else ic2
ic2=if kat<37.5		then I else ic3
ic3=if kat<41.25	then 0.5*I else 0

ib=if kat<30		then 0 else ib1
ib1=if kat<33.75	then 0.5*I else ib2
ib2=if kat<52.5		then I else ib3
ib3=if kat<56.25	then 0.5*I else 0

ia=if kat<7.5		then I else ia1
ia1=if kat<11.25	then 0.5*I else ia2
ia2=if kat<45		then 0 else ia3
ia3=if kat<48.75	then 0.5*I else ia4
ia4=if kat<67.5		then I else ia5
ia5=if kat<71.25	then 0.5*I else 0

"Sterowanie unipolarne æwieræskokowe (mikroskokowe) trójk¹towe pr¹dowe:
kat=mod(wo*t,pi/3)*180/pi
id=if kat<3.75		then I*0.25	else id1
id1=if kat<7.5		then I*0.5	else id2
id2=if kat<11.25	then I*0.75	else id3
id3=if kat<15		then I		else id4
id4=if kat<18.75	then I*0.75	else id5
id5=if kat<22.5		then I*0.5	else id6
id6=if kat<26.25	then I*0.25	else 0

ic=if kat<15		then 0		else ic1
ic1=if kat<18.75	then I*0.25	else ic2
ic2=if kat<22.5		then I*0.5	else ic3
ic3=if kat<26.25	then I*0.75	else ic4
ic4=if kat<30		then I		else ic5
ic5=if kat<33.75	then I*0.75	else ic6
ic6=if kat<37.5		then I*0.5	else ic7
ic7=if kat<41.25	then I*0.25	else 0

ib=if kat<30		then 0		else ib1
ib1=if kat<33.75	then I*0.25	else ib2
ib2=if kat<37.5		then I*0.5	else ib3
ib3=if kat<41.25	then I*0.75	else ib4
ib4=if kat<45		then I		else ib5
ib5=if kat<48.75	then I*0.75	else ib6
ib6=if kat<52.5		then I*0.5	else ib7
ib7=if kat<56.25	then I*0.25	else 0

ia=if kat<3.75		then I*0.75	else ia1
ia1=if kat<7.5		then I*0.5	else ia2
ia2=if kat<11.25	then I*0.25	else ia3
ia3=if kat<45		then 0		else ia4
ia4=if kat<48.75	then I*0.25	else ia5
ia5=if kat<52.5		then I*0.5	else ia6
ia6=if kat<56.25	then I*0.75	else I

"Sterowanie unipolarne æwieræskokowe (mikroskokowe) sinusoidalne pr¹dowe:
kat=mod(wo*t,pi/3)*180/pi
id=if kat<3.75		then I*sin(22.5*pi/180)	else id1
id1=if kat<7.5		then I*sin(45*pi/180)	else id2
id2=if kat<11.25	then I*sin(67.5*pi/180)	else id3
id3=if kat<15		then I			else id4
id4=if kat<18.75	then I*sin(67.5*pi/180) else id5
id5=if kat<22.5		then I*sin(45*pi/180)	else id6
id6=if kat<26.25	then I*sin(22.5*pi/180) else 0

ic=if kat<15		then 0			else ic1
ic1=if kat<18.75	then I*sin(22.5*pi/180)	else ic2
ic2=if kat<22.5		then I*sin(45*pi/180)	else ic3
ic3=if kat<26.25	then I*sin(67.5*pi/180)	else ic4
ic4=if kat<30		then I			else ic5
ic5=if kat<33.75	then I*sin(67.5*pi/180) else ic6
ic6=if kat<37.5		then I*sin(45*pi/180)	else ic7
ic7=if kat<41.25	then I*sin(22.5*pi/180) else 0

ib=if kat<30		then 0			else ib1
ib1=if kat<33.75	then I*sin(22.5*pi/180)	else ib2
ib2=if kat<37.5		then I*sin(45*pi/180)	else ib3
ib3=if kat<41.25	then I*sin(67.5*pi/180)	else ib4
ib4=if kat<45		then I			else ib5
ib5=if kat<48.75	then I*sin(67.5*pi/180) else ib6
ib6=if kat<52.5		then I*sin(45*pi/180)	else ib7
ib7=if kat<56.25	then I*sin(22.5*pi/180) else 0

ia=if kat<3.75		then I*sin(67.5*pi/180)	else ia1
ia1=if kat<7.5		then I*sin(45*pi/180)	else ia2
ia2=if kat<11.25	then I*sin(22.5*pi/180)	else ia3
ia3=if kat<45		then 0			else ia4
ia4=if kat<48.75	then I*sin(22.5*pi/180) else ia5
ia5=if kat<52.5		then I*sin(45*pi/180)	else ia6
ia6=if kat<56.25	then I*sin(67.5*pi/180) else I

"Sterowanie unipolarne æwieræskokowe (mikroskokowe) sinusoidalne
"z pierwiastkowaniem, pr¹dowe:
kat=mod(wo*t,pi/3)*180/pi
id=if kat<3.75		then I*sqrt(sin(22.5*pi/180))	else id1
id1=if kat<7.5		then I*sqrt(sin(45*pi/180))	else id2
id2=if kat<11.25	then I*sqrt(sin(67.5*pi/180))	else id3
id3=if kat<15		then I			else id4
id4=if kat<18.75	then I*sqrt(sin(67.5*pi/180)) else id5
id5=if kat<22.5		then I*sqrt(sin(45*pi/180))	else id6
id6=if kat<26.25	then I*sqrt(sin(22.5*pi/180)) else 0

ic=if kat<15		then 0			else ic1
ic1=if kat<18.75	then I*sqrt(sin(22.5*pi/180))	else ic2
ic2=if kat<22.5		then I*sqrt(sin(45*pi/180))	else ic3
ic3=if kat<26.25	then I*sqrt(sin(67.5*pi/180))	else ic4
ic4=if kat<30		then I			else ic5
ic5=if kat<33.75	then I*sqrt(sin(67.5*pi/180)) else ic6
ic6=if kat<37.5		then I*sqrt(sin(45*pi/180))	else ic7
ic7=if kat<41.25	then I*sqrt(sin(22.5*pi/180)) else 0

ib=if kat<30		then 0			else ib1
ib1=if kat<33.75	then I*sqrt(sin(22.5*pi/180))	else ib2
ib2=if kat<37.5		then I*sqrt(sin(45*pi/180))	else ib3
ib3=if kat<41.25	then I*sqrt(sin(67.5*pi/180))	else ib4
ib4=if kat<45		then I			else ib5
ib5=if kat<48.75	then I*sqrt(sin(67.5*pi/180)) else ib6
ib6=if kat<52.5		then I*sqrt(sin(45*pi/180))	else ib7
ib7=if kat<56.25	then I*sqrt(sin(22.5*pi/180)) else 0

ia=if kat<3.75		then I*sqrt(sin(67.5*pi/180))	else ia1
ia1=if kat<7.5		then I*sqrt(sin(45*pi/180))	else ia2
ia2=if kat<11.25	then I*sqrt(sin(22.5*pi/180))	else ia3
ia3=if kat<45		then 0			else ia4
ia4=if kat<48.75	then I*sqrt(sin(22.5*pi/180)) else ia5
ia5=if kat<52.5		then I*sqrt(sin(45*pi/180))	else ia6
ia6=if kat<56.25	then I*sqrt(sin(67.5*pi/180)) else I




"Sterowanie unipolarne pe³noskokowe:
"warunek=sin(45*pi/180)
"Ud=if sin(wo*t+(45-0)*pi/180)>warunek then U else 0
"Uc=if sin(wo*t+(45-90)*pi/180)>warunek then U else 0
"Ub=if sin(wo*t+(45-180)*pi/180)>warunek then U else 0
"Ua=if sin(wo*t+(45-270)*pi/180)>warunek then U else 0

"Sterowanie unipolarne pó³skokowe:
"warunek=sin(22.5*pi/180)
"Ud=if sin(wo*t+(22.5-0)*pi/180)>warunek then U else 0
"Uc=if sin(wo*t+(22.5-90)*pi/180)>warunek then U else 0
"Ub=if sin(wo*t+(22.5-180)*pi/180)>warunek then U else 0
"Ua=if sin(wo*t+(22.5-270)*pi/180)>warunek then U else 0

"Sterowanie unipolarne æwieræskokowe (mikroskokowe):
"kat=mod(wo*t,pi/3)*180/pi
"ud=if kat<3.75		then 0.5*U else ud1
"ud1=if kat<22.5	then U 	else ud2
"ud2=if kat<26.25 	then 0.5*U else 0

"uc=if kat<15		then 0 else uc1
"uc1=if kat<18.75	then 0.5*U else uc2
"uc2=if kat<37.5	then U else uc3
"uc3=if kat<41.25	then 0.5*U else 0

"ub=if kat<30		then 0 else ub1
"ub1=if kat<33.75	then 0.5*U else ub2
"ub2=if kat<52.5	then U else ub3
"ub3=if kat<56.25	then 0.5*U else 0

"ua=if kat<7.5		then U else ua1
"ua1=if kat<11.25	then 0.5*U else ua2
"ua2=if kat<45		then 0 else ua3
"ua3=if kat<48.75	then 0.5*U else ua4
"ua4=if kat<67.5	then U else ua5
"ua5=if kat<71.25	then 0.5*U else 0
