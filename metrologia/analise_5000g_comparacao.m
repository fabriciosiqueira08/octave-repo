% Análise de Tendência e Correção - Massa de 5000g
% Comparação com resultados de 1000g

clear all;
close all;
clc;

fprintf('=== ANÁLISE DE TENDÊNCIA: 5000g vs 1000g ===\n\n');

% Dados das 100 medições de 5000g (em gramas)
medicoes_5000g = [5005, 5005, 5004, 5003, 5004, 5003, 5002, 5005, 5003, 5006, ...
                  5002, 5003, 5003, 5003, 5002, 5004, 5004, 5002, 5005, 5005, ...
                  5003, 5001, 5005, 5000, 5005, 5002, 5001, 5003, 5002, 5003, ...
                  4999, 5003, 5005, 5003, 5000, 5002, 5005, 5005, 5002, 5006, ...
                  5004, 5004, 5004, 5005, 5001, 5002, 5003, 5002, 5001, 5002, ...
                  5001, 5001, 5003, 5003, 5004, 5005, 5001, 5004, 5005, 5003, ...
                  5004, 5005, 5003, 5005, 4999, 5002, 5003, 5001, 5006, 5002, ...
                  5003, 5004, 5004, 5004, 5001, 5003, 5002, 5002, 5002, 5002, ...
                  4997, 5006, 5004, 5004, 5004, 5002, 5003, 5001, 5000, 5001, ...
                  5006, 5006, 5001, 5002, 5003, 5004, 5003, 5005, 5005, 5003];

% Dados das 100 medições de 1000g (do exercício anterior)
medicoes_1000g = [1000, 1000, 1000, 1000, 998, 999, 997, 999, 999, 1000, ...
                  1002, 1000, 999, 1001, 999, 1001, 998, 999, 1000, 1000, ...
                  998, 1001, 1002, 1002, 999, 1001, 1000, 1000, 1001, 999, ...
                  999, 1001, 999, 1001, 1001, 999, 1001, 999, 997, 999, ...
                  1000, 998, 999, 1000, 999, 999, 1001, 1001, 997, 998, ...
                  999, 1001, 999, 1003, 1001, 1000, 1000, 1001, 998, 999, ...
                  999, 998, 998, 999, 1000, 998, 1000, 1000, 999, 1001, ...
                  1000, 1000, 1001, 1000, 999, 1001, 1000, 1001, 996, 997, ...
                  999, 1002, 999, 1000, 999, 1000, 1001, 1000, 1000, 999, ...
                  999, 999, 1000, 999, 994, 1002, 1001, 999, 1001, 996];

% Valores verdadeiros
valor_verdadeiro_5000g = 5000.0;
valor_verdadeiro_1000g = 1000.0;

% =============================================================================
% ANÁLISE PARA 5000g
% =============================================================================

fprintf('ANÁLISE PARA MASSA DE 5000g:\n');
fprintf('=============================\n');

% Estatísticas básicas para 5000g
n_5000g = length(medicoes_5000g);
media_5000g = mean(medicoes_5000g);
desvio_5000g = std(medicoes_5000g);
erro_padrao_5000g = desvio_5000g / sqrt(n_5000g);

fprintf('Número de medições: %d\n', n_5000g);
fprintf('Valor verdadeiro: %.1f g\n', valor_verdadeiro_5000g);
fprintf('Média das indicações: %.1f g\n', media_5000g);
fprintf('Desvio padrão: %.2f g\n', desvio_5000g);
fprintf('Erro padrão da média: %.3f g\n', erro_padrao_5000g);

% Cálculo da tendência e correção para 5000g
tendencia_5000g = media_5000g - valor_verdadeiro_5000g;
correcao_5000g = -tendencia_5000g;

fprintf('\nTENDÊNCIA para 5000g:\n');
fprintf('Tendência = %.1f - %.1f = %.1f g\n', media_5000g, valor_verdadeiro_5000g, tendencia_5000g);
fprintf('CORREÇÃO para 5000g:\n');
fprintf('Correção = %.1f g\n', correcao_5000g);

