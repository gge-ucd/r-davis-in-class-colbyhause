#Week 8 Class code


load("data/mauna_loa_met_2001_minute (1).rda")

as.Date("02-01-1998", format = "%m-%d-%Y")

#shorter way: use lubriatde

library(lubridate)
library(tidyverse)

mdy("02-01-1998")

as. POSIXct # a class of date time data, works similarly to as.date function, looks for year month day hours minutes seconds. if different from that you have to tell it the format

tm1 <- as.POSIXct("2016-07-24 23:55:26 PDT")
tm1

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S") # do if different format, you  have to specify the format
tm2
# lower case y is 2 digit year, uppercase Y is 4 digit year

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT") # can add a timezone 
tm3

# if you need to say the format and timezone within the same as.POSIXct call, its  alittle different:
tm4 <- as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d %H:%M"), tz = "America/Los_Angeles")
tz(tm4)
#when you specify a tz, look at options for all different timezones if you google search strptime

Sys.timezone() #default timezone on your computer

#Do the same thing with lubridate
ymd_hm("2016/04/04 14:47", tz = "America/Los_Angeles")

ymd_hms("2016/04/04 14:47:33") # automatically converts to UTC


nfy<- read_csv("data/2015_NFY_solinst.csv", skip = 12)
#gives error message about missing column headers, so use skip to skip the header lines (meaning it skips lines 1-12)

#Using Lubridate on a dataframe

# when using lubridate on a dateframe, the date and time column to both be characters
class(nfy$Date)
class(nfy$Time)

nfy2 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd") #col_types allows you to specify the type each column should be read in as, so ccidd means first col is character, 2nd is character, 3rd is integer, and last two are doubles

glimpse(nfy2)
# if you only want to set the type for one column:
(nfy3 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = cols(Date = col_date())))# says read everything in automatically but for date column read in as a date 

#now we want to mash date and time together to be date_time with paste function

nfy2$datetime <- paste(nfy2$Date, " ", nfy2$Time, sep = "") # sep identifies the seperator
#now we have to make sure R recongnizes the date time as a date time, not character. Yo0u can do this 2 ways: using POSIXct or lubridate:

#trying with lubridate
nfy2$datetime<- ymd_hms(nfy2$datetime, tz = "America/Los_Angeles")
tz(nfy2$datetime_test)
glimpse(nfy2)

######################################### new data set
summary(mloa_2001)
mloa_2001$datetime <- paste0(mloa_2001$year,"-", mloa_2001$month, "-",mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)
glimpse(mloa_2001)

#now that we made a datetime col, we need to make sure R recognizes it as a dttm(datetime)

mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)
glimpse(mloa_2001)

#Challenge: Remove the NA’s (-99 and -999) in rel_humid, temp_C_2m,  windSpeed_m_s 
#Use dplyr to calculate the mean monthly temperature (temp_C_2m) using the datetime column (HINT: look at lubridate functions like month())
#Make a ggplot of the avg monthly temperature
#Make a ggplot of the daily average temperature for July (HINT: try yday() function with some summarize() in dplyr)

#Remove the NA’s (-99 and -999) in rel_humid, temp_C_2m,  windSpeed_m_s 
mloa_2001_noNAs<- mloa_2001 %>% 
  filter(rel_humid != -99,  rel_humid != -999) %>% 
  filter(temp_C_2m != -99,  temp_C_2m != -999) %>% 
  filter(windSpeed_m_s != -99,  windSpeed_m_s != -999) 

#Use dplyr to calculate the mean monthly temperature (temp_C_2m) using the datetime column (HINT: look at lubridate functions like month())
mloa3 <- mloa_2001_noNAs %>% 
  mutate(which_month = month(datetime, label = TRUE)) %>% 
  group_by(which_month) %>% 
  summarize(mean_monthly_temp = mean(temp_C_2m)) 


  ggplot(mloa3) +
    geom_point(aes(x = which_month, y = mean_monthly_temp)) #+
    #geom_line(aes(which_month, mean_monthly_temp))
  
  ##############################################Functions###########
  
  log(5)

  my_sum <-function(a, b) {
    the_sum <- a + b
    return(the_sum)
  }
    
my_sum(3,7)
# some functions have defaults built into them, and you can also set defaults into your functions

my_sum <-function(a = 1, b = 2) { # says that 1 and 2 are the default vals
  the_sum <- a + b
  return(the_sum)
}

my_sum()
my_sum(7)


# create a function that converts the temp in K to the temp in C (subtract 273.15)

temp_KtoC <- function(a) {
  x <- a-273.15
  return(x)
}
temp_KtoC(67)
list <- c(8,9,130)
temp_KtoC(list)


# you can put a whole dataframe into a function. 

##################Loops###########################

#vectorized functions: alrerady work iterativelty- very faast at doing this. IF you can give a function a vector value and it will give it back- use it!
x<- 1:10
log(x)

# For loops, will repeat code eachtime with a new input value

#Structure:

for(i in 1:10) { # says for each value i in vector 1:10, in want to do somethig
 print(i) # do stuff in loop with i =  1,2,3,4,5..
} 

for (i in 1:10) {
  print(i)
  print(i^2)
}

# i just takes on a value

letters[2]

# we can use the i value as an index 

for (i in 1:10) {
  print(letters[i])
  print(mtcars$wt[i])
}

# if each time you want to save your result, you need to create something to hold the results before running the loop. so you need to create an empty container at the start and fill it up as you run the loop. You should make a results vector ahead of time:

results <- rep(NA, 10) # makes a results vector with 10 NAs. you will fill this with the output of forloop

for (i in 1:10) {
  results[i] <- letters[i]
}
results




