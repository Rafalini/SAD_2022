require(magrittr)
require(tidyverse)
require(zoo)


# make titles in plots centered
theme_update(plot.title = element_text(hjust = 0.5))


df <- as.tibble(read.csv('katastrofy.csv'))
df$Date = as.Date(as.character(df$Date), format = "%m/%d/%Y")
df$quarter = as.yearqtr(df$Date)
df$year = format(df$Date, format="%Y")
df$month = format(df$Date, format="%m")

# df1=sum(df, aboard)
df1 = df %>% dplyr::group_by(month) %>% dplyr::summarise(n=n(), mean=mean(Fatalities, na.rm = TRUE), sd=sd(Fatalities, na.rm=TRUE))
# df1 = df %>% count(month)

ggplot(df1, aes(x=month, y=mean))+ geom_col() +
  labs(x='miesiąc', y='średnia liczba ofiar śmiertelnych', title = 'Średnia liczba ofiar śmiertelnych w wypadkach lotniczych w poszczególnych miesiącach.')

df[df$month == '01',]$Fatalities -> test
wilcox.test(x=df[df$month == '01',]$Fatalities, y=df[df$month == '09',]$Fatalities)