% Teste de significância para 5000g
razao_significancia_5000g = abs(tendencia_5000g) / erro_padrao_5000g;
fprintf('\nSIGNIFICÂNCIA para 5000g:\n');
fprintf('Razão |Tendência|/Erro padrão: %.2f\n', razao_significancia_5000g);
if razao_significancia_5000g >= 2
    fprintf('✓ TENDÊNCIA SIGNIFICATIVA (%.2f ≥ 2)\n', razao_significancia_5000g);
    status_5000g = 'SIGNIFICATIVA';
else
    fprintf('⚠ TENDÊNCIA NÃO SIGNIFICATIVA (%.2f < 2)\n', razao_significancia_5000g);
    status_5000g = 'NÃO SIGNIFICATIVA';
end

% =============================================================================
% ANÁLISE PARA 1000g (RECAPITULAÇÃO)
% =============================================================================

fprintf('\n\nANÁLISE PARA MASSA DE 1000g (COMPARAÇÃO):\n');
fprintf('=========================================\n');

% Estatísticas básicas para 1000g
n_1000g = length(medicoes_1000g);
media_1000g = mean(medicoes_1000g);
desvio_1000g = std(medicoes_1000g);
erro_padrao_1000g = desvio_1000g / sqrt(n_1000g);

fprintf('Número de medições: %d\n', n_1000g);
fprintf('Valor verdadeiro: %.1f g\n', valor_verdadeiro_1000g);
fprintf('Média das indicações: %.2f g\n', media_1000g);
fprintf('Desvio padrão: %.2f g\n', desvio_1000g);
fprintf('Erro padrão da média: %.3f g\n', erro_padrao_1000g);

% Cálculo da tendência e correção para 1000g
tendencia_1000g = media_1000g - valor_verdadeiro_1000g;
correcao_1000g = -tendencia_1000g;

fprintf('\nTENDÊNCIA para 1000g:\n');
fprintf('Tendência = %.2f - %.1f = %.2f g\n', media_1000g, valor_verdadeiro_1000g, tendencia_1000g);
fprintf('CORREÇÃO para 1000g:\n');
fprintf('Correção = %.2f g\n', correcao_1000g);

% Teste de significância para 1000g
razao_significancia_1000g = abs(tendencia_1000g) / erro_padrao_1000g;
fprintf('\nSIGNIFICÂNCIA para 1000g:\n');
fprintf('Razão |Tendência|/Erro padrão: %.2f\n', razao_significancia_1000g);
if razao_significancia_1000g >= 2
    fprintf('✓ TENDÊNCIA SIGNIFICATIVA (%.2f ≥ 2)\n', razao_significancia_1000g);
    status_1000g = 'SIGNIFICATIVA';
else
    fprintf('⚠ TENDÊNCIA NÃO SIGNIFICATIVA (%.2f < 2)\n', razao_significancia_1000g);
    status_1000g = 'NÃO SIGNIFICATIVA';
end

% =============================================================================
% COMPARAÇÃO ENTRE 5000g E 1000g
% =============================================================================

fprintf('\n\nCOMPARAÇÃO ENTRE 5000g E 1000g:\n');
fprintf('===============================\n');

fprintf('RESUMO COMPARATIVO:\n');
fprintf('┌─────────────────┬─────────────┬─────────────┐\n');
fprintf('│ Parâmetro       │    1000g    │    5000g    │\n');
fprintf('├─────────────────┼─────────────┼─────────────┤\n');
fprintf('│ Média (g)       │   %7.2f   │   %7.1f   │\n', media_1000g, media_5000g);
fprintf('│ Desvio (g)      │   %7.2f   │   %7.2f   │\n', desvio_1000g, desvio_5000g);
fprintf('│ Tendência (g)   │   %7.2f   │   %7.1f   │\n', tendencia_1000g, tendencia_5000g);
fprintf('│ Correção (g)    │   %7.2f   │   %7.1f   │\n', correcao_1000g, correcao_5000g);
fprintf('│ Razão t/σ       │   %7.2f   │   %7.2f   │\n', razao_significancia_1000g, razao_significancia_5000g);
fprintf('│ Status          │ %11s │ %11s │\n', status_1000g, status_5000g);
fprintf('└─────────────────┴─────────────┴─────────────┘\n\n');

