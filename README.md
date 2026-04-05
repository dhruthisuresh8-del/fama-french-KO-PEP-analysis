# ARIMA-GARCH Volatility Analysis of Coca-Cola & PepsiCo (2019–2024)

## Introduction
This report extends the earlier Fama-French analysis of Coca-Cola (KO) and PepsiCo 
(PEP) by focusing on the time-series properties and volatility dynamics of their 
daily stock returns from 2019 to 2024. While the previous study confirmed weak-form 
market efficiency and identified no abnormal returns, this analysis applies advanced 
econometric modelling to capture short-run dependence and conditional volatility 
patterns that simple factor regressions cannot fully explain. The analysis proceeds 
in two stages — ARIMA modelling for mean return dynamics, followed by GARCH-family 
models for volatility dynamics. Daily adjusted closing prices were obtained from 
Investing.com and transformed into continuous logarithmic percentage returns.

---

## Research Objectives
- Model the mean return dynamics of KO and PEP using the Box-Jenkins ARIMA framework
- Identify the best-fitting ARIMA specification using AIC, BIC, and Ljung-Box diagnostics
- Test for volatility clustering and ARCH effects in both return series
- Compare sGARCH(1,1), GJR-GARCH(1,1), and GARCH-M(1,1) volatility models
- Determine whether risk premiums are embedded in daily returns via ARCH-in-mean term
- Draw investment implications from the volatility and risk profiles of both stocks

---

## Tools & Methods
| Tool | Purpose |
|------|---------|
| R (RStudio) | All statistical modelling and diagnostics |
| forecast | ARIMA model estimation and selection |
| rugarch | GARCH-family model estimation |
| tseries | Stationarity and ARCH effect testing |
| PerformanceAnalytics | Return calculation and performance metrics |
| ggplot2 | Data visualisation |
| Investing.com | Daily adjusted closing price data (2019–2024) |

---

## Key Findings

### 1. Time Series & Volatility Clustering
- Both KO and PEP returns fluctuate around zero with alternating calm and 
  turbulent periods
- **Volatility clustering** is clearly visible — quiet periods are followed 
  by bursts of turbulence
- This confirms time-varying risk in both series and signals that standard 
  constant-variance models are insufficient
- ACF/PACF diagnostics revealed short-lag dependence typical of equity returns
- **KO:** ACF notable at lags 1–2, PACF exhibits early spikes → need for 
  both AR and MA terms
- **PEP:** ACF shows short-lag persistence, PACF strongest at lags 2–3

---

### 2. ARIMA Modelling — Mean Return Dynamics

Four ARIMA models were evaluated for each stock using AIC, BIC, and Ljung-Box 
tests at lags 10 and 20 (p > 0.005 required for adequacy):

#### Coca-Cola (KO) — ARIMA Results
| Model | AIC | BIC | LB p(10) | LB p(20) | Adequate? | Decision |
|---|---|---|---|---|---|---|
| ARIMA(2,0,2) | 3387.792 | 3416.679 | 0.0349 | 0.1689 | ✅ Yes | **Selected** |
| ARIMA(5,0,2) | 3391.419 | 3434.750 | 0.0369 | 0.2011 | ✅ Yes | Second-best |
| ARIMA(4,0,3) | 3391.841 | 3435.172 | 0.0137 | 0.1916 | ✅ Yes | Second-best |
| ARIMA(1,0,1) | 3397.592 | 3416.850 | 0.0026 | 0.0173 | ❌ No | Rejected |

- **ARIMA(2,0,2) selected** — lowest AIC/BIC, passed all Ljung-Box diagnostics
- ARIMA(1,0,1) rejected for residual autocorrelation at lag 10

#### PepsiCo (PEP) — ARIMA Results
| Model | AIC | BIC | LB p(10) | LB p(20) | Adequate? | Decision |
|---|---|---|---|---|---|---|
| ARIMA(5,0,2) | 3366.970 | 3410.301 | 0.0696 | 0.0886 | ✅ Yes | **Selected** |
| ARIMA(4,0,3) | 3372.722 | 3416.053 | 0.0007 | 0.0104 | ❌ No | Rejected |
| ARIMA(1,0,1) | 3378.012 | 3397.271 | 0.0037 | 0.0041 | ❌ No | Rejected |
| ARIMA(2,0,2) | 3381.731 | 3410.618 | 0.0009 | 0.0016 | ❌ No | Rejected |

