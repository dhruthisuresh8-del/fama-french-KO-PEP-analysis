# Return Characteristics and Market Efficiency of Coca-Cola and PepsiCo: Evidence from 2024

## Introduction
The global non-alcoholic beverage industry, valued at over USD 1.35 trillion in 2023, is 
dominated by two giants: Coca-Cola (KO) and PepsiCo (PEP), together holding over 30% 
of global market share. This research investigates their daily stock returns throughout 2024 
using three econometric frameworks to evaluate market efficiency, systematic risk, and 
return characteristics.

---

## Research Objectives
- Compare return characteristics of KO and PEP using descriptive statistics
- Test whether both stocks follow the Efficient Market Hypothesis (random walk)
- Apply the Fama-French Three-Factor Model to measure systematic risk exposures
- Identify whether either company generated abnormal returns in 2024

---

## Tools & Methods
| Tool | Purpose |
|------|---------|
| R (RStudio) | All statistical analysis and modelling |
| quantmod | Stock data download from Yahoo Finance |
| tseries | ADF and stationarity tests |
| vrtest | Chow-Denning Variance Ratio Test |
| lmtest + sandwich | FF model with robust standard errors |
| moments | Skewness and kurtosis calculation |
| ggplot2 | Data visualisation |
| Ken French Data Library | Daily Fama-French factor data |

---

## Key Findings

### 1. Descriptive Statistics
| Measure | KO | PEP |
|---|---|---|
| Mean | 0.016% | -0.051% |
| Median | 0.048% | -0.029% |
| Std. Dev. | 0.80 | 1.04 |
| Min / Max | -2.59 / 2.47 | -4.03 / 3.93 |
| Skewness | 0.04 | -0.03 |
| Excess Kurtosis | 0.66 | 2.27 |

- Coca-Cola delivered steadier, positive daily returns with lower volatility
- PepsiCo showed a negative return trajectory and fat-tailed distribution, indicating higher shock risk

### 2. Efficient Market Hypothesis Tests
| Test | KO | PEP | Decision |
|---|---|---|---|
| Ljung-Box (lag=10) | Q=10.736, p=0.378 | Q=6.237, p=0.795 | Fail to reject H₀ |
| Chow-Denning VR Test | CD1=1.095, CD2=1.070 | CD1=1.037, CD2=0.906 | Fail to reject H₀ |

- Both stocks are consistent with **weak-form market efficiency**
- Past returns cannot be used to predict future performance

### 3. Fama-French Three-Factor Model
| Variable | KO | PEP |
|---|---|---|
| Alpha (α) | -0.006 (p=0.90) | -0.076 (p=0.25) |
| Market β | 0.075 (p=0.29) | 0.099 (p=0.27) |
| SMB (size) | -0.023 (p=0.75) | -0.115 (p=0.22) |
| HML (value) | 0.134 (p=0.07) | 0.208 (p=0.03) ✓ |
| R² | 0.015 | 0.021 |

- Neither stock produced **abnormal returns**
- Both are **low-beta defensive consumer staples**
- PepsiCo showed **statistically significant value factor exposure** (HML p=0.03)

---

## Conclusion
Coca-Cola acts as a **defensive anchor stock** — stable, low-volatility, and low market 
sensitivity. PepsiCo functions as a **higher-risk, value-tilted tactical play**. Both operate 
in highly efficient markets where past returns cannot predict future performance.

---

## Files in this Repository
| File | Description |
|---|---|
| analysis.R | Full R code for all analysis |
| FE_Assignment1.pdf | Full research report |

---

## Award
Achieved a **Distinction** for research quality.

**Institution:** RMIT University — Master of Finance
**Course:** Financial Econometrics (ECON1195)
