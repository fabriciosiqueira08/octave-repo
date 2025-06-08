# 📐 Formulário de Metrologia e Análise Estatística

## Repositório de Fórmulas para Análises Metrológicas

**Versão:** 1.0  
**Data:** Julho 2025  
**Contexto:** Análises de instrumentos de medição (voltímetros e balanças digitais)

---

## 🎯 **1. ANÁLISE DE ERROS**

### 1.1 Erro Absoluto
```
E = I - V
```
**Onde:**
- `E` = Erro absoluto
- `I` = Indicação do instrumento
- `V` = Valor verdadeiro (referência)

### 1.2 Erro Relativo
```
Er = (I - V)/V × 100%
```
**Onde:**
- `Er` = Erro relativo percentual

### 1.3 Erro Aleatório
```
εᵢ = Iᵢ - X̄
```
**Onde:**
- `εᵢ` = Erro aleatório da medição i
- `Iᵢ` = Indicação individual i
- `X̄` = Média aritmética das indicações

---

## 📊 **2. ESTATÍSTICA DESCRITIVA**

### 2.1 Média Aritmética
```
X̄ = (1/n) × Σ(xᵢ)
```

### 2.2 Desvio Padrão Amostral
```
s = √[(1/(n-1)) × Σ(xᵢ - X̄)²]
```

### 2.3 Variância Amostral
```
s² = (1/(n-1)) × Σ(xᵢ - X̄)²
```

### 2.4 Erro Padrão da Média
```
σ_X̄ = s/√n
```

**Onde:**
- `n` = Número de medições
- `xᵢ` = Medição individual i
- `X̄` = Média aritmética

---

## 🎲 **3. DISTRIBUIÇÃO NORMAL**

### 3.1 Função Densidade de Probabilidade
```
f(x) = (1/(σ√2π)) × exp(-½((x-μ)/σ)²)
```

### 3.2 Normalização para Histograma
```
y = (n/(s√2π)) × exp(-½((x-X̄)/s)²)
```

**Onde:**
- `μ` = Média populacional
- `σ` = Desvio padrão populacional
- `n` = Tamanho da amostra

---

## 🔬 **4. ANÁLISE DE TENDÊNCIA (BIAS)**

### 4.1 Tendência (Erro Sistemático)
```
B = X̄ - V₀
```

### 4.2 Correção
```
C = -B = V₀ - X̄
```

### 4.3 Valor Corrigido
```
Vcorr = I + C
```

### 4.4 Teste de Significância da Tendência
```
t = |B|/σ_X̄
```
**Critério:** Se `t ≥ 2`, a tendência é significativa

**Onde:**
- `B` = Tendência (bias)
- `V₀` = Valor verdadeiro
- `C` = Correção
- `Vcorr` = Valor corrigido

---

## 📏 **5. REPETITIVIDADE**

### 5.1 Repetitividade com t de Student
```
R = t₀.₀₅,ν × s
```

### 5.2 Graus de Liberdade
```
ν = n - 1
```

### 5.3 Aproximação para n ≥ 30
```
R ≈ 2s  (k = 2)
```

**Onde:**
- `R` = Repetitividade
- `t₀.₀₅,ν` = Valor crítico t de Student (95% confiança)
- `ν` = Graus de liberdade
- `s` = Desvio padrão

---

## 🎯 **6. INCERTEZAS DE MEDIÇÃO**

### 6.1 Incerteza Tipo A
```
u_A = s/√n
```

### 6.2 Incerteza Tipo B (distribuição retangular)
```
u_B = a/√3
```

### 6.3 Incerteza Combinada
```
u_c = √(u_A² + u_B²)
```

### 6.4 Incerteza Expandida
```
U = k × u_c
```
**Típico:** `k = 2` para ~95% de confiança

**Onde:**
- `u_A` = Incerteza tipo A (estatística)
- `u_B` = Incerteza tipo B (não-estatística)
- `a` = Semi-amplitude da distribuição
- `k` = Fator de cobertura

---

## 📈 **7. AJUSTE DE CURVAS**

### 7.1 Regressão Linear (y = ax + b)
```
a = [n×Σ(xy) - Σ(x)×Σ(y)] / [n×Σ(x²) - (Σ(x))²]
b = [Σ(y) - a×Σ(x)] / n
```

