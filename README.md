# Return Characteristics & Market Efficiency: Coca-Cola (KO) & PepsiCo (PEP) 📊

> **RMIT University | Master of Finance | Financial Econometrics (ECON-1195)**
> Submitted: August 2025

---

## 🔍 Overview

This project investigates the **daily stock return characteristics and market efficiency** of two of the world's largest consumer staples companies — Coca-Cola (KO) and PepsiCo (PEP) — using **252 trading days of 2024 data**.

> Together, KO and PEP hold over **30% of the global non-alcoholic beverage market** (USD 1.35 trillion industry, 2023 — projected USD 1.62 trillion by 2030).

The analysis applies three complementary frameworks:

| Framework | Purpose |
|-----------|---------|
| 📐 Descriptive Statistics | Quantify return behavior, volatility, and distributional shape |
| 🔬 EMH Testing | Test whether past returns predict future returns (random walk) |
| 📊 Fama-French Three-Factor Model | Decompose systematic risk into market, size, and value factors |

---

## 📁 Repository Structure

```
├── FE_Assignment1.pdf              # Full research report (10 pages)
├── KO_PEP_FF3_Analysis.R           # Main R analysis script
├── data/
│   ├── KO_prices_2024.csv          # Coca-Cola daily adjusted closing prices
│   ├── PEP_prices_2024.csv         # PepsiCo daily adjusted closing prices
│   └── FF_factors_daily_2024.csv   # Fama-French daily factor data
└── README.md                       # Project documentation
```

---

## 🛠️ Tools & Libraries

| Tool | Purpose |
|------|---------|
| **R / RStudio** | All statistical modelling and diagnostics |
| `PerformanceAnalytics` | Return calculation and descriptive statistics |
| `vrtest` | Chow-Denning Variance Ratio Test |
| `stats::Box.test()` | Ljung-Box autocorrelation test |
| `lm()` | Fama-French OLS regression |
| `ggplot2` | All data visualisations |
| **Ken French Data Library** | Daily SMB, HML, MktRF factor data (Dartmouth) |
| **Investing.com** | Daily adjusted closing price data (2024) |

---

## 📐 Stage 1 — Descriptive Statistics

Daily adjusted closing prices transformed into **continuously compounded logarithmic returns**:

$$r_t = \ln\left(\frac{P_t}{P_{t-1}}\right) \times 100$$

### Return Metrics — 252 Trading Days (2024)

| Measure | KO | PEP | Interpretation |
|---------|-----|-----|----------------|
| **Mean** | +0.016% | -0.051% | KO positive drift; PEP negative trajectory |
| **Median** | +0.048% | -0.029% | KO median > mean → slight positive skew |
| **Std. Dev.** | 0.80 | 1.04 | PEP 30% more volatile than KO |
| **Min / Max** | -2.59 / +2.47 | -4.03 / +3.93 | PEP wider extreme range |
| **Skewness** | +0.04 | -0.03 | Both near-symmetric |
| **Excess Kurtosis** | 0.66 | **2.27** | PEP fat-tailed — elevated shock probability |

### Key Takeaway
- **KO**: Narrower, stable distribution → resilient defensive stock
- **PEP**: Wider distribution, excess kurtosis of 2.27 → elevated downside risk (Value-at-Risk losses deeper under stress scenarios)

---

## 🔬 Stage 2 — EMH Testing (Weak-Form Efficiency)

The **Efficient Market Hypothesis (weak form)** states that asset prices fully incorporate historical information — returns follow a random walk and cannot be predicted from past values (Fama, 1970).

Two formal tests applied:

### Test 1 — Ljung-Box Autocorrelation Test (lag = 10)
- **H₀**: Returns are independent of past values (random walk) → supports EMH
- **H₁**: Returns exhibit predictable serial autocorrelation

### Test 2 — Chow-Denning Variance Ratio Test (k = 2, 5, 10 days)
- **H₀**: Variance scales proportionally over multi-day horizons → consistent with random walk
- **H₁**: At least one variance ratio departs significantly (trending or mean-reverting behavior)

### EMH Test Results

| Test | KO Result | PEP Result | Decision (5% level) |
|------|-----------|------------|---------------------|
| **Ljung-Box Q (lag=10)** | Q = 10.736, **p = 0.378** | Q = 6.237, **p = 0.795** | ✅ Fail to reject H₀ |
| **Chow-Denning (k=2)** | CD1 = 1.095 | CD1 = 1.037 | ✅ Fail to reject H₀ |
| **Chow-Denning (k=5,10)** | CD2 = 1.070 | CD2 = 0.906 | ✅ Fail to reject H₀ |

### Key Takeaway
Both stocks confirmed **weak-form market efficiency** in 2024:
- No exploitable autocorrelation patterns at any lag horizon
- Returns neither trending nor mean-reverting over multi-day windows
- PEP's higher volatility and fat tails did **not** translate into predictable patterns

---

## 📊 Stage 3 — Fama-French Three-Factor Model

