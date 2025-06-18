% Análise Metrológica do Paquímetro Analógico de Metal
% Questão: Curva de Erros e Erro Máximo

clear all;
close all;
clc;

fprintf('=== ANÁLISE METROLÓGICA DO PAQUÍMETRO ANALÓGICO DE METAL ===\n\n');

% Dados das medições - valores em mm
% [Bloco-padrão, td, s ou u, Coef. t Student, P¹, td+P, td-P]
tabela_paq = [
    24.0, 24.0, 0.0, 3.307, 0.0, 24.0, 24.0;
    100.0, 100.0, 0.0, 3.307, 0.0, 100.0, 100.0;
    1.49, 1.5, 0.0, 3.307, 0.0, 1.5, 1.5;
    12.5, 12.5, 0.0, 3.307, 0.0, 12.5, 12.5;
    1.001, 1.00, 0.0, 3.307, 0.0, 1.00, 1.00
];

% Extração dos valores para análise
valor_real = tabela_paq(:, 1)';  % Blocos-padrão (valor real)
tendencia = tabela_paq(:, 2)';   % Tendências (td)
incerteza = tabela_paq(:, 5)';   % Incertezas expandidas (P¹)

% Para o cálculo do erro, usamos a tendência em relação ao valor real
erro = tendencia - valor_real;

% Estatísticas
erro_medio = mean(erro);
desvio = std(erro);
incerteza_media = mean(incerteza);

% Exibir estatísticas
fprintf('ESTATÍSTICAS DO PAQUÍMETRO ANALÓGICO DE METAL:\n');
fprintf('Erro médio: %.4f mm\n', erro_medio);
fprintf('Desvio padrão do erro: %.4f mm\n', desvio);
fprintf('Incerteza média (95,45%%): %.4f mm\n\n', incerteza_media);

% Ajuste linear da curva de erros
coef = polyfit(valor_real, erro, 1);
slope = coef(1);
intercept = coef(2);

% Equação da curva de erros
fprintf('EQUAÇÃO DA CURVA DE ERROS:\n');
fprintf('Erro = %.6f × Valor + %.6f\n', slope, intercept);
fprintf('(Erro em mm, Valor em mm)\n\n');

% Cálculo do erro máximo
erro_maximo = max(abs(erro) + incerteza);
fprintf('ERRO MÁXIMO: %.4f mm\n\n', erro_maximo);

% ----- GRÁFICO: CURVA DE ERROS -----

% Gerar pontos para plotar a reta
x_range = linspace(0, 110, 500);
y_curva = polyval(coef, x_range);

% Criar figura com tamanho adequado
figure('Position', [100, 100, 900, 600]);
clf;
hold on;

% Definir cor para o paquímetro
cor_paq = [0, 0.7, 0];  % verde

% Calcular o erro máximo para definir as linhas de referência
E_max = erro_maximo;
E_max = ceil(E_max * 10) / 10;  % Arredondar para cima para a primeira casa decimal

% Plotar linhas horizontais pontilhadas para Emáx e -Emáx
h_emax_pos = plot([0, 110], [E_max, E_max], 'k:', 'LineWidth', 1.5);
h_emax_neg = plot([0, 110], [-E_max, -E_max], 'k:', 'LineWidth', 1.5);
text(5, E_max + 0.01, 'E_{máx}', 'FontSize', 12, 'FontWeight', 'bold');
text(5, -E_max - 0.03, '-E_{máx}', 'FontSize', 12, 'FontWeight', 'bold');

% Plotar linha de erro zero
plot([0 110], [0 0], 'k--', 'LineWidth', 0.5);

% Calcular valor máximo de incerteza
max_incerteza = max(incerteza);

% Plotar pontos medidos - Melhorar visualização dos pontos
h_pontos = scatter(valor_real, erro, 100, 'd', 'MarkerEdgeColor', cor_paq, 'MarkerFaceColor', [0.7, 1, 0.7], 'LineWidth', 1.5);

% Plotar curva de erros
h_curva = plot(x_range, y_curva, '-', 'LineWidth', 2.5, 'Color', cor_paq);

% Plotar envelope de incerteza
h_inc_sup = plot(x_range, y_curva + max_incerteza, '--', 'LineWidth', 1.5, 'Color', cor_paq);
h_inc_inf = plot(x_range, y_curva - max_incerteza, '--', 'LineWidth', 1.5, 'Color', cor_paq);

% Configurações do gráfico
grid on;
box on;
xlabel('Valor nominal (mm)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Erro (mm)', 'FontSize', 14, 'FontWeight', 'bold');
title('Curva de erros do Paquímetro Analógico de Metal', 'FontSize', 16, 'FontWeight', 'bold');

% Definir limites dos eixos
ylim([-E_max*1.5, E_max*1.5]);
xlim([0, 110]);

% Reservar espaço para o gráfico antes de adicionar a legenda
pos = get(gca, 'Position');
set(gca, 'Position', [pos(1), pos(2), pos(3)*0.8, pos(4)]);

% Criar legenda completa com todas as informações
legend([h_curva, h_pontos, h_inc_sup, h_emax_pos], ...
       {sprintf('Curva de tendência do erro'), ...
        sprintf('Pontos medidos'), ...
        sprintf('Limite de confiança (95,45%%)'), ...
        sprintf('Limite de erro máximo: %.4f mm', erro_maximo)}, ...
        'Location', 'eastoutside', 'FontSize', 10, 'Box', 'on');

% Melhorar aparência geral
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1.2);

% Salvar gráfico como PNG com melhor resolução
print('curva_erros_paquimetro_metal.png', '-dpng', '-r400', '-loose');

fprintf('Análise concluída! Gráfico salvo em: "curva_erros_paquimetro_metal.png"\n'); 