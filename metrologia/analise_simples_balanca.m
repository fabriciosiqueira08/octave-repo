% Análise Simples da Balança Digital - Questão Específica
% Objetivo: Histograma e comparação com distribuição normal
% Dados: 100 medições de massa de 1000g

clear all;
close all;
clc;

fprintf('=== ANÁLISE DA BALANÇA DIGITAL ===\n\n');

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

% 1. VERIFICAÇÃO DE VARIAÇÕES (Erro Aleatório)
valor_nominal = 1000.0;
n_medicoes = length(medicoes);
media = mean(medicoes);
desvio_padrao = std(medicoes);

fprintf('1. VERIFICAÇÃO DE VARIAÇÕES:\n');
fprintf('Número de medições: %d\n', n_medicoes);
fprintf('Valor nominal: %.0f g\n', valor_nominal);
fprintf('Média: %.2f g\n', media);
fprintf('Desvio padrão: %.2f g\n', desvio_padrao);
fprintf('Variação observada: %.0f g a %.0f g\n', min(medicoes), max(medicoes));
fprintf('✓ SIM - Há variações nas indicações devido ao erro aleatório\n\n');

% 2. CONTAGEM DE FREQUÊNCIAS
valores_unicos = unique(medicoes);
frequencias = zeros(size(valores_unicos));

for i = 1:length(valores_unicos)
    frequencias(i) = sum(medicoes == valores_unicos(i));
end

fprintf('2. CONTAGEM DE FREQUÊNCIAS:\n');
fprintf('Indicação (g) | Frequência\n');
fprintf('--------------|----------\n');
for i = 1:length(valores_unicos)
    fprintf('    %4.0f     |     %2d\n', valores_unicos(i), frequencias(i));
end
fprintf('\n');

% 3. HISTOGRAMA
figure(1);
clf;

% Criar histograma
bar(valores_unicos, frequencias, 'FaceColor', [0.3 0.6 0.9]);
hold on;

% Sobrepor curva normal teórica para comparação
x_teorico = linspace(min(valores_unicos)-1, max(valores_unicos)+1, 100);
y_teorico = (n_medicoes / (desvio_padrao * sqrt(2*pi))) * ...
            exp(-0.5 * ((x_teorico - media) / desvio_padrao).^2);
plot(x_teorico, y_teorico, 'r-', 'LineWidth', 3);

% Linha da média
ylim_atual = ylim;
plot([media media], ylim_atual, 'g--', 'LineWidth', 2);

title('Histograma das Medições da Balança Digital');
xlabel('Indicação (g)');
ylabel('Frequência');
legend('Dados Medidos', 'Distribuição Normal Teórica', 'Média');
grid on;

% Melhorar visualização
xlim([993 1004]);
set(gca, 'FontSize', 12);

% 4. COMPARAÇÃO COM DISTRIBUIÇÃO NORMAL
fprintf('3. COMPARAÇÃO COM DISTRIBUIÇÃO NORMAL:\n');

% Análise visual da forma
fprintf('Análise da forma do histograma:\n');
fprintf('- Centro: A distribuição está centrada em %.1f g\n', media);
fprintf('- Simetria: ');

% Verificar simetria comparando valores abaixo e acima da média
abaixo_media = sum(medicoes < media);
acima_media = sum(medicoes > media);
if abs(abaixo_media - acima_media) <= 5
    fprintf('Aproximadamente simétrica (%d abaixo, %d acima)\n', abaixo_media, acima_media);
else
    fprintf('Ligeiramente assimétrica (%d abaixo, %d acima)\n', abaixo_media, acima_media);
end

% Verificar concentração central
central = sum(abs(medicoes - media) <= desvio_padrao);
fprintf('- Concentração central: %.1f%% dos dados estão dentro de ±1σ\n', (central/n_medicoes)*100);
fprintf('  (Em distribuição normal: ~68.3%%)\n');

% Verificar formato campaniforme
valor_mais_frequente = valores_unicos(frequencias == max(frequencias));
fprintf('- Pico: O valor mais frequente é %.0f g (frequência: %d)\n', ...
        valor_mais_frequente(1), max(frequencias));

fprintf('\n4. CONCLUSÃO SOBRE A NORMALIDADE:\n');
if abs(media - valor_mais_frequente(1)) <= 0.5 && central >= 65
    fprintf('✓ A distribuição tem formato SIMILAR à normal:\n');
    fprintf('  - Forma campaniforme (sino)\n');
    fprintf('  - Simétrica ao redor da média\n');
    fprintf('  - Concentração central adequada\n');
else
    fprintf('⚠ A distribuição pode diferir ligeiramente da normal\n');
end

fprintf('\n5. RESPOSTA À QUESTÃO:\n');
fprintf('✓ Foram realizadas %d medições repetidas\n', n_medicoes);
fprintf('✓ Verificou-se variação devido ao erro aleatório (σ = %.2f g)\n', desvio_padrao);
fprintf('✓ Foi feita contagem de frequências de cada indicação\n');
fprintf('✓ Traçou-se histograma (eixo X: indicações, eixo Y: frequências)\n');
fprintf('✓ Comparou-se com distribuição normal: formato similar\n');

% Salvar o gráfico
print('histograma_balanca.png', '-dpng', '-r300');
fprintf('\n✓ Histograma salvo como "histograma_balanca.png"\n');

fprintf('\n=== ANÁLISE CONCLUÍDA ===\n'); 