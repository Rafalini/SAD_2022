require(magrittr)
require(tidyverse)
require(zoo)

# make titles in plots centered
theme_update(plot.title = element_text(hjust = 0.5))

# a)
dispersion_test <- function(x) 
{
  res <- 1-2 * abs((1 - pchisq((sum((x - mean(x))^2)/mean(x)), length(x) - 1))-0.5)
  
  cat("Dispersion test of count data:\n",
      length(x), " data points.\n",
      "Mean: ",mean(x),"\n",
      "Variance: ",var(x),"\n",
      "Probability of being drawn from Poisson distribution: ", 
      round(res, 3),"\n", sep = "")
  
  invisible(res)
}

df <- read.csv('katastrofy.csv')
df$Date = as.Date(as.character(df$Date), format = "%m/%d/%Y")
df$quarter = as.yearqtr(df$Date)
q_counts = df %>% count(quarter)
ggplot(q_counts, aes(x=quarter, y=n))+ geom_col() + 
  labs(x='kwartał', y='liczba wypadków lotniczych', title = 'Liczba wypadków lotniczych w poszczególnych kwartałach.')

dispersion_test(q_counts$n)
# for after 2000
dispersion_test(tail(q_counts, n=38)$n)

# b_1)
df$year = format(df$Date, format="%Y")
y_count = df %>% count(year)
# y_count = complete(y_count, year)
# eg <- expand.grid(year = unique(y_count$year), n = unique(y_count$n))
# ggplot(merge(y_count, eg, all = TRUE), aes(x=year, y=n))
# ggplot(head(y_count), aes(x=year, y=n))+ geom_col()
  # scale_x_discrete(name ="test", limits=seq(1908:1917))

plot(y_count, type='h', cex.main=1, main="Liczba wypadków lotniczych w poszczególnych latach.", xlab='rok', ylab='liczba wypadków lotniczych')
lines(y_count, col='red')

# b_2)
df=y_count[y_count$year >= 2004 & y_count$year <= 2008,]
df$flights = c(23.8, 24.9, 25.5, 26.7, 26.5)
df
ggplot(df, aes(x=year, y=n/flights)) + geom_col() + 
  labs(x='rok',
       y='liczba wypadków lotniczych na milion lotów',
       title = 'Liczba rocznych wypadków lotniczych na milion lotów okresie2004-2008.')