The **Fama-French Three-Factor Model** extends CAPM by adding size (SMB) and value (HML) factors (Fama & French, 1993):

$$R_{i,t} - R_{f,t} = \alpha_i + \beta_M(R_{M,t} - R_{f,t}) + \beta_S SMB_t + \beta_H HML_t + \epsilon_t$$

Where:
- $\alpha_i$ = Abnormal return (intercept) — exploitable alpha above factor expectations
- $\beta_M$ = Market factor sensitivity (systematic market risk)
- $\beta_S$ = Size factor (SMB: Small Minus Big — small-cap vs large-cap premium)
- $\beta_H$ = Value factor (HML: High Minus Low — value vs growth premium)

Applied to 2024 daily returns merged with the **Ken French Data Library** factor dataset.

### Regression Equations

**Coca-Cola (KO):**
$$R_{KO} - R_f = -0.0064 + 0.0746 \cdot MktRF - 0.0234 \cdot SMB + 0.1345 \cdot HML + \epsilon$$

**PepsiCo (PEP):**
$$R_{PEP} - R_f = -0.0759 + 0.0992 \cdot MktRF - 0.1151 \cdot SMB + 0.2079 \cdot HML + \epsilon$$

### Fama-French Regression Results

| Variable | KO Coeff. (p-value) | PEP Coeff. (p-value) | Interpretation |
|----------|--------------------|--------------------|----------------|
| **Intercept α** | -0.006 (p=0.90) | -0.076 (p=0.25) | No abnormal returns for either stock |
| **Market β** | 0.075 (p=0.29) | 0.099 (p=0.27) | Low beta — defensive consumer staples |
| **SMB (size)** | -0.023 (p=0.75) | -0.115 (p=0.22) | Large-cap behavior, both insignificant |
| **HML (value)** | 0.134 (p=0.07) | **0.208 (p=0.03)** ⭐ | PEP significant value tilt at 5% level |
| **R²** | 0.015 | 0.021 | Low — typical of daily high-frequency data |

⭐ **Notable finding**: PEP's HML loading is statistically significant at the **5% level** — confirming it behaved as a value stock in 2024, possibly reflecting market sentiment viewing its diversified snacks + beverages portfolio as undervalued.

---

## 💡 Key Findings Summary

| | Coca-Cola (KO) | PepsiCo (PEP) |
|--|----------------|---------------|
| **Return profile** | Stable, +0.016%/day | Negative drift, -0.051%/day |
| **Volatility** | Lower (std. dev. 0.80) | Higher (std. dev. 1.04) |
| **Fat tails** | Mild (kurtosis 0.66) | Significant (kurtosis 2.27) |
| **Market efficiency** | ✅ Weak-form confirmed | ✅ Weak-form confirmed |
| **Abnormal returns** | None (α insignificant) | None (α insignificant) |
| **Market sensitivity** | Low β = 0.075 | Low β = 0.099 |
| **Value exposure HML** | Marginal (p=0.07) | **Significant (p=0.03)** |
| **Investment role** | 🛡️ Defensive core holding | 📊 Value-tilted tactical play |

---

## 💼 Investment Implications

```
Portfolio Strategy
├── Conservative investors       → Coca-Cola (KO)
│   Stable returns, low beta,    Ideal defensive anchor
│   low volatility               in uncertain markets
│
└── Value-oriented investors     → PepsiCo (PEP)
    Significant HML loading,     Tactical exposure to
    broader cyclical ties        consumer staples value
```

- ⚠️ **Risk note**: Neither stock offered abnormal returns in 2024 — consistent with efficient, liquid markets where information is quickly priced in
- 📉 **Risk management**: PEP's fat-tailed distribution (kurtosis 2.27) implies deeper losses under stress — requires tighter Value-at-Risk monitoring
- 🔬 **Future research**: Monthly frequency analysis or Carhart (1997) four-factor extension (adding momentum) would likely yield greater explanatory power beyond R² of 1-2%

---

## 📚 References

- Fama, E.F. & French, K.R. (1993). Common risk factors in the returns on stocks and bonds. *Journal of Financial Economics*, 33(1), pp.3–56. https://doi.org/10.1016/0304-405X(93)90023-5
- Fama, E.F. (1970). Efficient capital markets: A review of theory and empirical work. *The Journal of Finance*, 25(2), pp.383–417. https://doi.org/10.2307/2325486
- French, K.R. (2024). Data Library – Fama/French Factors. Dartmouth College. https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html
- Malkiel, B.G. (2019). *A Random Walk Down Wall Street*. 12th ed. W.W. Norton & Company.
- Market.us (2024). Non-Alcoholic Beverage Market Share and Growth Report 2024–2030. https://market.us/report/non-alcoholic-beverage-market/
- Mordor Intelligence (2024). Non-Alcoholic Beverage Market – Growth, Trends, and Forecast (2024–2030). https://www.mordorintelligence.com/industry-reports/non-alcoholic-beverage-market

---

*RMIT University — Master of Finance | Financial Econometrics ECON-1195 | Submitted August 2025*
