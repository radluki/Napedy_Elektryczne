 
 % converting csv to mat ea3
 %{
files = {'AC182.csv','r_tyrystorowy.csv','wyprostowane152.csv','nV.csv'};
convert_csv_mat(files)


%}
 %% analysing AC powered motor
files = {'AC182.mat','r_tyrystorowy.mat','wyprostowane152.mat','nV.mat'};
close all
figure(1)
hold on
labels ={'przemienny 182V','','r. tyrystorowy','','wyprostowane 152V',''}
for i = 1:3
    load(files{i})

     % straty mechaniczne oraz w żelazie prądnicy, 
    P0 = 1.2*n.^2*1e-6 + 1.1*n*1e-3;
     % moc oddawana przez prądnicą
    Pod = Up.*Ip;
    Pcu = 26*Ip.^2;

    Podsil = P0 + Pcu + Pod;
    T = Podsil./(2*pi/60*n);
    ni = Podsil./P;
    xx = linspace(n(1),n(end),100);
    a = polyfit(n,ni,2);
    figure(1)
    plot(n,ni,'.',xx,polyval(a,xx))
end
legend(labels)
hold off
% \obrazek{12}{ob1}
%compile_with_plots(mfilename,[1],{'ob1'})