### 7.2 Coeficiente de Determinação
```
R² = 1 - [Σ(yᵢ - ŷᵢ)²] / [Σ(yᵢ - ȳ)²]
```

**Onde:**
- `a` = Coeficiente angular
- `b` = Coeficiente linear
- `ŷᵢ` = Valor predito
- `ȳ` = Média de y

---

## 🧪 **8. VALIDAÇÃO ESTATÍSTICA**

### 8.1 Critério de Repetitividade
```
Percentual dentro de ±R ≥ 95%
```

### 8.2 Assimetria (Skewness)
```
S = [n/(n-1)(n-2)] × Σ[(xᵢ-X̄)/s]³
```

### 8.3 Curtose (Kurtosis)
```
K = [n(n+1)/((n-1)(n-2)(n-3))] × Σ[(xᵢ-X̄)/s]⁴ - 3(n-1)²/((n-2)(n-3))
```

---

## 📋 **9. VALORES CRÍTICOS t DE STUDENT**

### 9.1 Para α = 0.05 (95% confiança, bilateral)

| Graus de Liberdade | t crítico |
|-------------------|-----------|
| 10                | 2.228     |
| 20                | 2.086     |
| 30                | 2.042     |
| 50                | 2.009     |
| 99                | 1.984     |
| ∞                 | 1.960     |

---

## 🔍 **10. CRITÉRIOS DE AVALIAÇÃO**

### 10.1 Normalidade
- **Assimetria:** |S| < 0.5
- **Curtose:** |K| < 1.0
- **Teste visual:** Formato campaniforme

### 10.2 Capacidade de Medição
- **Repetitividade:** R = t × s
- **Reprodutibilidade:** Análise interlaboratorial
- **Limite de detecção:** 3s
- **Limite de quantificação:** 10s

### 10.3 Conformidade
- **Erro máximo:** |E| + U ≤ Limite especificado
- **Tendência significativa:** |B|/σ_X̄ ≥ 2

---

## 📚 **11. REFERÊNCIAS NORMATIVAS**

### 11.1 Normas Internacionais
- **ISO/IEC Guide 98-3** (GUM) - Incerteza de Medição
- **ISO/IEC Guide 99** (VIM) - Vocabulário Internacional de Metrologia
- **ISO 5725** - Exatidão e Precisão
- **ABNT NBR ISO/IEC 17025** - Competência de Laboratórios

### 11.2 Documentos INMETRO
- **DOQ-CGCRE-008** - Orientações sobre Validação de Métodos
- **NIT-DICLA-021** - Expressão da Incerteza de Medição

---

## 💡 **12. NOMENCLATURA E SÍMBOLOS**

| Símbolo | Descrição | Unidade |
|---------|-----------|---------|
| `E, ε` | Erro | [unidade da grandeza] |
| `I` | Indicação | [unidade da grandeza] |
| `V, V₀` | Valor verdadeiro | [unidade da grandeza] |
| `X̄` | Média aritmética | [unidade da grandeza] |
| `s` | Desvio padrão | [unidade da grandeza] |
| `u` | Incerteza padrão | [unidade da grandeza] |
| `U` | Incerteza expandida | [unidade da grandeza] |
| `R` | Repetitividade | [unidade da grandeza] |
| `B` | Tendência (bias) | [unidade da grandeza] |
| `C` | Correção | [unidade da grandeza] |
| `k` | Fator de cobertura | [adimensional] |
| `t` | Valor crítico t de Student | [adimensional] |
| `n` | Número de medições | [adimensional] |
| `ν` | Graus de liberdade | [adimensional] |

---

## 🎯 **13. APLICAÇÕES PRÁTICAS**

### 13.1 Calibração de Voltímetros
- Curva de erros: `E = a×I + b`
- Interpolação para valores não medidos
- Incerteza expandida para 12V

### 13.2 Análise de Balanças Digitais
- Histograma de frequências
- Comparação com distribuição normal
- Cálculo de repetitividade
- Verificação de critérios metrológicos

### 13.3 Relatórios de Ensaio
- Resultado: `(X̄ ± U) unidade`
- Fator de cobertura k e nível de confiança
- Identificação de fontes de incerteza

---

**© 2025 - Formulário de Metrologia**  
*Desenvolvido para análises científicas em GNU Octave/MATLAB* 