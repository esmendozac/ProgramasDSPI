clc
clear all;

%% Frecuencia de muestreo
Fs = 11025;
%% Resoluci�n del ADC
Bits = 16;
%% Canales
Channel = 1;

%% Declara el objeto audiorecorder y lo configura
recorder = audiorecorder(Fs, Bits, Channel);
disp('Inicio de grabaci�n A');
%% Programa la grabaci�n a un tiempo de 5s
recordblocking(recorder,5);
disp('Fin de grabaci�n A');

%% Obtiene los datos de la grabaci�n A en un vector
audioA = getaudiodata(recorder);

disp('Inicio de grabaci�n B');
%% Programa la grabaci�n a un tiempo de 5s
recordblocking(recorder,5);
disp('Fin de grabaci�n B');

%% Obtiene los datos de la grabaci�n A en un vector
audioB = getaudiodata(recorder);

%% Grafica de las dos se�ales
figure(1);
hold on 
plot(audioA,'red');
plot(audioB,'blue');
hold off;

%%Amplificacion de las se�ales
audioAmpA = 2 * audioA;
audioAmpB = 2 * audioB;

%% Grafica de las dos se�ales amplificadas
figure(2);
hold on 
plot(audioAmpA,'red');
plot(audioAmpB,'blue');
hold off;

%% Mezcla de las se�ales
mezclaAB = audioAmpA + audioAmpB;

%% Se�al resultante
figure(3);
plot(mezclaAB,'green');

%% Recorte de la se�al resultante de la mezcla a la mitad 
mezclaCortada = mezclaAB(1:27562,1);
%% Reemplazo de los primeros 10000 valores 
mezclaCortada(1:10000,1)= 1;

figure(4);
plot(mezclaCortada,'yellow');

%%Ejecuta el sonido
sound(mezclaCortada, Fs)