% ANÁLISE DAS DIFERENÇAS
fprintf('ANÁLISE DAS DIFERENÇAS:\n');
fprintf('1. SINAL DA TENDÊNCIA:\n');
if tendencia_1000g < 0 && tendencia_5000g > 0
    fprintf('   • 1000g: NEGATIVA (%.2f g) - balança subestima\n', tendencia_1000g);
    fprintf('   • 5000g: POSITIVA (%.1f g) - balança superestima\n', tendencia_5000g);
elseif tendencia_1000g > 0 && tendencia_5000g < 0
    fprintf('   • 1000g: POSITIVA (%.2f g) - balança superestima\n', tendencia_1000g);
    fprintf('   • 5000g: NEGATIVA (%.1f g) - balança subestima\n', tendencia_5000g);
else
    fprintf('   • Ambas têm o mesmo sinal\n');
end

fprintf('\n2. MAGNITUDE DA TENDÊNCIA:\n');
diferenca_absoluta = abs(tendencia_5000g) - abs(tendencia_1000g);
fprintf('   • |Tendência 5000g| - |Tendência 1000g| = %.2f g\n', diferenca_absoluta);
if diferenca_absoluta > 0
    fprintf('   • A tendência é MAIOR em magnitude para 5000g\n');
else
    fprintf('   • A tendência é MENOR em magnitude para 5000g\n');
end

fprintf('\n3. PRECISÃO (DESVIO PADRÃO):\n');
diferenca_desvio = desvio_5000g - desvio_1000g;
fprintf('   • Desvio 5000g - Desvio 1000g = %.2f g\n', diferenca_desvio);
if diferenca_desvio > 0
    fprintf('   • A precisão é PIOR para 5000g (maior dispersão)\n');
else
    fprintf('   • A precisão é MELHOR para 5000g (menor dispersão)\n');
end

% POR QUE SÃO DIFERENTES?
fprintf('\n\nPOR QUE AS TENDÊNCIAS SÃO DIFERENTES?\n');
fprintf('====================================\n');

% Calculars valores específicos para análise
erro_relativo_1000g = (tendencia_1000g / valor_verdadeiro_1000g) * 100;
erro_relativo_5000g = (tendencia_5000g / valor_verdadeiro_5000g) * 100;
razao_massas = valor_verdadeiro_5000g / valor_verdadeiro_1000g;
razao_tendencias = tendencia_5000g / tendencia_1000g;

fprintf('RESUMO DOS RESULTADOS:\n');
fprintf('• 1000g: Tendência = %.2f g → Correção = +%.2f g\n', tendencia_1000g, correcao_1000g);
fprintf('• 5000g: Tendência = %.1f g → Correção = %.1f g\n', tendencia_5000g, correcao_5000g);
fprintf('\nPOR QUE OS VALORES SÃO DIFERENTES?\n');
fprintf('Os valores são diferentes por diversos motivos, um deles é que a balança\n');
fprintf('não é perfeitamente linear em suas medições, outro é a interpolação entre\n');
fprintf('pontos que também induz esses erros. Isso é totalmente normal em\n');
fprintf('dispositivos reais.\n\n');

% GRÁFICO 1: COMPARAÇÃO DAS TENDÊNCIAS E CORREÇÕES
figure(1);
clf;
set(gcf, 'Position', [100 100 900 600]);

massas = [1000, 5000];
tendencias = [tendencia_1000g, tendencia_5000g];
correcoes = [correcao_1000g, correcao_5000g];

% Posições das barras
x_pos = 1:length(massas);
width = 0.35;

% Barras para tendências
bar(x_pos - width/2, tendencias, width, 'FaceColor', [0.3 0.6 0.9], 'DisplayName', 'Tendência');
hold on;

% Barras para correções
bar(x_pos + width/2, correcoes, width, 'FaceColor', [0.9 0.3 0.3], 'DisplayName', 'Correção');

% Linha zero de referência
plot([0.5 length(massas)+0.5], [0 0], 'k--', 'LineWidth', 2);

