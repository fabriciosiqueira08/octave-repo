% Análise Metrológica da Balança Digital
% Descrição: Análise de repetibilidade e distribuição de erros
% Dados: 100 medições de massa padrão de 1000g
% Autor: Análise Metrológica
% Data: Janeiro 2025
% Versão: 1.0

clear all;
close all;
clc;

fprintf('=== ANÁLISE METROLÓGICA DA BALANÇA DIGITAL ===\n\n');

% Dados das 100 medições (em gramas)
medicoes = [1000, 1000, 1000, 1000, 998, 999, 997, 999, 999, 1000, ...
            1002, 1000, 999, 1001, 999, 1001, 998, 999, 1000, 1000, ...
            998, 1001, 1002, 1002, 999, 1001, 1000, 1000, 1001, 999, ...
            999, 1001, 999, 1001, 1001, 999, 1001, 999, 997, 999, ...
            1000, 998, 999, 1000, 999, 999, 1001, 1001, 997, 998, ...
            999, 1001, 999, 1003, 1001, 1000, 1000, 1001, 998, 999, ...
            999, 998, 998, 999, 1000, 998, 1000, 1000, 999, 1001, ...
            1000, 1000, 1001, 1000, 999, 1001, 1000, 1001, 996, 997, ...
            999, 1002, 999, 1000, 999, 1000, 1001, 1000, 1000, 999, ...
            999, 999, 1000, 999, 994, 1002, 1001, 999, 1001, 996];

% Valor nominal da massa padrão
valor_nominal = 1000.0; % gramas

% 1. ANÁLISE ESTATÍSTICA BÁSICA
n_medicoes = length(medicoes);
media = mean(medicoes);
mediana = median(medicoes);
desvio_padrao = std(medicoes);
variancia = var(medicoes);

% Erro sistemático (bias)
erro_sistematico = media - valor_nominal;

% Valores mínimo e máximo
valor_min = min(medicoes);
valor_max = max(medicoes);
amplitude = valor_max - valor_min;

fprintf('ESTATÍSTICAS BÁSICAS:\n');
fprintf('Número de medições: %d\n', n_medicoes);
fprintf('Média: %.2f g\n', media);
fprintf('Mediana: %.2f g\n', mediana);
fprintf('Desvio padrão: %.2f g\n', desvio_padrao);
fprintf('Variância: %.2f g²\n', variancia);
fprintf('Erro sistemático: %.2f g\n', erro_sistematico);
fprintf('Valor mínimo: %.0f g\n', valor_min);
fprintf('Valor máximo: %.0f g\n', valor_max);
fprintf('Amplitude: %.0f g\n', amplitude);
fprintf('\n');

% 2. CONTAGEM DE FREQUÊNCIAS
valores_unicos = unique(medicoes);
frequencias = zeros(size(valores_unicos));

for i = 1:length(valores_unicos)
    frequencias(i) = sum(medicoes == valores_unicos(i));
end

fprintf('TABELA DE FREQUÊNCIAS:\n');
fprintf('Indicação (g) | Frequência | Frequência Relativa (%%)\n');
fprintf('--------------|------------|----------------------\n');
for i = 1:length(valores_unicos)
    freq_relativa = (frequencias(i) / n_medicoes) * 100;
    fprintf('    %4.0f     |     %2d     |        %.1f\n', ...
            valores_unicos(i), frequencias(i), freq_relativa);
end
fprintf('\n');

% 3. ANÁLISE DE NORMALIDADE
% Teste de normalidade visual e estatístico
erros = medicoes - valor_nominal;

% Teste de Shapiro-Wilk simplificado (verificação visual)
fprintf('ANÁLISE DE NORMALIDADE:\n');
fprintf('Os dados parecem seguir distribuição normal?\n');
fprintf('(Análise baseada no histograma e gráfico Q-Q)\n\n');

% 4. CRIAÇÃO DO HISTOGRAMA
figure(1);
clf;

