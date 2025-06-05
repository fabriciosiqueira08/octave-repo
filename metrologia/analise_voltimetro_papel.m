% ROTINA: ANÁLISE METROLÓGICA DO VOLTÍMETRO ELETRÔNICO
% Autor: [Seu Nome]
% Data: [Data]

clear; clc;

% DADOS DAS MEDIÇÕES
% Pilha de 10V (valor verdadeiro = 10.0V)
medicoes_10V = [10.08, 10.09, 10.00, 10.14, 10.01, 10.05, 10.05, 10.04, 10.06, 10.08];

% Pilha de 20V (valor verdadeiro = 20.0V)  
medicoes_20V = [20.11, 20.10, 20.14, 20.13, 20.09, 20.09, 20.13, 20.12, 20.18, 20.05];

% CÁLCULOS ESTATÍSTICOS
% Para 10V
media_10V = mean(medicoes_10V);           % 10.0600 V
desvio_10V = std(medicoes_10V);           % 0.0406 V  
erro_medio_10V = media_10V - 10.0;        % 0.0600 V

% Para 20V
media_20V = mean(medicoes_20V);           % 20.1140 V
desvio_20V = std(medicoes_20V);           % 0.0350 V
erro_medio_20V = media_20V - 20.0;        % 0.1140 V

% INCERTEZAS EXPANDIDAS (95,45% - k=2)
incerteza_10V = 2 * desvio_10V;           % ±0.0811 V
incerteza_20V = 2 * desvio_20V;           % ±0.0700 V

% a) CURVA DE ERROS (Erro x Indicação)
% Pontos: (10.06, 0.060) e (20.11, 0.114)
indicacoes = [media_10V, media_20V];
erros = [erro_medio_10V, erro_medio_20V];

% Ajuste linear: y = ax + b
coef = polyfit(indicacoes, erros, 1);
a = coef(1);                              % 0.005371
b = coef(2);                              % 0.005968

% EQUAÇÃO DA CURVA DE ERROS:
% Erro = 0.005371 × Indicação + 0.005968

% b) ERRO MÁXIMO PARA 12V
erro_12V = a * 12.0 + b;                  % 0.0704 V
incerteza_12V = interp1(indicacoes, [incerteza_10V, incerteza_20V], 12.0);  % 0.0790 V
erro_maximo_12V = abs(erro_12V) + incerteza_12V;  % 0.1494 V

% GRÁFICO SIMPLES
figure;
plot(indicacoes, erros, 'ko', 'MarkerSize', 8);  % Dados medidos
hold on;
x = 10:0.1:20;
y = a*x + b;
plot(x, y, 'r-');                         % Curva de erros
plot(12, erro_12V, 'g*', 'MarkerSize', 12); % Erro em 12V
xlabel('Indicação (V)');
ylabel('Erro (V)');
title('Curva de Erros do Voltímetro Eletrônico');
grid on;
legend('Dados Medidos', 'Ajuste Linear', 'Erro em 12V');

% RESULTADOS FINAIS
fprintf('\n=== RESULTADOS ===\n');
fprintf('a) Curva de Erros: Erro = %.6f × Indicação + %.6f\n', a, b);
fprintf('b) Erro Máximo para 12V: %.4f V\n', erro_maximo_12V); 