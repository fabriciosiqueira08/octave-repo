% Comparação dos Três Paquímetros
% Questão: Traça as curvas de erros dos três paquímetros em um mesmo gráfico
% Mostra a linha de tendência e as linhas que delimitam a região com 95,45% de abrangência
% Destaca o erro máximo de cada paquímetro

clear all;
close all;
clc;

fprintf('=== COMPARAÇÃO DAS CURVAS DE ERROS DOS PAQUÍMETROS ===\n\n');

% Dados do Paquímetro Digital
tabela_paq1 = [
    24.0, 24.0, 0.012, 3.307, 0.04, 24.04, 23.96;
    100.0, 100.02, 0.006, 3.307, 0.02, 100.04, 100.0;
    1.49, 1.5, 0.01, 3.307, 0.03, 1.53, 1.47;
    12.5, 12.5, 0.015, 3.307, 0.05, 12.55, 12.45;
    1.001, 1.01, 0.0, 3.307, 0.0, 1.01, 1.01
];

% Dados do Paquímetro Analógico de Plástico
tabela_paq2 = [
    24.0, 24.1, 0.0, 3.307, 0.0, 24.1, 24.1;
    100.0, 100.1, 0.0, 3.307, 0.0, 100.1, 100.1;
    1.49, 1.34, 0.11, 3.307, 0.36, 1.7, 0.98;
    12.5, 12.5, 0.0, 3.307, 0.0, 12.5, 12.5;
    1.001, 1.06, 0.083, 3.307, 0.27, 1.33, 0.79
];

% Dados do Paquímetro Analógico de Metal
tabela_paq3 = [
    24.0, 24.0, 0.0, 3.307, 0.0, 24.0, 24.0;
    100.0, 100.0, 0.0, 3.307, 0.0, 100.0, 100.0;
    1.49, 1.5, 0.0, 3.307, 0.0, 1.5, 1.5;
    12.5, 12.5, 0.0, 3.307, 0.0, 12.5, 12.5;
    1.001, 1.00, 0.0, 3.307, 0.0, 1.00, 1.00
];

% ANÁLISE DOS DADOS

% Paquímetro Digital
valor_real1 = tabela_paq1(:, 1)';
tendencia1 = tabela_paq1(:, 2)';
incerteza1 = tabela_paq1(:, 5)';
erro1 = tendencia1 - valor_real1;
coef1 = polyfit(valor_real1, erro1, 1);
erro_max1 = max(abs(erro1) + incerteza1);
fprintf('PAQUÍMETRO DIGITAL:\n');
fprintf('Equação: Erro = %.6f × Valor + %.6f\n', coef1(1), coef1(2));
fprintf('Erro máximo: %.4f mm\n\n', erro_max1);

% Paquímetro Analógico de Plástico
valor_real2 = tabela_paq2(:, 1)';
tendencia2 = tabela_paq2(:, 2)';
incerteza2 = tabela_paq2(:, 5)';
erro2 = tendencia2 - valor_real2;
coef2 = polyfit(valor_real2, erro2, 1);
erro_max2 = max(abs(erro2) + incerteza2);
fprintf('PAQUÍMETRO ANALÓGICO DE PLÁSTICO:\n');
fprintf('Equação: Erro = %.6f × Valor + %.6f\n', coef2(1), coef2(2));
fprintf('Erro máximo: %.4f mm\n\n', erro_max2);

% Paquímetro Analógico de Metal
valor_real3 = tabela_paq3(:, 1)';
tendencia3 = tabela_paq3(:, 2)';
incerteza3 = tabela_paq3(:, 5)';
erro3 = tendencia3 - valor_real3;
coef3 = polyfit(valor_real3, erro3, 1);
erro_max3 = max(abs(erro3) + incerteza3);
fprintf('PAQUÍMETRO ANALÓGICO DE METAL:\n');
fprintf('Equação: Erro = %.6f × Valor + %.6f\n', coef3(1), coef3(2));
fprintf('Erro máximo: %.4f mm\n\n', erro_max3);

% Determinar o maior erro máximo para o gráfico
E_max = max([erro_max1, erro_max2, erro_max3]);
E_max = ceil(E_max * 10) / 10;  % Arredondar para cima para a primeira casa decimal

% Determinar incertezas máximas para cada paquímetro
max_incerteza1 = max(incerteza1);
max_incerteza2 = max(incerteza2);
max_incerteza3 = max(incerteza3);

% Criar figura com tamanho específico para acomodar o gráfico e a legenda
figure('Position', [100, 100, 1200, 600]);
clf;
hold on;

% Cores para cada paquímetro
cor1 = [0, 0, 1];   % Azul (Digital)
cor2 = [1, 0, 0];   % Vermelho (Plástico)
cor3 = [0, 0.7, 0]; % Verde (Metal)

% Marcadores para cada paquímetro
marcador1 = 'o'; % Círculo (Digital)
marcador2 = 's'; % Quadrado (Plástico)  
marcador3 = 'd'; % Diamante (Metal)

% Pontos para as curvas
x_range = linspace(0, 110, 500);
y1_curva = polyval(coef1, x_range);
y2_curva = polyval(coef2, x_range);
y3_curva = polyval(coef3, x_range);

% Linha de erro zero e linhas de erro máximo
plot([0, 110], [0, 0], 'k--', 'LineWidth', 0.5);
h_emax_pos = plot([0, 110], [E_max, E_max], 'k:', 'LineWidth', 1.5);
h_emax_neg = plot([0, 110], [-E_max, -E_max], 'k:', 'LineWidth', 1.5);
text(5, E_max + 0.01, 'E_{máx}', 'FontSize', 12, 'FontWeight', 'bold');
text(5, -E_max - 0.03, '-E_{máx}', 'FontSize', 12, 'FontWeight', 'bold');

