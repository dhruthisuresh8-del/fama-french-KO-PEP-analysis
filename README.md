# Fama-French & Market Efficiency Analysis: Coca-Cola (KO) & PepsiCo (PEP) 📊

**RMIT University | Master of Finance | Financial Econometrics (ECON-1195)**  
**Submitted:** August 2025

---

## Overview

This project investigates the **daily stock return characteristics and market efficiency** of Coca-Cola (KO) and PepsiCo (PEP) using **252 trading days of 2024 data**. The analysis applies three complementary frameworks — descriptive statistics, Efficient Market Hypothesis (EMH) testing, and the Fama–French Three-Factor Model — to contrast the risk profiles, return dynamics, and systematic factor exposures of two of the world's largest consumer staples companies.

> Together, KO and PEP hold over **30% of global non-alcoholic beverage market share** (USD 1.35 trillion industry, 2023).

---

## Research Objectives

- Compute and compare **descriptive return statistics** for KO and PEP across 2024
- Test **weak-form market efficiency** using Ljung-Box and Chow-Denning Variance Ratio tests
- Apply the **Fama–French Three-Factor Model** to quantify systematic risk exposures
- Identify whether either stock generated **abnormal returns (alpha)** beyond factor model predictions
- Draw **portfolio and investment implications** from factor sensitivities

---

## Tools & Libraries

| Tool | Purpose |
|------|---------|
| **R / RStudio** | All statistical modelling and diagnostics |
| `PerformanceAnalytics` | Return calculation and descriptive statistics |
| `vrtest` | Chow-Denning Variance Ratio Test |
| `stats` | Ljung-Box autocorrelation test |
| `lm()` | Fama-French OLS regression |
| `ggplot2` | Data visualisation |
| **Fama-French Data Library** | Daily SMB, HML, MktRF factor data (Ken French, Dartmouth) |
| **Investing.com** | Daily adjusted closing price data (2024) |

---

## Methodology

### Stage 1 — Descriptive Statistics

Daily adjusted closing prices transformed into **continuously compounded logarithmic returns**.  
Key metrics computed for both stocks across 252 trading days:

| Measure | KO | PEP |
|---------|-----|-----|
| **Mean** | 0.016 | -0.051 |
| **Median** | 0.048 | -0.029 |
| **Std. Dev.** | 0.80 | 1.04 |
| **Min / Max** | -2.59 / 2.47 | -4.03 / 3.93 |
| **Skewness** | 0.04 | -0.03 |
| **Excess Kurtosis** | 0.66 | 2.27 |

**Key insight:** PEP's excess kurtosis of **2.27** confirms fat-tailed return behavior and a higher probability of sudden large shocks compared to KO's more stable distribution.

---

### Stage 2 — EMH Testing (Weak-Form Efficiency)

Two formal tests applied to assess whether past returns predict future returns:

**1. Ljung-Box Autocorrelation Test (lag = 10)**
- H₀: Returns are independent of past values (random walk)
- H₁: Returns exhibit predictable autocorrelation

**2. Chow-Denning Variance Ratio Test (k = 2, 5, 10 days)**
- H₀: Variance scales proportionally over multi-day horizons (random walk)
- H₁: At least one variance ratio departs significantly (trending or mean-reverting)

#### EMH Test Results

| Test | KO Result | PEP Result | Decision (5%) |
|------|-----------|------------|---------------|
| **Ljung-Box Q (lag=10)** | Q = 10.736, p = 0.378 | Q = 6.237, p = 0.795 | ✅ Fail to reject H₀ |
| **Chow-Denning (k=2,5,10)** | CD1 = 1.095, CD2 = 1.070 | CD1 = 1.037, CD2 = 0.906 | ✅ Fail to reject H₀ |

**Key insight:** Both stocks confirmed **weak-form market efficiency** — past return data cannot be used to generate systematic excess profits.

---

### Stage 3 — Fama-French Three-Factor Model

Model specification:

$$R_{i,t} - R_{f,t} = \alpha_i + \beta_M(R_{M,t} - R_{f,t}) + \beta_S SMB_t + \beta_H HML_t + \epsilon_t$$

Where:
- $\alpha_i$ = Abnormal return (intercept)
- $\beta_M$ = Market factor sensitivity
- $\beta_S$ = Size factor (SMB: Small Minus Big)
- $\beta_H$ = Value factor (HML: High Minus Low)

Applied to 2024 daily returns merged with the **Ken French Data Library** factor dataset.

#### KO Regression Output
$$R_{KO} - R_f = -0.0064 + 0.0746 \cdot MktRF - 0.0234 \cdot SMB + 0.1345 \cdot HML + \epsilon$$

#### PEP Regression Output
$$R_{PEP} - R_f = -0.0759 + 0.0992 \cdot MktRF - 0.1151 \cdot SMB + 0.2079 \cdot HML + \epsilon$$

#### Fama-French Regression Results

| Variable | KO Coeff. (p-value) | PEP Coeff. (p-value) | Interpretation |
|----------|--------------------|--------------------|----------------|
| **Intercept (α)** | -0.006 (0.90) | -0.076 (0.25) | No abnormal returns for either stock |
| **Market β** | 0.075 (0.29) | 0.099 (0.27) | Low market sensitivity — defensive staples |
| **SMB (size)** | -0.023 (0.75) | -0.115 (0.22) | Large-cap behavior, insignificant |
| **HML (value)** | 0.134 (0.07) | **0.208 (0.03)** | PEP shows significant value tilt at 5% |
| **R²** | 0.015 | 0.021 | Low — typical of daily frequency data |

---

## Key Findings

| | Coca-Cola (KO) | PepsiCo (PEP) |
|--|----------------|---------------|
| **Return Profile** | Stable, mean 0.016%/day | Negative drift, mean -0.051%/day |
| **Volatility** | Lower (std. dev. 0.80) | Higher (std. dev. 1.04) |
| **Fat Tails** | Mild (kurtosis 0.66) | Significant (kurtosis 2.27) |
| **Market Efficiency** | ✅ Weak-form confirmed | ✅ Weak-form confirmed |
| **Abnormal Returns** | None (α insignificant) | None (α insignificant) |
| **Value Exposure (HML)** | Marginal (p = 0.07) | Significant (p = 0.03) |
| **Investment Role** | Defensive core holding | Value-tilted tactical play |

---

## Investment Implications

- 🛡️ **Conservative investors** → **Coca-Cola (KO)**: low volatility, stable returns, low market beta
- 📊 **Value-oriented investors** → **PepsiCo (PEP)**: significant HML loading, suits value-tilted strategies
- ⚠️ **Risk note**: Neither stock offered abnormal returns in 2024 — consistent with efficient markets
- 🔬 **Future research** → Monthly frequency analysis or multi-factor extensions (Carhart momentum) for greater explanatory power

---

## Repository Structure

```
├── FE_Assignment1.pdf              # Full research report
├── KO_PEP_FF3_Analysis.R           # Main R analysis script
└── README.md                       # Project documentation
```

---

## References

- Fama, E.F. & French, K.R. (1993). Common risk factors in the returns on stocks and bonds. *Journal of Financial Economics*, 33(1), pp.3–56.
- Fama, E.F. (1970). Efficient capital markets: A review of theory and empirical work. *The Journal of Finance*, 25(2), pp.383–417.
- French, K.R. (2024). Data Library – Fama/French Factors. Dartmouth College.
- Malkiel, B.G. (2019). *A Random Walk Down Wall Street*. 12th ed. W.W. Norton & Company.

---

*RMIT University — Master of Finance | Financial Econometrics ECON-1195*
