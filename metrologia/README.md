# 📏 Metrologia - Análises e Calibrações

Esta pasta contém scripts e funções para análises metrológicas, calibração de
instrumentos e cálculos de incertezas.

## 📋 Arquivos Disponíveis

### Scripts Principais

- **`analise_voltimetro.m`** - Análise completa de voltímetro eletrônico

  - Curva de erros (Erro × Indicação)
  - Cálculo de incertezas expandidas
  - Interpolação para valores não medidos
  - Validação de normalidade dos dados

- **`calibracao_instrumentos.m`** - Template para calibração geral
  - Múltiplos pontos de medição
  - Ajuste de curvas de calibração
  - Análise de linearidade
  - Relatórios de calibração

### Subpasta: `incertezas/`

- **`calculo_incertezas.m`** - Funções para cálculo de incertezas
- **`propagacao_incertezas.m`** - Propagação de incertezas compostas

## 🚀 Como Usar

### Exemplo Rápido - Análise de Voltímetro

```octave
% No diretório do repositório:
run('metrologia/analise_voltimetro.m')
```

### Exemplo - Calibração Personalizada

```octave
% Seus dados de calibração
valores_referencia = [10.0, 20.0, 30.0];  % Valores verdadeiros
indicacoes = [10.05, 20.10, 29.95];       % Leituras do instrumento

% Calcular erros e incertezas
erros = indicacoes - valores_referencia;
incerteza_tipo_A = std(medicoes_repetidas);
incerteza_expandida = 2 * incerteza_tipo_A;  % k=2 para 95,45%

% Visualizar
figure();
errorbar(valores_referencia, indicacoes, incerteza_expandida, 'o-');
xlabel('Valor de Referência');
ylabel('Indicação do Instrumento');
title('Curva de Calibração');
grid on;
```

## 📊 Tipos de Análise Suportados

### 1. **Análise de Erros**

- Erro absoluto: `erro = indicação - valor_real`
- Erro relativo: `erro_rel = (indicação - valor_real) / valor_real × 100%`
- Erro sistemático vs aleatório

### 2. **Cálculo de Incertezas**

- **Tipo A**: Avaliação estatística (repetibilidade)
  ```octave
  incerteza_A = std(medicoes) / sqrt(n);
  ```
- **Tipo B**: Avaliação não-estatística (certificados, especificações)
- **Incerteza Combinada**: Combinação quadrática
- **Incerteza Expandida**: `U = k × u_c` (normalmente k = 2)

### 3. **Ajuste de Curvas**

- Ajuste linear: `polyfit(x, y, 1)`
- Ajuste polinomial de ordem superior
- Análise de resíduos
- Coeficiente de determinação (R²)

### 4. **Validação Estatística**

- Teste de normalidade
- Detecção de outliers
- Análise de tendências

## 📈 Principais Funções

### Cálculo de Incertezas

```octave
% Incerteza Tipo A (estatística)
u_A = std(medicoes) / sqrt(length(medicoes));

% Incerteza Tipo B (retangular)
u_B = amplitude / sqrt(3);

% Incerteza combinada
u_c = sqrt(u_A^2 + u_B^2);

% Incerteza expandida (95,45%)
U = 2 * u_c;
```

### Propagação de Incertezas

```octave
% Para função f(x,y) = x + y
df_dx = 1;  % Derivada parcial
df_dy = 1;
u_f = sqrt((df_dx * u_x)^2 + (df_dy * u_y)^2);

% Para função f(x,y) = x * y
u_f_rel = sqrt((u_x/x)^2 + (u_y/y)^2);
u_f = abs(f) * u_f_rel;
```

## 🎯 Casos de Uso Típicos

### 1. **Calibração de Voltímetro**

- Medições em múltiplas tensões de referência
- Análise de linearidade
- Determinação da equação de correção
- Cálculo da incerteza de medição

### 2. **Análise de Repetibilidade**

- Múltiplas medições no mesmo ponto
- Avaliação da dispersão
- Identificação de problemas de estabilidade

### 3. **Comparação entre Instrumentos**

- Análise de equivalência
- Estudos de correlação
- Avaliação de bias sistemático

### 4. **Conformidade com Especificações**

- Verificação de limites de erro
- Análise de capacidade de medição
- Relatórios de conformidade

## 📝 Padrões de Nomenclatura

- **Variáveis**:

  - `valor_real` ou `referencia` - Valores de referência
  - `indicacao` ou `leitura` - Valores indicados pelo instrumento
  - `erro` - Diferença (indicação - referência)
  - `incerteza_A`, `incerteza_B` - Incertezas tipo A e B
  - `u_c` - Incerteza combinada
  - `U` - Incerteza expandida

- **Arquivos de saída**:
  - `resultados_calibracao_[instrumento]_[data].mat`
  - `relatorio_[analise]_[data].txt`
  - `grafico_curva_erro_[instrumento].png`

## 🔗 Referências Úteis

- **GUM (Guide to Uncertainty in Measurement)** - ISO/IEC Guide 98-3
- **VIM (Vocabulário Internacional de Metrologia)** - ISO/IEC Guide 99
- **INMETRO DOQ-CGCRE-008** - Orientações sobre Validação de Métodos
- **ABNT NBR ISO/IEC 17025** - Requisitos gerais para competência de
  laboratórios

## 💡 Dicas e Boas Práticas

1. **Sempre documente**:

   - Condições ambientais
   - Instrumentos utilizados
   - Procedimentos seguidos

2. **Validação de dados**:

   - Verifique outliers antes da análise
   - Teste a normalidade quando apropriado
   - Analise tendências temporais

3. **Incertezas**:

   - Identifique todas as fontes
   - Use distribuições apropriadas (normal, retangular, triangular)
   - Documente o fator de cobertura utilizado

4. **Visualização**:
   - Sempre inclua barras de erro nos gráficos
   - Use escalas apropriadas
   - Adicione linhas de tendência quando relevante
