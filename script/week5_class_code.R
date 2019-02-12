# week 5 in class

library(tidyverse)

#problems that tidyverse solves:
# allows you to acces large online repsositories without having to download whole files
# doesn't change the type of data yoiu are working with

surveys <- read_csv("data/portal_data_joined.csv") #read_cvs is a tidyverse thing
str(surveys) #tibble, coumns are characters and never converted to factors
#a tibble is a fnacy name for a table,  fancy dataframe

# select is used for COLUMNS in a dataframe
select(surveys, plot_id, species_id, weight)

#filter is used for ROWS
filter(surveys, year == 1995)

# to filter and select at the same time:use intermediatesteps by creating new dataframes
surveys2 <- filter(surveys, weight < 5)
surveys_small <- select(surveys2, species_id, sex, weight)

#or instead you could us a PIPE %>%  (command shift m)
#pipe takes all the info from the left of pipe and passes it to the right 
surveys %>%   # and then...
  filter(weight < 5) %>% # and then...
  select(species_id, sex, weight)

# Challenge: subset surveys to include individs collected before 1995 and retain only the columns year, sex, weight

challenege <- surveys %>% 
  filter(year > 1995) %>% 
  select(species_id, sex, weight)
# important to note: keep track of order of select and filter

#mutate is used to create new columns. It creates a new column by manipulating the data from another column
surveys<- surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2)

#to remove the NAs, add this into your filter chain

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  summary() #takes summary of everything to the left of this pipe

# "complete cases" to filter out the NAs


#CHALLENGE: Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.

challenge2 <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_half)

#group_by() is good for split-apply-combine
#summaerize is always used with group by because it acts on the grouping
#compute mean weight for males and females:

surveys %>% 
  group_by(sex) %>%  #says to group dataframe by sex
  summarize(mean_weight = mean(weight, na.rm = TRUE)) #just removed NAs from the calculation, not from the actuasl dataframe
#difference btwn mutate and summarize: mutate adds bnew columns to existing dataframe. Summarize spits out an entirely new dataframe. It does stuff based on what your grouping and spits out a new df. if you want to add to your existing dataframe, use mutate

surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight  = mean(weight, na.rm = TRUE)) %>%  View()

# quickly see how many NAs there are
surveys %>% 
  filter(is.na(weight))

# tells us where the NAs are in species 
surveys %>% 
  group_by(species) %>% 
  filter(is.na(sex)) %>% 
  tally()

# group by mulitple columns: calc mean of each sex by each species
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight)) %>% 
  View()

#Nans in data means Not a number, usually happens when R tries to divide by 0 

# can use summarize more than once:
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight), min_weight =   min(weight)) %>% 
  View()

#tally function: gives the number of observations for each factor, with tally you generate a tibble
#so if you wnat to know the number of females and males of each species 
surveys %>%  
  group_by(sex, species_id) %>% 
  tally() %>% 
  View()
# tally is the same as if you group_by(something) %>% summarize new_solumn s= n())

#Gathering and spreading

#spreading takes a long format dataframe and puts it into a wide format dataframe. Takes data you want to spread and then take a key column variable and a value column.Key column variable is what you want to make into a bunch of coplumns, and cvalue variable is whayt you want to puopukate those columns with.

surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))
#this give us a df that has each genus in each plot by each weight- this is a loing format. instead, we want each genus to be its own column:
surveys_spread <- surveys_gw %>% 
  spread(key = genus, value = mean_weight) #key is genus
#for a good visual: look at figure from "reshaping and gathering with spread" under course materials in data manipuklation with dply and tidyr
surveys_gw %>% 
  tidyr::spread(genus, mean_weight, fill = 0) %>%  View() #fill 0 makes NAs 0s

#Gathering:
#get genus into their own column:
surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id ) #key is column variable we wish to create from column names. Says use all the columns minus plot id to fill the key variable
# look figure in same location as the spread figure 