- **ARIMA(5,0,2) selected** — only model passing all diagnostics, lowest AIC
- All other models rejected for failing Ljung-Box residual adequacy checks

---

### 3. GARCH Modelling — Volatility Dynamics

Three GARCH specifications were estimated for each stock, built on their 
respective ARIMA mean models:

#### Coca-Cola (KO) — GARCH Results
| Model | LogLik | AIC | BIC | LB(10) | LB(20) | ARCH LM p | Decision |
|---|---|---|---|---|---|---|---|
| sGARCH(1,1) — Norm | -1591.961 | 3.5191 | 3.5773 | 0.9773 | 1.0000 | 0.7859 | Adequate |
| GJR-GARCH(1,1) | -1604.835 | 3.5496 | 3.6130 | 0.6851 | 1.0000 | 0.8245 | Adequate |
| GARCH-M(1,1) — t | -1449.293 | 3.2103 | 3.2790 | 0.4999 | 0.9613 | 0.8872 | **Selected** |

- **GARCH-M(1,1) with Student-t selected** — lowest AIC/BIC, passed all diagnostics
- Captures fat tails and risk-return dynamics more effectively than standard GARCH

#### PepsiCo (PEP) — GARCH Results
| Model | LogLik | AIC | BIC | LB(10) | LB(20) | ARCH LM p | Decision |
|---|---|---|---|---|---|---|---|
| sGARCH(1,1) — Norm | -1554.491 | 3.4369 | 3.4950 | 0.9759 | 1.0000 | 0.9517 | Adequate |
| GJR-GARCH(1,1) | -1553.800 | 3.4375 | 3.5010 | 0.9579 | 1.0000 | 0.9438 | Adequate |
| GARCH-M(1,1) — t | -1420.172 | 3.1464 | 3.2151 | 0.8337 | 1.0000 | 0.7345 | **Selected** |

- **GARCH-M(1,1) with Student-t selected** — best fit across all criteria
- sGARCH and GJR-GARCH statistically adequate but less efficient

---

### 4. Summary of Final Models
| Company | Best ARIMA | Best GARCH | Key Insight |
|---|---|---|---|
| Coca-Cola (KO) | ARIMA(2,0,2) | GARCH-M(1,1) — Student-t | Defensive, stable, lower volatility |
| PepsiCo (PEP) | ARIMA(5,0,2) | GARCH-M(1,1) — Student-t | Higher risk, stronger risk premium sensitivity |

- Both stocks show **volatility clustering** but **limited leverage asymmetry**
- The **ARCH-in-mean term** confirms risk premiums are embedded in daily returns
- **Student-t distribution** effectively captures fat-tailed equity return behavior
- No strong evidence of **leverage effects** in either stock

---

## Conclusion
Both KO and PEP operate in efficient markets with no exploitable abnormal returns, 
consistent with the earlier Fama-French findings. The ARIMA analysis confirmed 
short-term dependence but no long-run predictability in either stock. The 
GARCH-M(1,1) with Student-t innovations provided the best fit for both companies, 
capturing volatility clustering, fat tails, and a direct risk-return trade-off.

Coca-Cola emerges as the more **defensive, stable asset** — lower volatility 
persistence and steadier return dynamics make it an ideal core holding for 
risk-averse investors. PepsiCo carries **higher volatility and stronger sensitivity 
to risk premiums**, aligning with its more cyclical exposure profile and making it 
a more tactical opportunity for value-oriented strategies within consumer staples.

---

## Recommendations
- **Conservative investors** seeking defensive exposure should prefer Coca-Cola
- **Value-oriented investors** seeking tactical opportunities may consider PepsiCo
- **Risk managers** should monitor conditional variance forecasts as clustering 
  effects imply rapid shifts in risk exposure
- **GARCH-M with Student-t** is recommended as the preferred specification for 
  ongoing volatility monitoring and portfolio stress testing
- **Future research** should extend to intraday data or macroeconomic linkages 
  for deeper forecasting insights

---

## Files in this Repository
| File | Description |
|---|---|
| FE_Assignment_2_s4103956.pdf | Full research report |

---

**Institution:** RMIT University — Master of Finance
**Course:** Financial Econometrics (ECON1195)
**Submitted:** September 2025
