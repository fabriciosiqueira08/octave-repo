% Análise Metrológica do Voltímetro Eletrônico
% Questão: Curva de Erros e Erro Máximo para 12V

clear all;
close all;
clc;

fprintf('=== ANÁLISE METROLÓGICA DO VOLTÍMETRO ELETRÔNICO ===\n\n');

% Dados das medições
% Pilha padrão de 10V (valor verdadeiro)
valor_real_10V = 10.0;
medicoes_10V = [10.08, 10.09, 10.00, 10.14, 10.01, 10.05, 10.05, 10.04, 10.06, 10.08];

% Pilha padrão de 20V (valor verdadeiro)  
valor_real_20V = 20.0;
medicoes_20V = [20.11, 20.10, 20.14, 20.13, 20.09, 20.09, 20.13, 20.12, 20.18, 20.05];

% Cálculo dos erros para cada medição
erros_10V = medicoes_10V - valor_real_10V;
erros_20V = medicoes_20V - valor_real_20V;

% Estatísticas para 10V
media_10V = mean(medicoes_10V);
desvio_10V = std(medicoes_10V);
erro_medio_10V = mean(erros_10V);

% Estatísticas para 20V
media_20V = mean(medicoes_20V);
desvio_20V = std(medicoes_20V);
erro_medio_20V = mean(erros_20V);

% Exibir estatísticas
fprintf('PILHA DE 10V:\n');
fprintf('Média das medições: %.4f V\n', media_10V);
fprintf('Desvio padrão: %.4f V\n', desvio_10V);
fprintf('Erro médio: %.4f V\n', erro_medio_10V);
fprintf('Erros individuais: ');
fprintf('%.3f ', erros_10V);
fprintf('\n\n');

fprintf('PILHA DE 20V:\n');
fprintf('Média das medições: %.4f V\n', media_20V);
fprintf('Desvio padrão: %.4f V\n', desvio_20V);
fprintf('Erro médio: %.4f V\n', erro_medio_20V);
fprintf('Erros individuais: ');
fprintf('%.3f ', erros_20V);
fprintf('\n\n');

% Para distribuição normal com 95,45% de abrangência (2 sigma)
k = 2; % fator de cobertura para 95,45%

% Incerteza expandida para cada ponto
incerteza_10V = k * desvio_10V;
incerteza_20V = k * desvio_20V;

fprintf('INCERTEZAS EXPANDIDAS (95,45%%):\n');
fprintf('10V: ±%.4f V\n', incerteza_10V);
fprintf('20V: ±%.4f V\n', incerteza_20V);
fprintf('\n');

% a) CURVA DE ERROS (Erro x Indicação)
% Pontos para a curva de calibração
indicacoes = [media_10V, media_20V];
erros_medios = [erro_medio_10V, erro_medio_20V];
incertezas = [incerteza_10V, incerteza_20V];

% Ajuste linear da curva de erros
coef = polyfit(indicacoes, erros_medios, 1);
slope = coef(1);
intercept = coef(2);

fprintf('EQUAÇÃO DA CURVA DE ERROS:\n');
fprintf('Erro = %.6f × Indicação + %.6f\n', slope, intercept);
fprintf('(Erro em V, Indicação em V)\n\n');

% Gerar pontos para plotar a reta
x_plot = linspace(9, 21, 100);
y_plot = polyval(coef, x_plot);

% b) ERRO MÁXIMO para pilha de 12V
valor_12V = 12.0;
erro_12V = polyval(coef, valor_12V);

% Interpolação da incerteza para 12V
incerteza_12V = interp1(indicacoes, incertezas, valor_12V, 'linear');

erro_maximo_12V = abs(erro_12V) + incerteza_12V;

fprintf('ERRO PARA PILHA DE 12V:\n');
fprintf('Erro calculado: %.4f V\n', erro_12V);
fprintf('Incerteza expandida: ±%.4f V\n', incerteza_12V);
fprintf('ERRO MÁXIMO: %.4f V\n\n', erro_maximo_12V);

% GRÁFICO: CURVA DE ERROS (Erro x Indicação) - Modelo do Professor
figure(1);
clf;
hold on;

% Calcular o erro máximo para definir as linhas de referência
E_max = max(abs([erros_medios])) + max(incertezas);

