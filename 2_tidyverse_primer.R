library(tidyverse)

mtcars[order(mtcars$gear, mtcars$mpg), ]
arrange(.data = mtcars, gear, mpg)

boot_samp <- rsample::bootstraps(mtcars, times = 3)
boot_samp
class(boot_samp)


small_mtcars <- arrange(mtcars, gear)
small_mtcars <- slice(small_mtcars, 1:10)

# or more compactly:
small_mtcars <- slice(arrange(mtcars, gear), 1:10)

small_mtcars <-
  mtcars %>%
  arrange(gear) %>%
  slice(1:10)

library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = lm)

n <- nrow(mtcars)
ratios <- rep(NA_real_, n)
for (car in 1:n) {
  ratios[car] <- log(mtcars$mpg[car] / mtcars$wt[car])
}
head(ratios)

ratios <- log(mtcars$mpg / mtcars$wt)

compute_log_ratio <- function(mpg, wt) {
  log_base <- getOption("log_base", default = exp(1)) # gets external data
  results <- log(mpg / wt, base = log_base)
  print(mean(results)) # prints to the console
  done <<- TRUE # sets external data
  results
}

compute_log_ratio <- function(mpg, wt, log_base = exp(1)) {
  log(mpg / wt, base = log_base)
}

map(head(mtcars$mpg, 3), sqrt)
map_dbl(head(mtcars$mpg, 3), sqrt)

log_ratios <- map2_dbl(mtcars$mpg, mtcars$wt, compute_log_ratio)
head(log_ratios)

map2_dbl(mtcars$mpg, mtcars$wt, ~ log(.x / .y)) %>%
  head()


data.frame(`variable 1` = 1:2, two = 3:4)

df <- data.frame(`variable 1` = 1:2, two = 3:4, check.names = FALSE)
df

tbbl <- tibble(`variable 1` = 1:2, two = 3:4)
tbbl

df$tw
tbbl$tw

df[, "two"]
tbbl[, "two"]

library(tidyverse)
library(lubridate)

url <- "https://data.cityofchicago.org/api/views/5neh-572f/rows.csv?accessType=DOWNLOAD&bom=true&format=true"

all_stations <- 
  read_csv(url) %>% 
  dplyr::select(station = stationname, date, rides) %>% 
  mutate(date = mdy(date), rides = rides / 1000) %>% 
  group_by(date, station) %>% 
  summarize(rides = max(rides), .groups = "drop")
