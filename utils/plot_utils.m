% PLOT_UTILS - Funções utilitárias para plotagem
% Descrição: Coleção de funções para facilitar a criação de gráficos
% Autor: Repositório Octave
% Data: Janeiro 2025
% Versão: 1.0

function configurar_plot_padrao()
    % CONFIGURAR_PLOT_PADRAO - Aplica configurações padrão para plots
    %
    % Uso:
    %   configurar_plot_padrao()
    
    set(0, 'DefaultFigureColor', 'white');
    set(0, 'DefaultFigurePosition', [100 100 800 600]);
    set(0, 'DefaultAxesFontSize', 12);
    set(0, 'DefaultAxesFontName', 'Arial');
    set(0, 'DefaultTextFontSize', 12);
    set(0, 'DefaultLineLineWidth', 2);
    set(0, 'DefaultLineMarkerSize', 8);
    set(0, 'DefaultAxesBox', 'on');
    set(0, 'DefaultAxesGrid', 'on');
end

function fig = criar_figura_multipla(nrows, ncols, titulo)
    % CRIAR_FIGURA_MULTIPLA - Cria figura com subplots organizados
    %
    % Sintaxe:
    %   fig = criar_figura_multipla(nrows, ncols)
    %   fig = criar_figura_multipla(nrows, ncols, titulo)
    %
    % Exemplo:
    %   fig = criar_figura_multipla(2, 2, 'Meus Gráficos');
    
    if nargin < 3
        titulo = 'Análise';
    end
    
    fig = figure();
    clf;
    
    % Calcular tamanho da figura baseado no número de subplots
    base_width = 400;
    base_height = 300;
    fig_width = base_width * ncols;
    fig_height = base_height * nrows + 50; % Extra para título
    
    set(fig, 'Position', [100 100 fig_width fig_height]);
    sgtitle(titulo, 'FontSize', 16, 'FontWeight', 'bold');
end

function salvar_figura(nome_arquivo, formatos, dpi)
    % SALVAR_FIGURA - Salva figura atual em múltiplos formatos
    %
    % Sintaxe:
    %   salvar_figura(nome_arquivo)
    %   salvar_figura(nome_arquivo, formatos)
    %   salvar_figura(nome_arquivo, formatos, dpi)
    %
    % Parâmetros:
    %   nome_arquivo - Nome base do arquivo (sem extensão)
    %   formatos - Cell array com formatos {'png', 'pdf', 'eps'}
    %   dpi - Resolução para formatos raster (padrão: 300)
    %
    % Exemplo:
    %   salvar_figura('meu_grafico', {'png', 'pdf'}, 300);
    
    if nargin < 2
        formatos = {'png'};
    end
    if nargin < 3
        dpi = 300;
    end
    
    for i = 1:length(formatos)
        formato = formatos{i};
        arquivo_completo = sprintf('%s.%s', nome_arquivo, formato);
        
        switch formato
            case 'png'
                print(arquivo_completo, '-dpng', sprintf('-r%d', dpi));
            case 'pdf'
                print(arquivo_completo, '-dpdf');
            case 'eps'
                print(arquivo_completo, '-deps');
            case 'svg'
                print(arquivo_completo, '-dsvg');
            otherwise
                warning('Formato %s não suportado', formato);
        end
        
        fprintf('Figura salva: %s\n', arquivo_completo);
    end
end

function plot_com_barras_erro(x, y, erro, opcoes)
    % PLOT_COM_BARRAS_ERRO - Plot com barras de erro personalizadas
    %
    % Sintaxe:
    %   plot_com_barras_erro(x, y, erro)
    %   plot_com_barras_erro(x, y, erro, opcoes)
    %
    % Parâmetros:
    %   x, y - Vetores de dados
    %   erro - Vetor de erros ou valor escalar
    %   opcoes - Struct com opções de formatação
    %
    % Exemplo:
    %   opts.cor = 'blue';
    %   opts.marcador = 'o';
    %   opts.linha_style = '-';
    %   plot_com_barras_erro(1:10, randn(10,1), 0.1, opts);
    
    if nargin < 4
        opcoes = struct();
    end
    
    % Valores padrão
    if ~isfield(opcoes, 'cor'), opcoes.cor = 'blue'; end
    if ~isfield(opcoes, 'marcador'), opcoes.marcador = 'o'; end
    if ~isfield(opcoes, 'linha_style'), opcoes.linha_style = '-'; end
    if ~isfield(opcoes, 'tamanho_marcador'), opcoes.tamanho_marcador = 8; end
    if ~isfield(opcoes, 'largura_linha'), opcoes.largura_linha = 2; end
    
    hold on;
    
    % Plot principal
    plot(x, y, [opcoes.linha_style opcoes.marcador], ...
         'Color', opcoes.cor, ...
         'MarkerSize', opcoes.tamanho_marcador, ...
         'LineWidth', opcoes.largura_linha, ...
         'MarkerFaceColor', opcoes.cor);
    
    % Barras de erro
    errorbar(x, y, erro, 'Color', opcoes.cor, ...
             'LineStyle', 'none', 'LineWidth', 1);
end