% Definir faixa ampla para o gráfico (seguindo modelo da imagem)
x_range = linspace(8, 22, 100);
y_curva = polyval(coef, x_range);

% Interpolar incerteza ao longo da curva ampla
incerteza_range = interp1(indicacoes, incertezas, x_range, 'linear', 'extrap');

% Curvas de erro superior e inferior (envelope de incerteza)
y_superior = y_curva + incerteza_range;
y_inferior = y_curva - incerteza_range;

% Plotar as linhas horizontais pontilhadas para Emáx e -Emáx
x_lim = [8, 22];
plot(x_lim, [E_max, E_max], 'k:', 'LineWidth', 1.5);
plot(x_lim, [-E_max, -E_max], 'k:', 'LineWidth', 1.5);

% Plotar curvas de erro (superior e inferior)
plot(x_range, y_superior, 'g-', 'LineWidth', 2);
plot(x_range, y_inferior, 'g-', 'LineWidth', 2);

% Plotar ajuste linear principal (curva de erros central)
plot(x_range, y_curva, 'b-', 'LineWidth', 2);

% Plotar dados medidos (pontos) - estilo similar à imagem
plot(indicacoes, erros_medios, 'wo', 'MarkerSize', 10, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);

% Marcar o erro em 12V com destaque
plot(valor_12V, erro_12V, 'co', 'MarkerSize', 12, 'MarkerFaceColor', 'c', 'MarkerEdgeColor', 'k', 'LineWidth', 2);

% Adicionar texto para Emáx (seguindo modelo da imagem)
text(8.5, E_max + 0.005, 'E_{máx}', 'FontSize', 12, 'FontWeight', 'bold');
text(8.5, -E_max - 0.015, '-E_{máx}', 'FontSize', 12, 'FontWeight', 'bold');

% Marcar ponto especial (equivalente ao "1015" da imagem)
plot(valor_12V, 0, 'v', 'MarkerSize', 8, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
text(valor_12V, -0.025, '12V', 'FontSize', 10, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% Configurações do gráfico (seguindo modelo)
xlabel('indicação', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('erro', 'FontSize', 14, 'FontWeight', 'bold');
title('Curva de erros', 'FontSize', 16, 'FontWeight', 'bold');
grid on;

% Ajustar limites dos eixos para seguir o modelo
xlim([8, 22]);
ylim([-E_max*1.3, E_max*1.3]);

% Melhorar aparência geral
set(gca, 'FontSize', 12);
set(gca, 'LineWidth', 1.2);

% Salvar gráfico como PNG
print('curva_erros_voltimetro.png', '-dpng', '-r300');

% Salvar resultados em arquivo
fid = fopen('resultados_analise.txt', 'w');
fprintf(fid, 'RESULTADOS DA ANÁLISE METROLÓGICA\n');
fprintf(fid, '=================================\n\n');
fprintf(fid, 'Equação da Curva de Erros:\n');
fprintf(fid, 'Erro = %.6f × Indicação + %.6f\n\n', slope, intercept);
fprintf(fid, 'Para pilha de 12V:\n');
fprintf(fid, 'Erro calculado: %.4f V\n', erro_12V);
fprintf(fid, 'Incerteza expandida: ±%.4f V\n', incerteza_12V);
fprintf(fid, 'ERRO MÁXIMO: %.4f V\n', erro_maximo_12V);
fclose(fid);

fprintf('Análise concluída! Arquivos gerados:\n');
fprintf('  ✓ Resultados: "resultados_analise.txt"\n');
fprintf('  ✓ Gráfico PNG: "curva_erros_voltimetro.png"\n');
fprintf('  ✓ Curva de Erros exibida na Figura 1 (modelo do professor)\n');

% Análise concluída com sucesso!
fprintf('\n=== RESUMO FINAL ===\n');
fprintf('✓ Curva de Erros: Erro = %.6f × Indicação + %.6f\n', slope, intercept);
fprintf('✓ Erro Máximo para 12V: %.4f V\n', erro_maximo_12V);
fprintf('✓ Erro Máximo Geral (Emáx): %.4f V\n', E_max);
fprintf('✓ Gráfico reformatado conforme modelo do professor\n');
fprintf('✓ Arquivos salvos com sucesso!\n'); 