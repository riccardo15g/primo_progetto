% Questo programma genera un segnale armonico (cui è possibile aggiungere anche del rumore)
% e produce lo spettro risultante

% GENERA IL SEGNALE ARMONICO

clc
clear all
close all

K=[1 3 5]; %input('vettore ordini armonici ==> ');
A=[2 2 1]; %input('vettore ampiezze armoniche ==> ');
P=[0 0 0]; %input('vettore fasi armoniche in radianti ==> ');
N=512;  %input('N. di punti campionati ==> ');
f=60;  %input('frequenza della componente fondamentale ==> ');
M=15.;  %input('N. di periodi considerati ==> ');
disp('frequenza di campionamento ==> ')
fc=N*f/M
df=fc/N
delta=f/df-floor(f/df)
n0=0;  %input('N. ordine punto iniziale ==> ');
LK=length(K);
n=(n0:n0+N-1);
T=1/fc;
t=T*n;ka=2*pi*f/fc;
x0=0;            %tensione continua
for j=1:LK
	c=A(j)*sin(ka*K(j)*n+P(j));
	x0=x0+c;
end
figure(1), plot(x0,'k')
title ('segnale ingresso')


% CALCOLA VALORE MEDIO E VALORE EFFICACE

Vmean= mean(x0)
Veff= rms(x0)

% INTRODUCI RUMORE

n=2+1.3*randn(1,N);
x0=x0+n;

figure(2),  plot(x0,'k')
title ('segnale rumoroso')



% CALCOLA VALORE MEDIO E VALORE EFFICACE DEL SEGNALE RUMOROSO

Vmean= mean(x0)
Veff= rms(x0)

% CALCOLA LO SPETTRO DEL SEGNALE

A=fft(x0);
B=abs(A);
len=N/2;
B=[B(1) 2*B(2:len)];  % ripiegamento in frequenza
[a b]=max(B);
assex=(1:len)*df;
figure(3), plot(assex, B(:,1:len)./N)
title ('spettro del segnale')


