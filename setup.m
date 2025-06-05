% Setup do Repositório GNU Octave
% Descrição: Configura paths e ambiente de trabalho
% Autor: Repositório Octave
% Data: Janeiro 2025
% Versão: 1.0

clear all;
close all;
clc;

fprintf('=== CONFIGURAÇÃO DO AMBIENTE OCTAVE ===\n');

% Obter diretório atual (raiz do repositório)
repo_root = pwd;
fprintf('Diretório do repositório: %s\n', repo_root);

% Adicionar subdiretórios ao path
subdirs = {'utils', 'metrologia', 'estatistica', 'sinais', 'controle', 'templates'};

fprintf('\nAdicionando diretórios ao path:\n');
for i = 1:length(subdirs)
    subdir_path = fullfile(repo_root, subdirs{i});
    if exist(subdir_path, 'dir')
        addpath(subdir_path);
        fprintf('  ✓ %s\n', subdirs{i});
    else
        fprintf('  ⚠ %s (não encontrado)\n', subdirs{i});
    end
end

% Adicionar subdiretórios recursivamente se necessário
addpath(genpath(fullfile(repo_root, 'utils')));

% Configurações do Octave
fprintf('\nConfigurações aplicadas:\n');

% Formato de saída para números
format long g;
fprintf('  ✓ Formato numérico: long g\n');

% Configurações de plot
set(0, 'DefaultFigureColor', 'white');
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultTextFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.5);
fprintf('  ✓ Configurações de plot padrão\n');

% Verificar pacotes instalados
fprintf('\nVerificando pacotes:\n');
required_packages = {'statistics', 'signal', 'control'};
for i = 1:length(required_packages)
    pkg_name = required_packages{i};
    try
        pkg('load', pkg_name);
        fprintf('  ✓ %s - carregado\n', pkg_name);
    catch
        fprintf('  ⚠ %s - não instalado ou erro ao carregar\n', pkg_name);
    end
end

% Criar diretórios se não existirem
dirs_to_create = {'data/exemplos', 'data/medicoes', 'data/resultados', ...
                  'metrologia/incertezas', 'estatistica/regressao', ...
                  'sinais/wavelets', 'controle/controladores'};

fprintf('\nCriando estrutura de diretórios:\n');
for i = 1:length(dirs_to_create)
    dir_path = fullfile(repo_root, dirs_to_create{i});
    if ~exist(dir_path, 'dir')
        mkdir(dir_path);
        fprintf('  ✓ Criado: %s\n', dirs_to_create{i});
    else
        fprintf('  → Existe: %s\n', dirs_to_create{i});
    end
end

% Função para salvar workspace
fprintf('\nFunções utilitárias carregadas:\n');
fprintf('  - salvar_workspace(): Salva variáveis importantes\n');
fprintf('  - limpar_tudo(): Limpa workspace e figuras\n');
fprintf('  - info_sistema(): Mostra informações do sistema\n');

% Mostrar informações do sistema
fprintf('\n=== INFORMAÇÕES DO SISTEMA ===\n');
fprintf('Versão do Octave: %s\n', version);
fprintf('Diretório de trabalho: %s\n', pwd);
fprintf('Memória disponível: %.2f MB\n', memory().Total / 1024 / 1024);

fprintf('\n🎉 Ambiente configurado com sucesso!\n');
fprintf('Digite "help nome_funcao" para ajuda sobre funções específicas.\n\n');

% Salvar configuração
save('config_workspace.mat', 'repo_root', 'subdirs');

% Definir funções utilitárias globais
function salvar_workspace()
    save('workspace_backup.mat');
    fprintf('Workspace salvo em workspace_backup.mat\n');
end

function limpar_tudo()
    clear all;
    close all;
    clc;
    fprintf('Workspace e figuras limpos!\n');
end

function info_sistema()
    fprintf('=== INFORMAÇÕES DO SISTEMA ===\n');
    fprintf('Octave: %s\n', version);
    fprintf('SO: %s\n', computer);
    fprintf('Data/Hora: %s\n', datestr(now));
    fprintf('Diretório: %s\n', pwd);
    mem_info = memory();
    fprintf('Memória: %.2f MB usados / %.2f MB total\n', ...
            mem_info.MemUsedMATLAB/1024/1024, mem_info.Total/1024/1024);
end 