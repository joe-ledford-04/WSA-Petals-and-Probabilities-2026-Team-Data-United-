# WSA-Petals-and-Probabilities-2026-Team-Data-United-
## Overview
This repository is Team Data United's submission to the George Mason Cherry Blossom competition for 2026.
Official repository for the competition: [GMU-Cherry Blossom Competition](https://github.com/GMU-CherryBlossomCompetition/peak-bloom-prediction/blob/main/data/README.md). This is includes the rules and starting data sets. 

Temperatue data for 2025 was also collected through NOAA API, and predicted 2026 temperatures for the spring were taking from AccuWeather. 

__Predictions__:
* Washington, Dc: April 3rd, DOY=93
* Kyoto: 
* Liestal:
* NYC: 
* Vancouver:



## Modeling
### Quetelet Model
Our inital model was based on Quetelet's Law of Flowering Plants, with the underlying theory that plants bloom after exposure to a specific predetemrined accumulation of heat. This is calculated by summing the square mean degrees Celsius<sup>2</sup> following last frost. However, this approach assumes flowering times are normally distributed across years. Unfortunately, this is not the case today as climate change has and will continue to shift seasonal temperature intervals. In order to capture these changes in our predictions for 2026, we decided to shift to a growing degree days (GDD) model. 

### Growing Degree Days (GDD) Model
Our initial model regressed observed bloom dates on cumulative Growing Degree Days (GDD) calculated up to the observed bloom date. However, this created a data leakage problem; GDD accumulation was defined using the bloom date itself. 


### Thermal Threshold Phenology Model 
Interestingly enough, this quite simple heuristic phenology model was our best by far. It capture the two-stage dormancy process the cherry blossoms follow: winter chilling and spring heat accumulation. We use a simulation function to get the chilling requirment and the subsequent growing degree days (GDD) needed in order to bloom. Then we estimate the forcing requirment based on historical averages. However, modeling chill and heat accumulation sequentially is a strict assumption. Modeling this way can overestimate bloom delays from warmer than usual winters, for example. The latest research tells posits heat accumulation can occur during late dormancy, with chill and heat exposure interacting dynamically. 

### Parallel Threshold Dormancy Model
This model follows the latest reasearch by tring to capture the dynamic interaction between chill and heat accumulation across the whole season, so early warmth is captured. Given the trend of climate change and ealier blooming seen in recent years, capturing early season warmth is critcal for an accurate prediciton. It also makes the model more robust and reduced the risk of overfitting the data. 


## City Predictions
### Washington, DC Prediction
In Washington, DC, peak bloom occurs when approximately 70% of Yoshino cherry trees reach flowering stage, as defined by the National Park Service. [NPS Website] (https://www.nps.gov/subjects/cherryblossom/bloom-watch.htm) We predict the 