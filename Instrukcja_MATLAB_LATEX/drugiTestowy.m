%% Instrukcja obsługi interpretera
% Tekst wpisujemy albo w m-pliku, albo umieszczamy komendę:
% \\input\{nazwa.txt\}, zadziała ona w następujący sposób:
% \input{Testy/test_input.txt}
% Import wykresów dokonuje się za pomocą komendy obrazek. Jak niżej:
% \obrazek{12}{im1}
% Wszelkie obliczenia nie są umieszczane w sprawozdaniu. Można jednak
% używać komend latexa WSZYSTKICH.
% Kod generuje wykresy, żeby umieścić je w sprawozdaniu trzeba przesłać
% numery figur oraz nazwy plików, które muszą się zgadzać z nazwami
% podanymi w komendach obrazek.
% \obrazek{12}{im2}
close all
figure(1)
t=linspace(0,2*pi,100);
t2=linspace(0,5,10);
y = sin(t);
y2 = sin(t2) + rand(1,10)*.1;
plot(t,y,t2,y2,'.')
legend('$\sin(t)$','points');
xlabel('oś x-ów');
ylabel('oś y-ów');
title('Wykres z opisem');
grid on;

figure(2)
t=linspace(0,2*pi,100);
t2=linspace(0,5,10);
y = sin(t);
y2 = sin(t2) + rand(1,10)*.1;
plot(t,y,t2,y2,'.')
title('Wykres prosty')

compile_with_plots(mfilename,[1,2],{'im1','im2'},1);
close all