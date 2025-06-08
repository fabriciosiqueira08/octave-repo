% Exercício (c) - Tendência e Incerteza: Versão Objetiva
clear all; close all; clc;

% Dados das 100 medições de 5000g
medicoes = [5005, 5005, 5004, 5003, 5004, 5003, 5002, 5005, 5003, 5006, ...
            5002, 5003, 5003, 5003, 5002, 5004, 5004, 5002, 5005, 5005, ...
            5003, 5001, 5005, 5000, 5005, 5002, 5001, 5003, 5002, 5003, ...
            4999, 5003, 5005, 5003, 5000, 5002, 5005, 5005, 5002, 5006, ...
            5004, 5004, 5004, 5005, 5001, 5002, 5003, 5002, 5001, 5002, ...
            5001, 5001, 5003, 5003, 5004, 5005, 5001, 5004, 5005, 5003, ...
            5004, 5005, 5003, 5005, 4999, 5002, 5003, 5001, 5006, 5002, ...
            5003, 5004, 5004, 5004, 5001, 5003, 5002, 5002, 5002, 5002, ...
            4997, 5006, 5004, 5004, 5004, 5002, 5003, 5001, 5000, 5001, ...
            5006, 5006, 5001, 5002, 5003, 5004, 5003, 5005, 5005, 5003];

valor_verdadeiro = 5000.0;
n_medicoes = [100, 16, 4];

fprintf('ITEM (c) - TENDÊNCIA E INCERTEZA\n');
fprintf('================================\n\n');

% Cálculos para cada número de medições
for i = 1:3
    n = n_medicoes(i);
    dados = medicoes(1:n);
    
    media = mean(dados);
    desvio = std(dados);
    tendencia = media - valor_verdadeiro;
    incerteza = desvio / sqrt(n);
    
    faixa_min = tendencia - incerteza;
    faixa_max = tendencia + incerteza;
    
    fprintf('%d MEDIÇÕES:\n', n);
    fprintf('Tendência = %.3f g\n', tendencia);
    fprintf('Incerteza = %.3f g\n', incerteza);
    fprintf('Resultado = (%.3f ± %.3f) g\n', tendencia, incerteza);
    fprintf('Faixa = [%.3f, %.3f] g\n\n', faixa_min, faixa_max);
    
    % Armazenar para análise
    T(i) = tendencia;
    U(i) = incerteza;
    F_min(i) = faixa_min;
    F_max(i) = faixa_max;
end

% VERIFICAÇÃO DE CONSISTÊNCIA
fprintf('VERIFICAÇÃO DE CONSISTÊNCIA:\n');
fprintf('============================\n');
comparacoes = {'100 vs 16', '100 vs 4', '16 vs 4'};
indices = [1 2; 1 3; 2 3];

for i = 1:3
    idx1 = indices(i,1);
    idx2 = indices(i,2);
    
    % Verificar sobreposição
    sobreposicao = (F_min(idx1) <= F_max(idx2)) && (F_min(idx2) <= F_max(idx1));
    
    if sobreposicao
        fprintf('✓ %s medições: CONSISTENTES\n', comparacoes{i});
    else
        fprintf('✗ %s medições: INCONSISTENTES\n', comparacoes{i});
    end
end

% GRÁFICO CLARO DAS FAIXAS DE INCERTEZA
figure(1);
clf;
set(gcf, 'Position', [100 100 1000 600]);

% Cores distintas para cada número de medições
cores = {[0.8 0.2 0.2], [0.2 0.6 0.8], [0.2 0.8 0.2]};  % Vermelho, Azul, Verde
labels_n = {'100 medições', '16 medições', '4 medições'};

% Posições verticais para cada faixa (como faixas horizontais)
y_pos = [3, 2, 1];  % De cima para baixo: 100, 16, 4

hold on;

