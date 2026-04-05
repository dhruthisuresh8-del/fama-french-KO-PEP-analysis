# ============================================================
# Quantitative Financial Analysis & Econometric Modeling
# Coca-Cola (KO) vs PepsiCo (PEP) | Jan 2024 - Dec 2024
# RMIT University - Financial Econometrics ECON1195
# Dhruthi Suresh | S4103956
# ============================================================

# ---- INSTALL & LOAD PACKAGES ----
install.packages(c("quantmod", "tseries", "PerformanceAnalytics",
                   "moments", "lmtest", "sandwich", "ggplot2",
                   "vrtest", "xts", "zoo"))

library(quantmod)
library(tseries)
library(PerformanceAnalytics)
library(moments)
library(lmtest)
library(sandwich)
library(ggplot2)
library(vrtest)
library(xts)
library(zoo)

# ============================================================
# 1. DATA COLLECTION
# ============================================================

getSymbols("KO",  from = "2024-01-01", to = "2024-12-31", src = "yahoo")
getSymbols("PEP", from = "2024-01-01", to = "2024-12-31", src = "yahoo")

# Daily percentage returns (to match your % per day histograms)
KO_returns  <- na.omit(dailyReturn(Cl(KO),  type = "log")) * 100
PEP_returns <- na.omit(dailyReturn(Cl(PEP), type = "log")) * 100

colnames(KO_returns)  <- "KO"
colnames(PEP_returns) <- "PEP"

returns <- merge(KO_returns, PEP_returns)

# ============================================================
# 2. DESCRIPTIVE STATISTICS
# Matches Table 1 in your report
# KO:  Mean=0.016, Median=0.048, SD=0.80, Min=-2.59, Max=2.47
#      Skewness=0.04, Excess Kurtosis=0.66
# PEP: Mean=-0.051, Median=-0.029, SD=1.04, Min=-4.03, Max=3.93
#      Skewness=-0.03, Excess Kurtosis=2.27
# ============================================================

desc_stats <- function(x) {
  c(
    Mean           = round(mean(x), 3),
    Median         = round(median(x), 3),
    Std_Dev        = round(sd(x), 3),
    Min            = round(min(x), 3),
    Max            = round(max(x), 3),
    Skewness       = round(skewness(x), 3),
    Excess_Kurtosis = round(kurtosis(x) - 3, 3)  # excess kurtosis
  )
}

stats_table <- data.frame(
  KO  = desc_stats(as.numeric(returns$KO)),
  PEP = desc_stats(as.numeric(returns$PEP))
)

print(stats_table)

# ---- Figure 1: Histograms (matching your report) ----
par(mfrow = c(1, 2))

hist(as.numeric(returns$KO),
     breaks = 30, col = "grey40",
     main = "KO Return Histogram",
     xlab = "% per day", ylab = "Count")

hist(as.numeric(returns$PEP),
     breaks = 30, col = "grey40",
     main = "PEP Return Histogram",
     xlab = "% per day", ylab = "Count")

# ============================================================
# 3. EFFICIENT MARKET HYPOTHESIS TESTS
# Matches Table 2 in your report
# Ljung-Box: KO Q=10.736 p=0.378 | PEP Q=6.237 p=0.795
# Chow-Denning: KO CD1=1.095 CD2=1.070 | PEP CD1=1.037 CD2=0.906
# ============================================================

# ---- Ljung-Box Test ----
cat("\n--- Ljung-Box Test (lag = 10) ---\n")
lb_KO  <- Box.test(returns$KO,  lag = 10, type = "Ljung-Box")
lb_PEP <- Box.test(returns$PEP, lag = 10, type = "Ljung-Box")
print(lb_KO)
print(lb_PEP)

# ---- Chow-Denning Variance Ratio Test ----
cat("\n--- Chow-Denning Variance Ratio Test ---\n")
cd_KO  <- Auto.VR(as.numeric(returns$KO))
cd_PEP <- Auto.VR(as.numeric(returns$PEP))
print(cd_KO)
print(cd_PEP)

# ---- Figure 2: Correlograms ----
par(mfrow = c(2, 2))
acf(as.numeric(returns$KO),  main = "ACF - KO Daily Returns",  lag.max = 25)
pacf(as.numeric(returns$KO), main = "PACF - KO Daily Returns", lag.max = 25)
acf(as.numeric(returns$PEP),  main = "ACF - PEP Daily Returns",  lag.max = 25)
pacf(as.numeric(returns$PEP), main = "PACF - PEP Daily Returns", lag.max = 25)