% PAQUÍMETRO DIGITAL
% Pontos medidos - Melhorar visualização
h1_pontos = scatter(valor_real1, erro1, 100, marcador1, 'MarkerEdgeColor', cor1, 'MarkerFaceColor', [0.7, 0.7, 1], 'LineWidth', 1.5);

% Curva de tendência
h1_curva = plot(x_range, y1_curva, '-', 'LineWidth', 2.5, 'Color', cor1);

% Envelope de incerteza 
h1_inc_sup = plot(x_range, y1_curva + max_incerteza1, '--', 'LineWidth', 1.5, 'Color', cor1);
h1_inc_inf = plot(x_range, y1_curva - max_incerteza1, '--', 'LineWidth', 1.5, 'Color', cor1);

% PAQUÍMETRO ANALÓGICO DE PLÁSTICO
% Pontos medidos - Melhorar visualização
h2_pontos = scatter(valor_real2, erro2, 100, marcador2, 'MarkerEdgeColor', cor2, 'MarkerFaceColor', [1, 0.7, 0.7], 'LineWidth', 1.5);

% Curva de tendência
h2_curva = plot(x_range, y2_curva, '-', 'LineWidth', 2.5, 'Color', cor2);

% Envelope de incerteza
h2_inc_sup = plot(x_range, y2_curva + max_incerteza2, '--', 'LineWidth', 1.5, 'Color', cor2);
h2_inc_inf = plot(x_range, y2_curva - max_incerteza2, '--', 'LineWidth', 1.5, 'Color', cor2);

% PAQUÍMETRO ANALÓGICO DE METAL
% Pontos medidos - Melhorar visualização
h3_pontos = scatter(valor_real3, erro3, 100, marcador3, 'MarkerEdgeColor', cor3, 'MarkerFaceColor', [0.7, 1, 0.7], 'LineWidth', 1.5);

% Curva de tendência
h3_curva = plot(x_range, y3_curva, '-', 'LineWidth', 2.5, 'Color', cor3);

% Envelope de incerteza
h3_inc_sup = plot(x_range, y3_curva + max_incerteza3, '--', 'LineWidth', 1.5, 'Color', cor3);
h3_inc_inf = plot(x_range, y3_curva - max_incerteza3, '--', 'LineWidth', 1.5, 'Color', cor3);

% Configurações do gráfico
grid on;
box on;
xlabel('Valor nominal (mm)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Erro (mm)', 'FontSize', 14, 'FontWeight', 'bold');
title('Comparação das Curvas de Erros dos Paquímetros', 'FontSize', 16, 'FontWeight', 'bold');

% Limites dos eixos
ylim([-E_max*1.5, E_max*1.5]);
xlim([0, 110]);

% Reservar espaço para o gráfico antes de adicionar a legenda
pos = get(gca, 'Position');
set(gca, 'Position', [pos(1), pos(2), pos(3)*0.75, pos(4)]);

% Legenda compacta com todas as informações
legend([h1_curva, h1_pontos, h1_inc_sup, ...
        h2_curva, h2_pontos, h2_inc_sup, ...
        h3_curva, h3_pontos, h3_inc_sup, ...
        h_emax_pos], ...
       {sprintf('Paq. Digital - Curva de tendência'), ...
        sprintf('Paq. Digital - Pontos medidos'), ...
        sprintf('Paq. Digital - Limite de conf. (Erro: %.4f mm)', erro_max1), ...
        sprintf('Paq. Plástico - Curva de tendência'), ...
        sprintf('Paq. Plástico - Pontos medidos'), ...
        sprintf('Paq. Plástico - Limite de conf. (Erro: %.4f mm)', erro_max2), ...
        sprintf('Paq. Metal - Curva de tendência'), ...
        sprintf('Paq. Metal - Pontos medidos'), ...
        sprintf('Paq. Metal - Limite de conf. (Erro: %.4f mm)', erro_max3), ...
        sprintf('Limite de erro máximo')}, ...
       'Location', 'eastoutside', 'FontSize', 9, 'Box', 'on');

% Melhorar aparência geral
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1.2);

% Salvar o gráfico comparativo com resolução maior e tamanho específico
print('comparacao_paquimetros.png', '-dpng', '-r400', '-loose');

fprintf('Comparação concluída!\n');
fprintf('Gráfico comparativo salvo como: "comparacao_paquimetros.png"\n\n');

% Identificar qual paquímetro tem o menor erro máximo
[menor_erro, idx_melhor] = min([erro_max1, erro_max2, erro_max3]);
nomes_paq = {'Digital', 'Analógico de Plástico', 'Analógico de Metal'};

fprintf('=== CONCLUSÃO ===\n');
fprintf('O paquímetro com menor erro máximo é o %s (%.4f mm)\n', nomes_paq{idx_melhor}, menor_erro);

% Verificar coeficientes angulares (tendência de variação do erro com a magnitude)
coefs_ang = [coef1(1), coef2(1), coef3(1)];
[menor_coef, idx_estavel] = min(abs(coefs_ang));

fprintf('O paquímetro com menor variação do erro em função da magnitude é o %s\n', nomes_paq{idx_estavel});
fprintf('(coeficiente angular mais próximo de zero: %.6f)\n', coefs_ang(idx_estavel));
