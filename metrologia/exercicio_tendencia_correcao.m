% Exercício - Tendência e Correção da Balança Digital
% Baseado nas 100 medições de massa de 1000g

clear all;
close all;
clc;

fprintf('=== TENDÊNCIA E CORREÇÃO DA BALANÇA DIGITAL ===\n\n');

% Dados das 100 medições (em gramas) - mesmo conjunto anterior
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

% Valor verdadeiro (nominal) da massa padrão
valor_verdadeiro = 1000.0;  % gramas

% Cálculos estatísticos básicos
n_medicoes = length(medicoes);
valor_medio = mean(medicoes);
desvio_padrao = std(medicoes);

fprintf('DADOS BÁSICOS:\n');
fprintf('Número de medições: %d\n', n_medicoes);
fprintf('Valor verdadeiro (nominal): %.1f g\n', valor_verdadeiro);
fprintf('Valor médio das indicações: %.4f g\n', valor_medio);
fprintf('Desvio padrão: %.4f g\n', desvio_padrao);
fprintf('\n');

% CÁLCULO DA TENDÊNCIA (BIAS)
fprintf('CÁLCULO DA TENDÊNCIA:\n');
fprintf('Fórmula: Tendência = Valor médio - Valor verdadeiro\n');
fprintf('         Tendência = %.4f - %.1f\n', valor_medio, valor_verdadeiro);

tendencia = valor_medio - valor_verdadeiro;

fprintf('TENDÊNCIA = %.4f g\n', tendencia);
fprintf('\n');

% INTERPRETAÇÃO DA TENDÊNCIA
fprintf('INTERPRETAÇÃO DA TENDÊNCIA:\n');
if tendencia > 0
    fprintf('• Tendência POSITIVA: +%.4f g\n', tendencia);
    fprintf('• A balança indica valores MAIORES que o real\n');
    fprintf('• Há um erro sistemático de superestimação\n');
elseif tendencia < 0
    fprintf('• Tendência NEGATIVA: %.4f g\n', tendencia);
    fprintf('• A balança indica valores MENORES que o real\n');
    fprintf('• Há um erro sistemático de subestimação\n');
else
    fprintf('• Tendência NULA: 0.0000 g\n');
    fprintf('• A balança não apresenta erro sistemático\n');
    fprintf('• Instrumento bem calibrado\n');
end
fprintf('\n');

% CÁLCULO DA CORREÇÃO
fprintf('CÁLCULO DA CORREÇÃO:\n');
fprintf('Fórmula: Correção = -Tendência\n');
fprintf('         Correção = Valor verdadeiro - Valor médio\n');
fprintf('         Correção = %.1f - %.4f\n', valor_verdadeiro, valor_medio);

correcao = -tendencia;
% ou equivalentemente: correcao = valor_verdadeiro - valor_medio;

fprintf('CORREÇÃO = %.4f g\n', correcao);
fprintf('\n');

% INTERPRETAÇÃO DA CORREÇÃO
fprintf('INTERPRETAÇÃO DA CORREÇÃO:\n');
if correcao > 0
    fprintf('• Correção POSITIVA: +%.4f g\n', correcao);
    fprintf('• Deve-se SOMAR %.4f g às indicações\n', correcao);
    fprintf('• Valor corrigido = Indicação + %.4f\n', correcao);
elseif correcao < 0
    fprintf('• Correção NEGATIVA: %.4f g\n', correcao);
    fprintf('• Deve-se SUBTRAIR %.4f g das indicações\n', abs(correcao));
    fprintf('• Valor corrigido = Indicação - %.4f\n', abs(correcao));
else
    fprintf('• Correção NULA: 0.0000 g\n');
    fprintf('• Não é necessária correção\n');
    fprintf('• Valor corrigido = Indicação\n');
end
fprintf('\n');

% EXEMPLO PRÁTICO DE APLICAÇÃO DA CORREÇÃO
fprintf('EXEMPLO PRÁTICO DE APLICAÇÃO:\n');
fprintf('Se a balança indicar 1000.0 g:\n');
valor_corrigido = 1000.0 + correcao;
fprintf('Valor corrigido = 1000.0 + (%.4f) = %.4f g\n', correcao, valor_corrigido);
fprintf('Este seria o valor mais próximo do real\n\n');

% ANÁLISE DE SIGNIFICÂNCIA DA TENDÊNCIA
fprintf('ANÁLISE DE SIGNIFICÂNCIA:\n');

% Incerteza da média (erro padrão)
erro_padrao_media = desvio_padrao / sqrt(n_medicoes);
fprintf('Erro padrão da média: %.4f g\n', erro_padrao_media);

% Teste de significância (comparar tendência com incerteza)
razao_significancia = abs(tendencia) / erro_padrao_media;
fprintf('Razão |Tendência|/Erro padrão: %.2f\n', razao_significancia);

if razao_significancia >= 2
    fprintf('✓ TENDÊNCIA SIGNIFICATIVA (razão ≥ 2)\n');
    fprintf('  A tendência é estatisticamente relevante\n');
    fprintf('  Recomenda-se aplicar a correção\n');
else
    fprintf('⚠ TENDÊNCIA NÃO SIGNIFICATIVA (razão < 2)\n');
    fprintf('  A tendência pode ser devida ao acaso\n');
    fprintf('  Correção pode não ser necessária\n');
