#week 6 Assignment
# Tue Feb 19 02:09:34 2019 ------------------------------


library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

#Modify the following code to make a figure that shows how life expectancy has changed over time:
  
  ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

# Modified code:

#Heres one way you could do it: how average life expectancy in each continent has changed over time
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(average_lifeExp  = mean(lifeExp)) %>% 
  ggplot(aes(x= year, y =average_lifeExp, color = continent)) + 
  geom_point() 


# in the code:
  ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(color = continent), size = .25) + 
    scale_x_log10() +
    geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
    theme_bw()
  
# ...the scale_x_log10 transforms the x axis to a log10 scale
# ...geom smooth adds a trend line
  
#Modify the above code to size the points in proportion to the population of the county. Hint: Are you translating data to a visual feature of the plot?
  
# I changed the size to pop to make larger points indicative of continents with higher populations
  ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(color = continent, size = pop)) + 
    scale_x_log10() +
    geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
    theme_bw()
  
    
    
   