title('Comparação das Tendências e Correções', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Massa Nominal (g)', 'FontSize', 12);
ylabel('Valor (g)', 'FontSize', 12);
set(gca, 'XTick', x_pos, 'XTickLabel', {'1000g', '5000g'});
legend('Tendência', 'Correção', 'Zero', 'Location', 'best', 'FontSize', 11);
grid on;

% Adicionar valores nas barras
for i = 1:length(massas)
    % Texto para tendência
    text(x_pos(i) - width/2, tendencias(i)/2, sprintf('%.2f g', tendencias(i)), ...
         'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10, 'Color', 'white');
    
    % Texto para correção
    text(x_pos(i) + width/2, correcoes(i)/2, sprintf('%.2f g', correcoes(i)), ...
         'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 10, 'Color', 'white');
end

% Salvar primeiro gráfico
print('grafico1_comparacao_tendencias_correcoes.png', '-dpng', '-r300');

% GRÁFICO 2: CURVA DE TENDÊNCIA DA BALANÇA
figure(2);
clf;
set(gcf, 'Position', [200 200 800 600]);

plot(massas, tendencias, 'ro-', 'LineWidth', 3, 'MarkerSize', 10);
hold on;
plot([500 5500], [0 0], 'k--', 'LineWidth', 2);

% Ajuste linear
coef = polyfit(massas, tendencias, 1);
x_linha = linspace(500, 5500, 100);
y_linha = polyval(coef, x_linha);
plot(x_linha, y_linha, 'b--', 'LineWidth', 2);

title('Curva de Tendência da Balança', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Massa Nominal (g)', 'FontSize', 12);
ylabel('Tendência (g)', 'FontSize', 12);
legend('Dados', 'Zero', 'Ajuste Linear', 'Location', 'best', 'FontSize', 11);
grid on;

% Adicionar equação do ajuste
eq_text = sprintf('Tendência = %.6f × Massa + %.3f', coef(1), coef(2));
text(0.05, 0.95, eq_text, 'Units', 'normalized', 'BackgroundColor', 'white', ...
     'EdgeColor', 'black', 'FontSize', 11, 'FontWeight', 'bold');

% Salvar segundo gráfico
print('grafico2_curva_tendencia.png', '-dpng', '-r300');

% SALVAR RESULTADOS
fid = fopen('resultados_comparacao_massas.txt', 'w');
fprintf(fid, 'COMPARAÇÃO DE TENDÊNCIAS: 5000g vs 1000g\n');
fprintf(fid, '========================================\n\n');
fprintf(fid, 'MASSA DE 1000g:\n');
fprintf(fid, 'Média: %.2f g\n', media_1000g);
fprintf(fid, 'Desvio padrão: %.2f g\n', desvio_1000g);
fprintf(fid, 'Tendência: %.2f g\n', tendencia_1000g);
fprintf(fid, 'Correção: %.2f g\n', correcao_1000g);
fprintf(fid, 'Status: %s\n\n', status_1000g);
fprintf(fid, 'MASSA DE 5000g:\n');
fprintf(fid, 'Média: %.1f g\n', media_5000g);
fprintf(fid, 'Desvio padrão: %.2f g\n', desvio_5000g);
fprintf(fid, 'Tendência: %.1f g\n', tendencia_5000g);
fprintf(fid, 'Correção: %.1f g\n', correcao_5000g);
fprintf(fid, 'Status: %s\n\n', status_5000g);
fprintf(fid, 'DIFERENÇAS:\n');
fprintf(fid, 'Mudança de sinal: %s\n', char(cellstr(['SIM'; 'NÃO'])(1 + (sign(tendencia_1000g) == sign(tendencia_5000g)))));
fprintf(fid, 'Diferença absoluta: %.2f g\n', diferenca_absoluta);
fprintf(fid, 'Equação da curva: Tendência = %.6f × Massa + %.3f\n', coef(1), coef(2));
fclose(fid);

fprintf('\n✓ Gráfico 1 salvo: "grafico1_comparacao_tendencias_correcoes.png"\n');
fprintf('✓ Gráfico 2 salvo: "grafico2_curva_tendencia.png"\n');
fprintf('✓ Resultados salvos: "resultados_comparacao_massas.txt"\n');
fprintf('\n=== ANÁLISE CONCLUÍDA ===\n'); 