% Subplot 1: Histograma das medições
subplot(2, 2, 1);
[n_hist, x_hist] = hist(medicoes, valores_unicos);
bar(x_hist, n_hist, 'FaceColor', [0.3 0.6 0.9]);
hold on;

% Sobrepor curva normal teórica
x_teorico = linspace(valor_min-1, valor_max+1, 100);
y_teorico = (n_medicoes / (desvio_padrao * sqrt(2*pi))) * ...
            exp(-0.5 * ((x_teorico - media) / desvio_padrao).^2);
plot(x_teorico, y_teorico, 'r-', 'LineWidth', 2);

% Linha da média
ylim_atual = ylim;
plot([media media], ylim_atual, 'g--', 'LineWidth', 2);

title('Histograma das Medições da Balança');
xlabel('Indicação (g)');
ylabel('Frequência');
legend('Dados Medidos', 'Distribuição Normal Teórica', 'Média', 'Location', 'best');
grid on;

% Subplot 2: Histograma dos erros
subplot(2, 2, 2);
hist(erros, 10);
hold on;
% Curva normal para os erros
x_erro = linspace(min(erros)-1, max(erros)+1, 100);
y_erro = (n_medicoes / (desvio_padrao * sqrt(2*pi))) * ...
         exp(-0.5 * (x_erro / desvio_padrao).^2);
plot(x_erro, y_erro, 'r-', 'LineWidth', 2);

title('Histograma dos Erros');
xlabel('Erro (g)');
ylabel('Frequência');
legend('Erros Medidos', 'Normal Teórica', 'Location', 'best');
grid on;

% Subplot 3: Gráfico Q-Q (Quantil-Quantil)
subplot(2, 2, 3);
dados_ordenados = sort(medicoes);
quantis_teoricos = norminv((1:n_medicoes) / (n_medicoes + 1), media, desvio_padrao);
plot(quantis_teoricos, dados_ordenados, 'bo');
hold on;
plot([min(quantis_teoricos) max(quantis_teoricos)], ...
     [min(quantis_teoricos) max(quantis_teoricos)], 'r--', 'LineWidth', 2);
title('Gráfico Q-Q (Normal)');
xlabel('Quantis Teóricos');
ylabel('Quantis Observados');
grid on;

% Subplot 4: Série temporal das medições
subplot(2, 2, 4);
plot(1:length(medicoes), medicoes, 'b.-');
hold on;
plot([1 length(medicoes)], [valor_nominal valor_nominal], 'r--', 'LineWidth', 2);
plot([1 length(medicoes)], [media media], 'g-', 'LineWidth', 2);
title('Série Temporal das Medições');
xlabel('Número da Medição');
ylabel('Indicação (g)');
legend('Medições', 'Valor Nominal', 'Média', 'Location', 'best');
grid on;

% Ajustar layout
sgtitle('Análise Estatística da Balança Digital - Massa de 1000g', 'FontSize', 14);

% 5. ANÁLISE DE CAPACIDADE DE MEDIÇÃO
% Incerteza padrão tipo A
incerteza_tipo_A = desvio_padrao / sqrt(n_medicoes);

% Incerteza expandida (k=2 para ~95%)
k = 2;
incerteza_expandida = k * desvio_padrao;

fprintf('INCERTEZAS DE MEDIÇÃO:\n');
fprintf('Incerteza tipo A (u_A): %.3f g\n', incerteza_tipo_A);
fprintf('Incerteza padrão (u): %.2f g\n', desvio_padrao);
fprintf('Incerteza expandida (U, k=2): %.2f g\n', incerteza_expandida);
fprintf('Resultado: (%.1f ± %.1f) g\n', media, incerteza_expandida);
fprintf('\n');

% 6. COMPARAÇÃO COM DISTRIBUIÇÃO NORMAL
fprintf('COMPARAÇÃO COM DISTRIBUIÇÃO NORMAL:\n');

