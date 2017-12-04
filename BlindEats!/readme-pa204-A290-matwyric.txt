Matthew Wyrick
mattrwyrick@gmail.com
Nov 27, 2017
Individual

Blind Eats! (Milestone 3)

Completed:
Successfully query Zomato API for restaurants.
Successfully parse JSON results into local Restaurant objects
Results display and functionality of app works with real data now.

Improvements (not necessarily specified in contract, but things I noticed after connecting to the api):
Currently the app queries the api with a geolocation and then parses out the restaurant data. If the city were pulled from the request and then another request were sent specifically asking for all of the restaurants in that city it would provide more restaurants. I spent a lot of time figuring out how to iterate and deal with JSONs that I did not expect (swift 3 is crazy on types and casting), that I didn’t really investigate into this, but it would definitely enhance the app before the final submission.
