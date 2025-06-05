# Repositório GNU Octave - Análises e Projetos

Este repositório contém scripts, funções e projetos desenvolvidos no GNU Octave
para análises diversas.

## 📁 Estrutura do Repositório

```
octave-projects/
├── README.md                     # Este arquivo
├── .octaverc                     # Configurações globais do Octave
├── setup.m                       # Script de inicialização
│
├── 📁 metrologia/               # Análises metrológicas
│   ├── README.md
│   ├── analise_voltimetro.m
│   ├── calibracao_instrumentos.m
│   └── incertezas/
│       ├── calculo_incertezas.m
│       └── propagacao_incertezas.m
│
├── 📁 estatistica/              # Análises estatísticas
│   ├── README.md
│   ├── analise_descritiva.m
│   ├── testes_hipotese.m
│   └── regressao/
│       ├── regressao_linear.m
│       └── regressao_multipla.m
│
├── 📁 sinais/                   # Processamento de sinais
│   ├── README.md
│   ├── filtros.m
│   ├── fft_analise.m
│   └── wavelets/
│
├── 📁 controle/                 # Sistemas de controle
│   ├── README.md
│   ├── resposta_frequencia.m
│   ├── lugar_raizes.m
│   └── controladores/
│
├── 📁 utils/                    # Funções utilitárias
│   ├── README.md
│   ├── plot_utils.m
│   ├── file_utils.m
│   ├── math_utils.m
│   └── validation_utils.m
│
├── 📁 data/                     # Dados para análises
│   ├── README.md
│   ├── exemplos/
│   ├── medicoes/
│   └── resultados/
│
├── 📁 templates/                # Templates para novos projetos
│   ├── README.md
│   ├── template_analise.m
│   ├── template_funcao.m
│   └── template_classe.m
│
└── 📁 docs/                     # Documentação
    ├── README.md
    ├── guia_estilo.md
    ├── exemplos_uso.md
    └── referencias.md
```

## 🚀 Como Usar

### Inicialização

```octave
% No GNU Octave, execute:
run('setup.m')
```

### Estrutura de Arquivos

- **Scripts principais** (`.m`): Análises completas executáveis
- **Funções** (`/utils/`): Funções reutilizáveis
- **Dados** (`/data/`): Datasets e resultados
- **Templates** (`/templates/`): Modelos para novos projetos

### Convenções de Nomenclatura

- **Scripts**: `nome_descritivo.m` (snake_case)
- **Funções**: `nomeFuncao.m` (camelCase)
- **Constantes**: `NOME_CONSTANTE` (UPPER_CASE)
- **Variáveis**: `nomeVariavel` (camelCase)

## 📋 Padrões de Código

### Cabeçalho Padrão

```octave
% Título do Script
% Descrição: Breve descrição do que faz
% Autor: Seu Nome
% Data: DD/MM/YYYY
% Versão: 1.0
```

### Estrutura de Função

```octave
function [saida1, saida2] = nomeFuncao(entrada1, entrada2, opcoes)
    % NOMEFUNCAO - Descrição breve da função
    %
    % Sintaxe:
    %   [saida1, saida2] = nomeFuncao(entrada1, entrada2)
    %   [saida1, saida2] = nomeFuncao(entrada1, entrada2, opcoes)
    %
    % Exemplos:
    %   resultado = nomeFuncao(10, 20);
    %
    % Veja também: funcoesRelacionadas

    % Validação de entrada
    % Código principal
    % Formatação de saída
end
```

## 📊 Projetos Incluídos

- **Análise Metrológica**: Curvas de erro, calibração de instrumentos
- **Estatística Descritiva**: Análises exploratórias de dados
- **Processamento de Sinais**: Filtros, FFT, análise espectral
- **Sistemas de Controle**: Resposta em frequência, controladores

## 🔧 Dependências

- GNU Octave 6.0+
- Pacotes recomendados:
  - `statistics`
  - `signal`
  - `control`
  - `symbolic` (opcional)

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para detalhes.
