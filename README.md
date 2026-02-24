# WSA-Petals-and-Probabilities-2026-Team-Data-United-
## Overview

## Data

## Modeling
### Quetelet Model
### Growing Degree Days (GDD) Model
Our initial growing degree days (GDD) model was predicting bloom date using regression on cumulative GDD calculated up to the observed bloom date. However, this approach is not suitable for forecasting because GDD accumulation is defined using the bloomd date itself, creating a circualr dependency. To address this, we transitioned to a thermal threshold model in which bloom is predicted to occur when cumulative GDD exceed a critical heat requirement estimated from historical data. Esentially, our model transitioned from predicting the julian date of blooming to predicting when a biological heat requirement is met. 