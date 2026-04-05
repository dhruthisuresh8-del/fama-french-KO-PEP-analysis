# Return Characteristics and Market Efficiency of Coca-Cola and PepsiCo: Evidence from 2024

**Course:** Financial Econometrics (ECON1195) | Master of Finance | RMIT University
**Award:** Distinction

## Overview
This research investigates the daily stock returns of Coca-Cola (KO) and PepsiCo (PEP) 
throughout 2024 using three econometric frameworks: descriptive statistics, Efficient Market 
Hypothesis testing, and the Fama-French Three-Factor Model.

## Key Findings

**Descriptive Statistics**
- Coca-Cola delivered steadier positive returns (mean: +0.016% daily) with lower volatility (SD: 0.80)
- PepsiCo showed a negative return trajectory (mean: -0.051% daily) with higher volatility (SD: 1.04)
- PepsiCo displayed fat-tailed characteristics (excess kurtosis: 2.27) indicating higher shock risk

**Efficient Market Hypothesis**
- Both stocks passed the Ljung-Box test (KO: p=0.378, PEP: p=0.795) — no autocorrelation
- Chow-Denning Variance Ratio Test confirmed random walk behavior for both stocks
- Both KO and PEP are consistent with weak-form market efficiency

**Fama-French Three-Factor Model**
- Neither stock produced abnormal returns (alpha insignificant for both)
- Both exhibited low market betas (KO: 0.075, PEP: 0.099) — typical of defensive consumer staples
- PepsiCo showed significant value factor exposure (HML: 0.208, p=0.03)
- Coca-Cola showed only marginal value tilt (HML: 0.134, p=0.07)

## Tools & Methods
- **Language:** R (RStudio)
- **Packages:** quantmod, tseries, vrtest, lmtest, moments, PerformanceAnalytics
- **Data Sources:** Yahoo Finance, Ken French Data Library

## Conclusion
Coca-Cola acts as a defensive anchor stock — stable, low-volatility, and low market sensitivity. 
PepsiCo functions as a higher-risk, value-tilted tactical play. Both operate in highly efficient 
markets where past returns cannot predict future performance.
