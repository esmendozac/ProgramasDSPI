clc
clear all;

%% Frecuencia de muestreo
Fs = 11025;
%% Resolución del ADC
Bits = 16;
%% Canales
Channel = 1;

%% Declara el objeto audiorecorder y lo configura
recorder = audiorecorder(Fs, Bits, Channel);
disp('Inicio de grabación A');
%% Programa la grabación a un tiempo de 5s
recordblocking(recorder,5);
disp('Fin de grabación A');

%% Obtiene los datos de la grabación A en un vector
audioA = getaudiodata(recorder);

disp('Inicio de grabación B');
%% Programa la grabación a un tiempo de 5s
recordblocking(recorder,5);
disp('Fin de grabación B');

%% Obtiene los datos de la grabación A en un vector
audioB = getaudiodata(recorder);

%% Grafica de las dos señales
figure(1);
hold on 
plot(audioA,'red');
plot(audioB,'blue');
hold off;

%%Amplificacion de las señales
audioAmpA = 2 * audioA;
audioAmpB = 2 * audioB;

%% Grafica de las dos señales amplificadas
figure(2);
hold on 
plot(audioAmpA,'red');
plot(audioAmpB,'blue');
hold off;

%% Mezcla de las señales
mezclaAB = audioAmpA + audioAmpB;

%% Señal resultante
figure(3);
plot(mezclaAB,'green');

%% Recorte de la señal resultante de la mezcla a la mitad 
mezclaCortada = mezclaAB(1:27562,1);
%% Reemplazo de los primeros 10000 valores 
mezclaCortada(1:10000,1)= 1;

figure(4);
plot(mezclaCortada,'yellow');

%%Ejecuta el sonido
sound(mezclaCortada, Fs)