end
fprintf('\n');

% GRÁFICO DE VISUALIZAÇÃO
figure(1);
clf;
set(gcf, 'Position', [100 100 1000 700]);  % Figura maior para acomodar legendas

% Subplot 1: Distribuição das medições com tendência
subplot(2, 1, 1);
hist(medicoes, 15);
hold on;

% Linhas de referência
ylim_atual = ylim;
plot([valor_verdadeiro valor_verdadeiro], ylim_atual, 'r-', 'LineWidth', 3);
plot([valor_medio valor_medio], ylim_atual, 'g--', 'LineWidth', 2);

title('Distribuição das Medições - Análise da Tendência');
xlabel('Indicação (g)');
ylabel('Frequência');
legend('Medições', 'Valor Verdadeiro', 'Valor Médio', 'Location', 'eastoutside');
grid on;

% Adicionar texto com valores
text_x = min(medicoes) + 0.15 * (max(medicoes) - min(medicoes));
text_y = max(ylim_atual) * 0.85;
text_str = sprintf('Tendência = %.4f g\nCorreção = %.4f g', tendencia, correcao);
text(text_x, text_y, text_str, 'BackgroundColor', 'white', 'EdgeColor', 'black');

% Subplot 2: Série temporal mostrando tendência
subplot(2, 1, 2);
plot(1:n_medicoes, medicoes, 'b.', 'MarkerSize', 6);
hold on;
plot([1 n_medicoes], [valor_verdadeiro valor_verdadeiro], 'r-', 'LineWidth', 2);
plot([1 n_medicoes], [valor_medio valor_medio], 'g--', 'LineWidth', 2);

title('Série Temporal das Medições');
xlabel('Número da Medição');
ylabel('Indicação (g)');
legend('Medições', 'Valor Verdadeiro', 'Valor Médio', 'Location', 'eastoutside');
grid on;

% Salvar gráfico
print('tendencia_correcao_balanca.png', '-dpng', '-r300');

% RESUMO FINAL
fprintf('RESUMO FINAL:\n');
fprintf('═══════════════════════════════════════════════\n');
fprintf('TENDÊNCIA DA BALANÇA DIGITAL:\n');
fprintf('• Valor verdadeiro: %.1f g\n', valor_verdadeiro);
fprintf('• Valor médio medido: %.4f g\n', valor_medio);
fprintf('• TENDÊNCIA: %.4f g (%s)\n', tendencia, ...
        char(cellstr(["subestimação"; "calibrada"; "superestimação"])(sign(tendencia)+2)));
fprintf('\nCORREÇÃO NECESSÁRIA:\n');
fprintf('• CORREÇÃO: %.4f g\n', correcao);
if correcao >= 0
    fprintf('• Aplicação: Valor real = Indicação + %.4f g\n', correcao);
else
    fprintf('• Aplicação: Valor real = Indicação - %.4f g\n', abs(correcao));
end
fprintf('\nSIGNIFICÂNCIA ESTATÍSTICA:\n');
fprintf('• Razão tendência/erro padrão: %.2f\n', razao_significancia);
if razao_significancia >= 2
    fprintf('• Status: SIGNIFICATIVA - aplicar correção\n');
else
    fprintf('• Status: NÃO SIGNIFICATIVA - correção opcional\n');
end
fprintf('═══════════════════════════════════════════════\n');

% SALVAR RESULTADOS
fid = fopen('resultados_tendencia_correcao.txt', 'w');
fprintf(fid, 'TENDÊNCIA E CORREÇÃO DA BALANÇA DIGITAL\n');
fprintf(fid, '======================================\n\n');
fprintf(fid, 'Dados básicos:\n');
fprintf(fid, 'Número de medições: %d\n', n_medicoes);
fprintf(fid, 'Valor verdadeiro: %.1f g\n', valor_verdadeiro);
fprintf(fid, 'Valor médio: %.4f g\n', valor_medio);
fprintf(fid, 'Desvio padrão: %.4f g\n', desvio_padrao);
fprintf(fid, '\nResultados:\n');
fprintf(fid, 'TENDÊNCIA = %.4f g\n', tendencia);
fprintf(fid, 'CORREÇÃO = %.4f g\n', correcao);
fprintf(fid, '\nSignificância:\n');
fprintf(fid, 'Erro padrão da média: %.4f g\n', erro_padrao_media);
fprintf(fid, 'Razão |Tendência|/σ_média: %.2f\n', razao_significancia);
if razao_significancia >= 2
    fprintf(fid, 'Status: SIGNIFICATIVA\n');
else
    fprintf(fid, 'Status: NÃO SIGNIFICATIVA\n');
end
fprintf(fid, '\nAplicação prática:\n');
if correcao >= 0
    fprintf(fid, 'Valor corrigido = Indicação + %.4f g\n', correcao);
else
    fprintf(fid, 'Valor corrigido = Indicação - %.4f g\n', abs(correcao));
end
fclose(fid);

fprintf('\n✓ Gráfico salvo: "tendencia_correcao_balanca.png"\n');
fprintf('✓ Resultados salvos: "resultados_tendencia_correcao.txt"\n');
fprintf('\n=== EXERCÍCIO CONCLUÍDO ===\n'); 