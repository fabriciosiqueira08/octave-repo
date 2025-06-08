% Item (c) - Verificação da Repetitividade na Prática
% Calcula erro aleatório e verifica se 95% estão dentro de ±Re

clear all;
close all;
clc;

fprintf('=== ITEM (c) - VERIFICAÇÃO DA REPETITIVIDADE ===\n\n');

% Dados das 100 medições (em gramas) - mesmo dos itens anteriores
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

% Parâmetros do item (b)
n = length(medicoes);
media = mean(medicoes);
desvio_padrao = std(medicoes);
t_critico = 1.984;  % Para 95% confiança e 99 graus de liberdade
repetitividade = t_critico * desvio_padrao;

fprintf('DADOS BÁSICOS:\n');
fprintf('Número de medições: %d\n', n);
fprintf('Média das indicações: %.2f g\n', media);
fprintf('Desvio padrão: %.4f g\n', desvio_padrao);
fprintf('Repetitividade (Re): %.4f g\n', repetitividade);
fprintf('\n');

% ETAPA 1: Calcular erro aleatório para cada indicação
fprintf('ETAPA 1 - CÁLCULO DOS ERROS ALEATÓRIOS:\n');
fprintf('Fórmula: Erro aleatório = Indicação - Média\n\n');

erros_aleatorios = medicoes - media;

% Mostrar alguns exemplos
fprintf('Exemplos de cálculo:\n');
for i = 1:5
    fprintf('Medição %d: %.0f - %.2f = %.4f g\n', ...
            i, medicoes(i), media, erros_aleatorios(i));
end
fprintf('...\n\n');

% Estatísticas dos erros aleatórios
fprintf('ESTATÍSTICAS DOS ERROS ALEATÓRIOS:\n');
fprintf('Erro mínimo: %.4f g\n', min(erros_aleatorios));
fprintf('Erro máximo: %.4f g\n', max(erros_aleatorios));
fprintf('Amplitude total: %.4f g\n', max(erros_aleatorios) - min(erros_aleatorios));
fprintf('Média dos erros: %.6f g (deve ser ≈ 0)\n', mean(erros_aleatorios));
fprintf('\n');

% ETAPA 2: Verificar quantos erros estão dentro de ±Re
fprintf('ETAPA 2 - VERIFICAÇÃO DA FAIXA ±Re:\n');
fprintf('Repetitividade (Re) = %.4f g\n', repetitividade);
fprintf('Faixa aceitável: -%.4f g ≤ erro ≤ +%.4f g\n', repetitividade, repetitividade);
fprintf('\n');

% Contar erros dentro da faixa
erros_dentro_faixa = abs(erros_aleatorios) <= repetitividade;
num_dentro_faixa = sum(erros_dentro_faixa);
percentual_dentro = (num_dentro_faixa / n) * 100;

fprintf('RESULTADOS DA VERIFICAÇÃO:\n');
fprintf('Erros dentro da faixa ±Re: %d de %d\n', num_dentro_faixa, n);
fprintf('Percentual dentro da faixa: %.1f%%\n', percentual_dentro);
fprintf('Meta (mínimo): 95.0%%\n');

% Verificar se atende ao critério
if percentual_dentro >= 95.0
    fprintf('✓ APROVADO: %.1f%% ≥ 95.0%%\n', percentual_dentro);
    status = 'APROVADO';
else
    fprintf('✗ REPROVADO: %.1f%% < 95.0%%\n', percentual_dentro);
    status = 'REPROVADO';
end
fprintf('\n');

% ANÁLISE DETALHADA - Mostrar quais medições ficaram fora
erros_fora_faixa = find(~erros_dentro_faixa);
if length(erros_fora_faixa) > 0
    fprintf('MEDIÇÕES FORA DA FAIXA ±Re:\n');
    fprintf('Nº | Indicação | Erro Aleatório | |Erro| > Re?\n');
    fprintf('---|-----------|----------------|----------\n');
    for i = 1:length(erros_fora_faixa)
        idx = erros_fora_faixa(i);
        fprintf('%2d |   %4.0f g  |    %+.4f g    |    SIM\n', ...
                idx, medicoes(idx), erros_aleatorios(idx));
    end
else
    fprintf('✓ Todas as medições estão dentro da faixa ±Re\n');
end
fprintf('\n');

% GRÁFICO DE VISUALIZAÇÃO
figure(1);
clf;

