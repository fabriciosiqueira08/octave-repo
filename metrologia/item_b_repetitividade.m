% Item (b) - Cálculo da Repetitividade com t de Student
% Baseado no desvio padrão e coeficiente t para 95% de confiança

clear all;
close all;
clc;

fprintf('=== ITEM (b) - REPETITIVIDADE COM t DE STUDENT ===\n\n');

% Dados das 100 medições (em gramas) - mesmo do item (a)
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

% Parâmetros estatísticos
n = length(medicoes);                % Número de medições
media = mean(medicoes);              % Média
desvio_padrao = std(medicoes);       % Desvio padrão
variancia = var(medicoes);           % Variância

fprintf('DADOS ESTATÍSTICOS:\n');
fprintf('Número de medições (n): %d\n', n);
fprintf('Média: %.2f g\n', media);
fprintf('Desvio padrão (s): %.4f g\n', desvio_padrao);
fprintf('Variância: %.4f g²\n', variancia);
fprintf('\n');

% Cálculo do coeficiente t de Student
% Para 95% de confiança (α = 0.05, bilateral)
% Graus de liberdade = n - 1
graus_liberdade = n - 1;
nivel_confianca = 95;  % %
alpha = (100 - nivel_confianca) / 100;  % α = 0.05

fprintf('PARÂMETROS PARA t DE STUDENT:\n');
fprintf('Nível de confiança: %.0f%%\n', nivel_confianca);
fprintf('α (alfa): %.3f\n', alpha);
fprintf('Graus de liberdade: %d\n', graus_liberdade);

% Tabela simplificada de valores críticos t de Student para α = 0.05 (bilateral)
% Para 99 graus de liberdade (próximo de 100), t ≈ 1.984
if graus_liberdade >= 30
    t_critico = 1.984;  % Valor para gl = 99 e α = 0.05 (bilateral)
    fprintf('t crítico (α = 0.05, gl = %d): %.3f\n', graus_liberdade, t_critico);
else
    % Para poucos dados, usar valores tabelados específicos
    fprintf('ATENÇÃO: Número baixo de medições. Consulte tabela t de Student.\n');
    t_critico = 2.0;  % Valor conservativo
end
fprintf('\n');

% CÁLCULO DA REPETITIVIDADE
fprintf('CÁLCULO DA REPETITIVIDADE:\n');
fprintf('Fórmula: R = t × s\n');
fprintf('onde:\n');
fprintf('  R = Repetitividade\n');
fprintf('  t = Coeficiente t de Student\n');
fprintf('  s = Desvio padrão\n\n');

repetitividade = t_critico * desvio_padrao;

fprintf('Substituindo os valores:\n');
fprintf('R = %.3f × %.4f\n', t_critico, desvio_padrao);
fprintf('R = %.4f g\n\n', repetitividade);

% INTERPRETAÇÃO DA REPETITIVIDADE
fprintf('INTERPRETAÇÃO:\n');
fprintf('A repetitividade R = %.4f g significa que:\n', repetitividade);
fprintf('• Em 95%% das vezes, a diferença entre duas medições\n');
fprintf('  consecutivas será menor que %.4f g\n', repetitividade);
fprintf('• Este é o limite de repetitividade do instrumento\n');
fprintf('• Representa a variabilidade aleatória esperada\n\n');

% COMPARAÇÃO COM OUTROS MÉTODOS
fprintf('COMPARAÇÃO COM OUTROS MÉTODOS:\n');

% Método simples (2 × desvio padrão)
repet_simples = 2 * desvio_padrao;
fprintf('Método simples (2s): %.4f g\n', repet_simples);

% Método com fator k=2 (aproximação normal)
repet_k2 = 2 * desvio_padrao;
fprintf('Método k=2 (normal): %.4f g\n', repet_k2);

% Diferença percentual
diferenca_perc = abs(repetitividade - repet_simples) / repet_simples * 100;
fprintf('Diferença t-Student vs 2s: %.1f%%\n', diferenca_perc);
fprintf('\n');

% RESULTADO FINAL
fprintf('RESULTADO FINAL - ITEM (b):\n');
fprintf('═══════════════════════════════════════\n');
fprintf('Repetitividade (95%% confiança): %.4f g\n', repetitividade);
fprintf('Baseada em:\n');
fprintf('  • Desvio padrão: %.4f g\n', desvio_padrao);
fprintf('  • Coeficiente t: %.3f\n', t_critico);
fprintf('  • %d medições\n', n);
fprintf('═══════════════════════════════════════\n');

% SALVAR RESULTADOS
fid = fopen('resultados_repetitividade.txt', 'w');
fprintf(fid, 'CÁLCULO DA REPETITIVIDADE - ITEM (b)\n');
fprintf(fid, '===================================\n\n');
fprintf(fid, 'Dados:\n');
fprintf(fid, 'Número de medições: %d\n', n);
fprintf(fid, 'Desvio padrão: %.4f g\n', desvio_padrao);
fprintf(fid, 'Graus de liberdade: %d\n', graus_liberdade);
fprintf(fid, 'Nível de confiança: %d%%\n', nivel_confianca);
fprintf(fid, 'Coeficiente t: %.3f\n', t_critico);
fprintf(fid, '\nResultado:\n');
fprintf(fid, 'REPETITIVIDADE = %.4f g\n', repetitividade);
fprintf(fid, '\nInterpretação:\n');
fprintf(fid, 'Em 95%% das medições consecutivas, a diferença\n');
fprintf(fid, 'será menor que %.4f g\n', repetitividade);
fclose(fid);

fprintf('\n✓ Resultados salvos em "resultados_repetitividade.txt"\n');
fprintf('\n=== ITEM (b) CONCLUÍDO ===\n'); 