# ============================================================
# 4. FAMA-FRENCH THREE-FACTOR MODEL
# Matches Table 3 and equations in your report
# KO:  alpha=-0.006(p=0.90), MktRF=0.075(p=0.29),
#      SMB=-0.023(p=0.75), HML=0.134(p=0.07), R2=0.015
# PEP: alpha=-0.076(p=0.25), MktRF=0.099(p=0.27),
#      SMB=-0.115(p=0.22), HML=0.208(p=0.03), R2=0.021
# ============================================================

# Load FF Daily Factors CSV (from Ken French's Data Library)
# Place FF_Daily-1.csv in your working directory first
ff_data <- read.csv("FF_Daily-1.csv", header = TRUE)

head(ff_data)

# Format date
ff_data$Date <- as.Date(as.character(ff_data$Date), format = "%Y%m%d")

# Filter 2024
ff_2024 <- ff_data[ff_data$Date >= "2024-01-01" & ff_data$Date <= "2024-12-31", ]

# Convert from % to decimals
ff_2024$Mkt.RF <- ff_2024$Mkt.RF / 100
ff_2024$SMB    <- ff_2024$SMB    / 100
ff_2024$HML    <- ff_2024$HML    / 100
ff_2024$RF     <- ff_2024$RF     / 100

# Convert returns back to decimals for FF model
KO_ret_dec  <- na.omit(dailyReturn(Cl(KO),  type = "log"))
PEP_ret_dec <- na.omit(dailyReturn(Cl(PEP), type = "log"))

returns_df <- data.frame(
  Date = index(KO_ret_dec),
  KO   = as.numeric(KO_ret_dec),
  PEP  = as.numeric(PEP_ret_dec)
)

merged_data <- merge(returns_df, ff_2024, by = "Date")

# Excess returns
merged_data$KO_excess  <- merged_data$KO  - merged_data$RF
merged_data$PEP_excess <- merged_data$PEP - merged_data$RF

# ---- FF Model: Coca-Cola ----
ff_model_KO <- lm(KO_excess ~ Mkt.RF + SMB + HML, data = merged_data)
cat("\n--- FF Three-Factor Model: KO ---\n")
summary(ff_model_KO)

# ---- FF Model: PepsiCo ----
ff_model_PEP <- lm(PEP_excess ~ Mkt.RF + SMB + HML, data = merged_data)
cat("\n--- FF Three-Factor Model: PEP ---\n")
summary(ff_model_PEP)

# ---- Robust Standard Errors ----
cat("\n--- Robust SE: KO ---\n")
coeftest(ff_model_KO,  vcov = vcovHC(ff_model_KO,  type = "HC3"))

cat("\n--- Robust SE: PEP ---\n")
coeftest(ff_model_PEP, vcov = vcovHC(ff_model_PEP, type = "HC3"))

# ============================================================
# 5. FIGURES 3 & 4 - Cumulative Performance & Price Trends
# ============================================================

# ---- Figure 3: Cumulative Performance (Index = 100) ----
KO_ret_xts  <- na.omit(dailyReturn(Cl(KO)))
PEP_ret_xts <- na.omit(dailyReturn(Cl(PEP)))

KO_cumulative  <- cumprod(1 + KO_ret_xts)  * 100
PEP_cumulative <- cumprod(1 + PEP_ret_xts) * 100

cumulative_df <- data.frame(
  Date = index(KO_cumulative),
  KO   = as.numeric(KO_cumulative),
  PEP  = as.numeric(PEP_cumulative)
)

ggplot(cumulative_df, aes(x = Date)) +
  geom_line(aes(y = KO,  color = "KO"),  linewidth = 0.8) +
  geom_line(aes(y = PEP, color = "PEP"), linewidth = 0.8) +
  labs(title = "Cumulative Performance (Index=100 at start)",
       x = "", y = "Index", color = "") +
  theme_minimal()

# ---- Figure 4: Price Trends ----
prices_df <- data.frame(
  Date = index(Cl(KO)),
  KO   = as.numeric(Cl(KO)),
  PEP  = as.numeric(Cl(PEP))
)

par(mfrow = c(2, 1))
plot(prices_df$Date, prices_df$PEP,
     type = "l", main = "PEP Price (2024)",
     xlab = "", ylab = "Price", col = "black")
plot(prices_df$Date, prices_df$KO,
     type = "l", main = "KO Price (2024)",
     xlab = "", ylab = "Price", col = "black")