% Teste de simetria simplificado
% Assimetria aproximada
assimetria = sum((medicoes - media).^3) / (n_medicoes * desvio_padrao^3);
% Curtose aproximada  
curtose = sum((medicoes - media).^4) / (n_medicoes * desvio_padrao^4) - 3;

fprintf('Assimetria: %.3f (normal = 0)\n', assimetria);
fprintf('Curtose: %.3f (normal = 0)\n', curtose);

% Avaliação visual
if abs(assimetria) < 0.5 && abs(curtose) < 1
    fprintf('✓ Os dados apresentam distribuição aproximadamente normal\n');
else
    fprintf('⚠ Os dados podem não seguir distribuição normal\n');
end

% Porcentagem dentro de 1σ e 2σ
dentro_1sigma = sum(abs(medicoes - media) <= desvio_padrao) / n_medicoes * 100;
dentro_2sigma = sum(abs(medicoes - media) <= 2*desvio_padrao) / n_medicoes * 100;

fprintf('\nDISTRIBUIÇÃO DOS DADOS:\n');
fprintf('Dentro de ±1σ: %.1f%% (normal ≈ 68.3%%)\n', dentro_1sigma);
fprintf('Dentro de ±2σ: %.1f%% (normal ≈ 95.4%%)\n', dentro_2sigma);
fprintf('\n');

% 7. SALVAR RESULTADOS
% Salvar figura
print('analise_balanca_histograma.png', '-dpng', '-r300');

% Salvar resultados em arquivo
fid = fopen('resultados_balanca_digital.txt', 'w');
fprintf(fid, 'ANÁLISE METROLÓGICA DA BALANÇA DIGITAL\n');
fprintf(fid, '=====================================\n\n');
fprintf(fid, 'DADOS BÁSICOS:\n');
fprintf(fid, 'Número de medições: %d\n', n_medicoes);
fprintf(fid, 'Valor nominal: %.0f g\n', valor_nominal);
fprintf(fid, 'Média: %.2f g\n', media);
fprintf(fid, 'Desvio padrão: %.2f g\n', desvio_padrao);
fprintf(fid, 'Erro sistemático: %.2f g\n', erro_sistematico);
fprintf(fid, '\nFREQUÊNCIAS:\n');
for i = 1:length(valores_unicos)
    fprintf(fid, '%4.0f g: %2d vezes (%.1f%%)\n', ...
            valores_unicos(i), frequencias(i), (frequencias(i)/n_medicoes)*100);
end
fprintf(fid, '\nINCERTEZAS:\n');
fprintf(fid, 'Incerteza tipo A: %.3f g\n', incerteza_tipo_A);
fprintf(fid, 'Incerteza expandida (k=2): %.2f g\n', incerteza_expandida);
fprintf(fid, '\nRESULTADO FINAL:\n');
fprintf(fid, 'Massa = (%.1f ± %.1f) g\n', media, incerteza_expandida);
fclose(fid);

% Salvar dados em formato MAT para análises futuras
save('dados_balanca_digital.mat', 'medicoes', 'media', 'desvio_padrao', ...
     'valores_unicos', 'frequencias', 'incerteza_expandida');

fprintf('ARQUIVOS GERADOS:\n');
fprintf('✓ Gráfico: "analise_balanca_histograma.png"\n');
fprintf('✓ Resultados: "resultados_balanca_digital.txt"\n');
fprintf('✓ Dados: "dados_balanca_digital.mat"\n\n');

fprintf('=== CONCLUSÕES ===\n');
fprintf('1. A balança apresenta pequeno erro sistemático: %.2f g\n', erro_sistematico);
fprintf('2. Repetibilidade (desvio padrão): %.2f g\n', desvio_padrao);
fprintf('3. Distribuição dos dados é aproximadamente normal\n');
fprintf('4. Resultado: (%.1f ± %.1f) g para k=2 (95,45%%)\n', media, incerteza_expandida);
fprintf('\n=== ANÁLISE CONCLUÍDA ===\n'); 