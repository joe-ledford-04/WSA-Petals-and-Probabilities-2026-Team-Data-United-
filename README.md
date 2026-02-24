# WSA-Petals-and-Probabilities-2026-Team-Data-United-
## Overview
This repository is Team Data United's submission to the George Mason Cherry Blossom competition for 2026.
Official repository for the competition: [GMU-Cherry Blossom Competition](https://github.com/GMU-CherryBlossomCompetition/peak-bloom-prediction/blob/main/data/README.md). This is includes the rules and starting data sets. Temperatue data for 2025 was also collected through NOAA API, and predicted 2026 temperatures for the spring were taking from AccuWeather. 


## Modeling
### Quetelet Model
Our inital model was based on Quetelet's Law of Flowering Plants, with the underlying theory that plants bloom after exposure to a specific predetemrined accumulation of heat. This is calculated by summing the square mean degrees Celsius<sup>2</sup> following last frost. However, this approach assumes flowering times are normally distributed across years. Unfortunately, this is not the case today as climate change has and will continue to shift seasonal temperature intervals. In order to capture these changes in our predictions for 2026, we decided to shift to a growing degree days (GDD) model. 

### Growing Degree Days (GDD) Model
Our initial growing degree days (GDD) model was predicting bloom date using regression on cumulative GDD calculated up to the observed bloom date. However, this approach is not suitable for forecasting because GDD accumulation is defined using the bloomd date itself, creating leakage. 

We pivoted to a different approach that focuses on accumlated heat above a threshold. Once enough heat units are accumlated, flowering or maturity triggers. The heat requirment is decided by the dormancy release, represented by chill accumulation in our model. Different amounts of chill accumulation effect the amount of GDD needed. Now our model is portable across years and locations because a warm early spring and close late spring will produce different calendar dates but similar GDD totals at flowering. 

