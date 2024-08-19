import pandas as pd
import numpy as np

first_series = pd.Series(list('abcdefg'))
print(first_series)

# By default index position will be auto incremented with start position = 0 and end value =8
# To change index position explicitly 
city_series = pd.Series(np.array(['Luxembourg','Ireland','Switzerland',
                                    'Norway','Singapore','United States','Iceland','Qatar']),
                                    index = ['a','b','c','d','e','f','g','h'])

print(city_series)




# Collection of Series
country_per_capita = {'Country' :pd.Series(np.array(['Luxembourg','Ireland','Switzerland',
                    'Norway','Singapore','United States','Iceland','Qatar'])),
 'GDP_per_capita' : pd.Series(np.array([12463,2326,1562,2537,3511,2641,7848,3975]))
}

# Creating data frame using Collection of series 
GDP_DF = pd.DataFrame(country_per_capita)

# Display first five rows
print(GDP_DF.head())