% Desenhar cada faixa de incerteza como um retângulo horizontal
for i = 1:3
    % Retângulo da faixa de incerteza
    rectangle('Position', [F_min(i), y_pos(i)-0.15, F_max(i)-F_min(i), 0.3], ...
              'FaceColor', cores{i}, 'FaceAlpha', 0.4, 'EdgeColor', cores{i}, 'LineWidth', 2);
    
    % Linha central (valor da tendência)
    plot(T(i), y_pos(i), 'o', 'MarkerSize', 10, 'MarkerFaceColor', cores{i}, ...
         'MarkerEdgeColor', 'k', 'LineWidth', 2);
    
    % Texto com os valores - posições específicas para cada faixa
    if i == 1  % 100 medições - acima da faixa
        text_x = (F_min(i) + F_max(i)) / 2;
        text_y = y_pos(i) + 0.4;
        text_align = 'center';
    elseif i == 2  % 16 medições - à direita da faixa
        text_x = F_max(i) + 0.2;
        text_y = y_pos(i);
        text_align = 'left';
    else  % 4 medições - à direita da faixa, mais abaixo
        text_x = F_max(i) + 0.2;
        text_y = y_pos(i) - 0.2;
        text_align = 'left';
    end
    
    text(text_x, text_y, sprintf('%s\nT = %.3f g\nu = ±%.3f g\n[%.3f, %.3f]', ...
         labels_n{i}, T(i), U(i), F_min(i), F_max(i)), ...
         'FontSize', 10, 'VerticalAlignment', 'middle', 'HorizontalAlignment', text_align);
end

% Destacar região de interceptação entre 16 e 4 medições (se houver)
overlap_min = max(F_min(2), F_min(3));  % Máximo dos mínimos
overlap_max = min(F_max(2), F_max(3));  % Mínimo dos máximos

if overlap_min <= overlap_max
    % Há interceptação
    rectangle('Position', [overlap_min, 0.7, overlap_max-overlap_min, 2.6], ...
              'FaceColor', [1 1 0], 'FaceAlpha', 0.3, 'EdgeColor', [1 0.5 0], ...
              'LineWidth', 3, 'LineStyle', '--');
    text((overlap_min + overlap_max)/2, 0.5, ...
         sprintf('REGIÃO DE\nINTERCEPTAÇÃO\n[%.3f, %.3f]', overlap_min, overlap_max), ...
         'HorizontalAlignment', 'center', 'FontSize', 11, 'FontWeight', 'bold', ...
         'BackgroundColor', [1 1 0], 'EdgeColor', [1 0.5 0]);
end

% Linha vertical no zero para referência
plot([0, 0], [0.5, 3.5], 'k--', 'LineWidth', 1.5, 'Color', [0.5 0.5 0.5]);
text(0, 0.3, 'Zero\n(sem tendência)', 'HorizontalAlignment', 'center', ...
     'FontSize', 9, 'Color', [0.5 0.5 0.5]);

% Configurações dos eixos
xlim([min(F_min)-0.5, max(F_max)+3]);
ylim([0.2, 3.8]);
set(gca, 'YTick', y_pos, 'YTickLabel', labels_n);
xlabel('Tendência (g)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Número de Medições', 'FontSize', 12, 'FontWeight', 'bold');
title('Faixas de Incerteza da Tendência - Verificação de Consistência', ...
      'FontSize', 14, 'FontWeight', 'bold');
grid on;

% Adicionar texto explicativo no lado direito
text_exp = {
    'INTERPRETAÇÃO:',
    '• Faixas que se sobrepõem = CONSISTENTES',
    '• Faixas que não se sobrepõem = INCONSISTENTES',
    '',
    'RESULTADO:',
    sprintf('• 100 vs 16: %s', char(cellstr(["INCONSISTENTE"; "CONSISTENTE"])((F_min(1) <= F_max(2) && F_min(2) <= F_max(1))+1))),
    sprintf('• 100 vs 4: %s', char(cellstr(["INCONSISTENTE"; "CONSISTENTE"])((F_min(1) <= F_max(3) && F_min(3) <= F_max(1))+1))),
    sprintf('• 16 vs 4: %s', char(cellstr(["INCONSISTENTE"; "CONSISTENTE"])((F_min(2) <= F_max(3) && F_min(3) <= F_max(2))+1)))
};

text(max(F_max)+0.3, 3.5, text_exp, 'FontSize', 9, 'VerticalAlignment', 'top', ...
     'BackgroundColor', [0.95 0.95 0.95], 'EdgeColor', 'k', 'LineWidth', 1);

print('faixas_incerteza_tendencia.png', '-dpng', '-r300');

fprintf('\n✓ Gráfico salvo: "faixas_incerteza_tendencia.png"\n');
fprintf('\nCONCLUSÃO FINAL:\n');
if overlap_min <= overlap_max
    fprintf('✓ As faixas de 16 e 4 medições SÃO CONSISTENTES (se interceptam)\n');
    fprintf('✗ A faixa de 100 medições NÃO é consistente com as demais\n');
else
    fprintf('✗ NENHUMA das faixas é consistente entre si\n');
end 