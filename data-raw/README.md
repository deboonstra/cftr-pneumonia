# data-raw

This sub-directory will never have its contents track by Git, as it contains the raw data obtained from MarketScan. Generally, this data will be provided to myself, D. Erik Boonstra, by Aaron Miller, my co-investigator. Below are descriptions of data received along with descriptions of the variables within each data set.

`cftr_incidence_series.RData` is tibble data frame with 11,088 observations and 9 variables. This data set contains incidence rates for various diseases given CF carrier status throughout time. The variables included in this data set are

- `code_set`: `chr` disease type,
- `case`: `num` CF carrier status (0 = control, 1 = CF carrier),
- `year`: `num` year,
- `month`: `num` month,
- `month_start`: `Date, YYYY-mm-dd` date that started the month,
- `month_end`: `Date, YYYY-mm-dd` date that ended the month,
- `incidence`: `num` incidence per 10,000 subjects,
- `n`: `int` number of disease cases recorded, and
- `tot_enroll_months`: `num` total number of months enrolled in MarketScan for the subjects.