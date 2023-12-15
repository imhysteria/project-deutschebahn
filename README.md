# Project Deutsche Bahm

### Overview

Tihs is an overview of my final project for Deutsche Bahn, where I analyse the train schedule and delays that occurs on the German train network (specifically for long distance travel). 

You can access the required files via the following in this repository

1. Notebook: ray-final-deutschebahn.ipynb
2. MySQL: ray-deutschebahn-databases.sql
3. Presentation: IronHack - Deutsche Bahn - Ray.pdf
4. Tableau: [https://public.tableau.com/app/profile/ray.pham/viz/ray-referendum-ironhack/AustraliaMap](https://public.tableau.com/app/profile/ray.pham/viz/ray-deutsche-bahn/HourlyTrends)
5. Trello: https://trello.com/b/O3fjXGGJ/finalproject

All the necessary CSV and datasets are included with the cleaned versions available in the root folder.


### Background

Deutsche Bahn once had a reputation akin to the entire image of Germany, punctuality and efficiency. However in the past years, due to the aging and neglected infrastructure,  this has become a problem for train reliancy and punctuality. 

- 80,6% long-distance trains on time in 2022.
- 58% long-distance trains on time in 2023.
- 
General customer satisfaction is at an all time low, especially Germany is seen as a sustainable country promoting it's train network as an eco-friendly form of travel


### Approach

This analytic project is to understand the efficiency of the Deutsche Bahn train network on key routes, by analysing key dimensions such as delays, distance, timings.

1. Which stations have the most delays
2. If time of travel causes delays
3. Does distance of between affect delays
4. Build a model that can predict potential delays


Unfortunately I wasn’t able to retrieve the passenger information and due to the amount of travels and stations,
I focused the project on key cities. It was also difficult to access the only data set without the API key via Deutsche Bahn (I had a last minute rejection to the request), so I managed to pull data from an open source website.

https://gtfs.de/en/feeds/


## Process

1. Researched for relevant datasets for this project
2. Requested API keys from zugfinder.net and data.deutschebahn.com without luck (only commercial partners or market agencies)
3. Found an free open source where I could download limited data (schedule, station, trips, routes etc)
4. Did my analysis in Python and data-wrangled the initial set
5. Tested an initial prediction model to calculate likelihood of a delay and for how long
6. Unfortunately the model didn't perform so well
7. Instead I moved forward with focus on analysing the information in SQL and Tableau


### Learnings

I completely underestimated that the dimensions of the data had a very negative impact on the model and I was not able to create a functional version with a decent MSE score. Making adjustments to dataset I was at least able to improve the binary classification score but my objective to predict delay times the information I had available was not able to model this.

My conclusion on this project is:

1. I needed more numerical values (having only two in sufficient for a dataset this size)
2. Distance between stations did not impact the delay times as much as I have expected
3. Focus on perhaps more granular clusters of the train network (regions rather than national), this way there delay times could perhaps be more correlated to nearby stations
4. Missing passenger dimension could have helped improve the model but this is inconclusive.

