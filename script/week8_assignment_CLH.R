# Week 8 Assignment 

library(lubridate)
library(tidyverse)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)


# Make a datetime column by using paste to combine the date and time columns; 


am_riv$datetime <- paste0(am_riv$Date, " ", am_riv$Time)

#remember to convert it to a datetime!
am_riv$datetime<-  ymd_hms(am_riv$datetime, tz = "America/Los_Angeles")
class(am_riv$datetime)


# Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)

am_riv_temps <- am_riv %>% 
  group_by(week = week(datetime)) %>% 
  summarise(w_mean = mean(Temperature), w_max = max(Temperature), w_min = min(Temperature))

week(am_riv$datetime)

am_riv_plot <- ggplot(data = am_riv_temps, aes(x = week)) + 
  geom_point(aes(y = w_mean alpha = 0.5, color = tomato)) +
  geom_point(aes(y = w_min, alpha = 0.5, color = blue)) +
  geom_point(aes(y = w_max, alpha = 0.5, color = green)) 


  
am_riv_plot

#Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime)

#first make a month column
am_riv_month <- am_riv %>% 
  group_by(month = month(datetime))


# now calc houyly mean level April-June
am_riv_level <- am_riv_month %>% 
  filter(month == 4 | month == 5 | month == 6) %>% 
  group_by(hour = hour(datetime)) %>%   # i dont think its properly grouping by hour
  mutate(hourly_avg_level = mean(Level)) #because these numbers dont look right

am_riv_level_plot <- am_riv_level %>% 
  ggplot(aes(x = datetime, y= hourly_avg_level)) +
  geom_line()

am_riv_level_plot  #yea...data does not look right



#Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one!)

# mloa dataset without NAs:
mloa_2001_noNAs<- mloa_2001 %>% 
  filter(rel_humid != -99,  rel_humid != -999) %>% 
  filter(temp_C_2m != -99,  temp_C_2m != -999) %>% 
  filter(windSpeed_m_s != -99,  windSpeed_m_s != -999) 

#Function:

plot_temp <- function(x) { 
  data <- mloa_2001_noNAs
  temp_plot <- data %>% 
  filter(month == x) %>% 
  ggplot(aes(x = datetime, y = temp_C_2m)) +
    geom_line()
  return(temp_plot)
}

#testing it out:
plot_temp(2)
plot_temp(6)

#week 9 touching upon function from the HW:
#can also do this:
plot_temp <- function(monthtoinput, dat = mloa_2001_noNAs) { # so defaukt for dat is that
  data <- mloa_2001_noNAs
  temp_plot <- data %>% 
  filter(month == monthtoinput) %>% 
  ggplot(aes(x = datetime, y = temp_C_2m)) +
  geom_line()
return(temp_plot)
}

plot_temp(3)
  
  
  
  
  