function plot_histograma_melhorado(dados, nbins, titulo_hist, opcoes)
    % PLOT_HISTOGRAMA_MELHORADO - Histograma com estatísticas
    %
    % Sintaxe:
    %   plot_histograma_melhorado(dados)
    %   plot_histograma_melhorado(dados, nbins, titulo_hist, opcoes)
    %
    % Exemplo:
    %   dados = randn(1000, 1);
    %   plot_histograma_melhorado(dados, 30, 'Distribuição Normal');
    
    if nargin < 2, nbins = 20; end
    if nargin < 3, titulo_hist = 'Histograma'; end
    if nargin < 4, opcoes = struct(); end
    
    % Valores padrão
    if ~isfield(opcoes, 'mostrar_stats'), opcoes.mostrar_stats = true; end
    if ~isfield(opcoes, 'cor'), opcoes.cor = [0.3 0.6 0.9]; end
    if ~isfield(opcoes, 'alpha'), opcoes.alpha = 0.7; end
    
    % Criar histograma
    [n, x] = hist(dados, nbins);
    bar(x, n, 'FaceColor', opcoes.cor, 'FaceAlpha', opcoes.alpha, 'EdgeColor', 'black');
    
    title(titulo_hist);
    xlabel('Valor');
    ylabel('Frequência');
    grid on;
    
    % Adicionar estatísticas se solicitado
    if opcoes.mostrar_stats
        media = mean(dados);
        desvio = std(dados);
        
        % Linha da média
        hold on;
        ylim_atual = ylim;
        plot([media media], ylim_atual, 'r--', 'LineWidth', 2);
        
        % Texto com estatísticas
        stats_text = sprintf('μ = %.3f\nσ = %.3f\nn = %d', media, desvio, length(dados));
        text(0.7, 0.8, stats_text, 'Units', 'normalized', ...
             'BackgroundColor', 'white', 'EdgeColor', 'black', ...
             'FontSize', 10);
        
        legend('Dados', 'Média', 'Location', 'best');
    end
end

function cores = gerar_cores_categoricas(n)
    % GERAR_CORES_CATEGORICAS - Gera n cores distintas para gráficos
    %
    % Sintaxe:
    %   cores = gerar_cores_categoricas(n)
    %
    % Retorna:
    %   cores - Matriz n×3 com cores RGB
    %
    % Exemplo:
    %   cores = gerar_cores_categoricas(5);
    %   for i = 1:5
    %       plot(1:10, i*ones(1,10), 'Color', cores(i,:), 'LineWidth', 3);
    %   end
    
    if n <= 10
        % Cores pré-definidas para até 10 categorias
        cores_base = [
            0.00, 0.45, 0.74;  % Azul
            0.85, 0.33, 0.10;  % Vermelho
            0.93, 0.69, 0.13;  % Amarelo
            0.49, 0.18, 0.56;  % Roxo
            0.47, 0.67, 0.19;  % Verde
            0.30, 0.75, 0.93;  % Ciano
            0.64, 0.08, 0.18;  % Marrom
            0.74, 0.74, 0.74;  % Cinza
            1.00, 0.41, 0.16;  % Laranja
            0.39, 0.83, 0.07   % Verde claro
        ];
        cores = cores_base(1:n, :);
    else
        % Gerar cores usando HSV para muitas categorias
        h = linspace(0, 1, n+1);
        h = h(1:n);  % Remove o último (igual ao primeiro)
        s = ones(n, 1) * 0.8;
        v = ones(n, 1) * 0.9;
        cores = hsv2rgb([h' s v]);
    end
end

function aplicar_tema_profissional()
    % APLICAR_TEMA_PROFISSIONAL - Aplica tema profissional aos gráficos
    %
    % Uso:
    %   aplicar_tema_profissional()
    
    % Configurações de cores
    set(0, 'DefaultAxesColorOrder', [
        0.00, 0.45, 0.74;  % Azul
        0.85, 0.33, 0.10;  % Vermelho
        0.93, 0.69, 0.13;  % Amarelo
        0.49, 0.18, 0.56;  % Roxo
        0.47, 0.67, 0.19;  % Verde
        0.30, 0.75, 0.93;  % Ciano
        0.64, 0.08, 0.18   % Marrom
    ]);
    
    % Configurações de figura
    set(0, 'DefaultFigureColor', 'white');
    set(0, 'DefaultAxesColor', 'white');
    set(0, 'DefaultAxesFontName', 'Arial');
    set(0, 'DefaultAxesFontSize', 11);
    set(0, 'DefaultTextFontName', 'Arial');
    set(0, 'DefaultTextFontSize', 11);
    
    % Configurações de linha
    set(0, 'DefaultLineLineWidth', 1.5);
    set(0, 'DefaultLineMarkerSize', 6);
    
    % Configurações de grade
    set(0, 'DefaultAxesBox', 'on');
    set(0, 'DefaultAxesGrid', 'on');
    set(0, 'DefaultAxesGridAlpha', 0.3);
    set(0, 'DefaultAxesMinorGrid', 'on');
    set(0, 'DefaultAxesMinorGridAlpha', 0.1);
end 