% Subplot 1: Erros aleatórios vs número da medição
subplot(2, 1, 1);
plot(1:n, erros_aleatorios, 'bo', 'MarkerSize', 4);
hold on;

% Linhas de limite ±Re
plot([1 n], [repetitividade repetitividade], 'r--', 'LineWidth', 2);
plot([1 n], [-repetitividade -repetitividade], 'r--', 'LineWidth', 2);

% Destacar pontos fora da faixa
if length(erros_fora_faixa) > 0
    plot(erros_fora_faixa, erros_aleatorios(erros_fora_faixa), 'ro', 'MarkerSize', 8);
end

% Linha zero
plot([1 n], [0 0], 'k-', 'LineWidth', 1);

title('Erros Aleatórios vs Número da Medição');
xlabel('Número da Medição');
ylabel('Erro Aleatório (g)');
legend('Erros dentro', 'Limite +Re', 'Limite -Re', 'Erros fora', 'Zero', 'Location', 'eastoutside');
grid on;

% Subplot 2: Histograma dos erros aleatórios
subplot(2, 1, 2);
hist(erros_aleatorios, 15);
hold on;

% Linhas de limite ±Re
ylim_atual = ylim;
plot([repetitividade repetitividade], ylim_atual, 'r--', 'LineWidth', 2);
plot([-repetitividade -repetitividade], ylim_atual, 'r--', 'LineWidth', 2);

title('Distribuição dos Erros Aleatórios');
xlabel('Erro Aleatório (g)');
ylabel('Frequência');
legend('Erros', 'Limite ±Re', 'Location', 'northwest');
grid on;

% Salvar gráfico
print('verificacao_repetitividade.png', '-dpng', '-r300');

% RELATÓRIO FINAL
fprintf('RELATÓRIO FINAL - ITEM (c):\n');
fprintf('═══════════════════════════════════════════════\n');
fprintf('OBJETIVO: Verificar se 95%% dos erros aleatórios\n');
fprintf('          estão dentro da faixa ±Re\n\n');
fprintf('DADOS:\n');
fprintf('• Repetitividade (Re): %.4f g\n', repetitividade);
fprintf('• Faixa aceita: ±%.4f g\n', repetitividade);
fprintf('• Total de medições: %d\n', n);
fprintf('\nRESULTADOS:\n');
fprintf('• Medições dentro da faixa: %d\n', num_dentro_faixa);
fprintf('• Medições fora da faixa: %d\n', n - num_dentro_faixa);
fprintf('• Percentual dentro: %.1f%%\n', percentual_dentro);
fprintf('\nCONCLUSÃO:\n');
fprintf('• Status: %s\n', status);
if percentual_dentro >= 95.0
    fprintf('• A repetitividade calculada é VÁLIDA\n');
    fprintf('• O instrumento atende ao critério de 95%%\n');
else
    fprintf('• A repetitividade pode estar subestimada\n');
    fprintf('• Revisar cálculo ou critério de aceitação\n');
end
fprintf('═══════════════════════════════════════════════\n');

% SALVAR RESULTADOS
fid = fopen('resultados_verificacao_repetitividade.txt', 'w');
fprintf(fid, 'VERIFICAÇÃO DA REPETITIVIDADE - ITEM (c)\n');
fprintf(fid, '======================================\n\n');
fprintf(fid, 'Repetitividade (Re): %.4f g\n', repetitividade);
fprintf(fid, 'Faixa aceitável: ±%.4f g\n', repetitividade);
fprintf(fid, '\nResultados:\n');
fprintf(fid, 'Medições dentro da faixa: %d de %d\n', num_dentro_faixa, n);
fprintf(fid, 'Percentual: %.1f%%\n', percentual_dentro);
fprintf(fid, 'Status: %s\n', status);
fprintf(fid, '\nCritério: Mínimo 95%% dentro da faixa\n');

if length(erros_fora_faixa) > 0
    fprintf(fid, '\nMedições fora da faixa:\n');
    for i = 1:length(erros_fora_faixa)
        idx = erros_fora_faixa(i);
        fprintf(fid, 'Medição %d: erro = %+.4f g\n', idx, erros_aleatorios(idx));
    end
end
fclose(fid);

fprintf('\n✓ Gráfico salvo: "verificacao_repetitividade.png"\n');
fprintf('✓ Resultados salvos: "resultados_verificacao_repetitividade.txt"\n');
fprintf('\n=== ITEM (c) CONCLUÍDO ===\n'); 