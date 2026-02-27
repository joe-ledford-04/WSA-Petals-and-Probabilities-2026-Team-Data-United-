# GET ACCUWEATHER FORECAST
# Email Jonathan Auerbach jauerba@gmu.edu with questions
# Forecast from AccuWeather 90-day forecast 
## e.g. https://www.accuweather.com/en/jp/arashiyama/2334469/march-weather/2334469?year=2026
# Archived on archive.org
## e.g.https://web.archive.org/web/20260224/https://www.accuweather.com/en/jp/arashiyama/2334469/march-weather/2334469?year=2026
# Note temperatures are downloaded in degrees Fahrenheit and converted to Celsius at the end of the script

library("tidyverse")
library("rvest")

get_weather_table <- function(url)
  read_html(url) %>% 
  html_nodes("div.monthly-calendar") %>% 
  html_text2() %>%
  str_replace("N/A", "N/A N/A") %>%
  str_remove_all("°|Hist. Avg. ") %>%
  str_split(" ", simplify = TRUE) %>%
  parse_number() %>%
  matrix(ncol = 3, 
         byrow = TRUE,
         dimnames = list(NULL, c("day", "tmax", "tmin"))) %>%
  as_tibble() %>%
  filter(row_number() >= day) %>%
  filter(!duplicated(day))

kyoto <-
  tibble(
    base_url = "https://web.archive.org/web/20260224/https://www.accuweather.com/en/jp/arashiyama/2334469/",
    month = month.name[1:5],
    year = 2026,
    url = str_c(base_url, tolower(month), "-weather/2334469?year=", year)) %>%
  mutate(temp = map(url, get_weather_table)) %>%
  pull(temp) %>%
  reduce(bind_rows) %>%
  transmute(date = seq(as.Date("2026-01-01"), as.Date("2026-05-31"), 1),
            year = parse_number(format(date, "%Y")),
            tmax = ifelse(is.na(tmax), (lag(tmax) + lead(tmax)) / 2, tmax),
            tmin = ifelse(is.na(tmin), (lag(tmin) + lead(tmin)) / 2, tmin),
            temp = (tmax + tmin) / 2)

liestal <-
  tibble(
    base_url = "https://web.archive.org/web/20260224/https://www.accuweather.com/en/ch/liestal/311994/",
    month = month.name[1:5],
    year = 2026,
    url = str_c(base_url, tolower(month), "-weather/311994?year=", year)) %>%
  mutate(temp = map(url, get_weather_table)) %>%
  pull(temp) %>%
  reduce(bind_rows) %>%
  transmute(date = seq(as.Date("2026-01-01"), as.Date("2026-05-31"), 1),
            year = parse_number(format(date, "%Y")),
            tmax,
            tmin,
            temp = (tmax + tmin) / 2)

newyork <-
  tibble(
    base_url = "https://web.archive.org/web/20260224/https://www.accuweather.com/en/us/new-york/10021/",
    month = month.name[1:5],
    year = 2026,
    url = str_c(base_url, tolower(month), "-weather/349727?year=", year)) %>%
  mutate(temp = map(url, get_weather_table)) %>%
  pull(temp) %>%
  reduce(bind_rows) %>%
  transmute(date = seq(as.Date("2026-01-01"), as.Date("2026-05-31"), 1),
            year = parse_number(format(date, "%Y")),
            tmax,
            tmin,
            temp = (tmax + tmin) / 2)

washington <-
  tibble(
    base_url = "https://web.archive.org/web/20260224/https://www.accuweather.com/en/us/washington/20006/",
    month = month.name[1:5],
    year = 2026,
    url = str_c(base_url, tolower(month), "-weather/18-327659_1_al?year=", year)) %>%
  mutate(temp = map(url, get_weather_table)) %>%
  pull(temp) %>%
  reduce(bind_rows) %>%
  transmute(date = seq(as.Date("2026-01-01"), as.Date("2026-05-31"), 1),
            year = parse_number(format(date, "%Y")),
            tmax,
            tmin,
            temp = (tmax + tmin) / 2)  

vancouver <-
  tibble(
    base_url = "https://web.archive.org/web/20260224/https://www.accuweather.com/en/us/vancouver/98661/",
    month = month.name[1:5],
    year = 2026,
    url = str_c(base_url, tolower(month), "-weather/331419?year=", year)) %>%
  mutate(temp = map(url, get_weather_table)) %>%
  pull(temp) %>%
  reduce(bind_rows) %>%
  transmute(date = seq(as.Date("2026-01-01"), as.Date("2026-05-31"), 1),
            year = parse_number(format(date, "%Y")),
            tmax,
            tmin,
            temp = (tmax + tmin) / 2)  

bind_rows(kyoto %>% mutate(location = "kyoto"),
          liestal %>% mutate(location = "liestal"),
          newyork %>% mutate(location = "newyork"),
          vancouver %>% mutate(location = "vancouver"),
          washington %>% mutate(location = "washington")) %>%
  mutate(tmax = round((tmax- 32) * 5/9, 3),
         tmin = round((tmin- 32) * 5/9, 3),
         temp = round((temp - 32) * 5/9, 3)) %>%
  write_csv("accuweather_forecast_2026.csv")


