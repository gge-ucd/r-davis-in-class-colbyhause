# week 4 R code

# Intro to Dataframes 

#downloiad a file and name the destination
download.file(url="https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")

surveys <- read.csv(file = "data/portal_data_joined.csv") #autocomplete the path by hitting tab after you type the quotes 

surveys # gives lots of info
head(surveys) # give all the columns but only first 6 rows

# every column in a df is a vector, so each column all has the same type of data

str(surveys) #obs  =  rows, vartiables  =  columns
dim(surveys) # gives number of rows and cols
nrow(surveys) # give the number of row BUT really the index numbert of the last row
ncol(surveys) # give number of cols but really the index nbumber of the last col
tail(surveys)
names(surveys) # gives names of all the columns in the df (gives character vector of names)
rownames(surveys) # character vector of the number of each row

#another really useful function:
summary(surveys) # gives summary stats on each of the columns 

#subsetting dataframes

animal_vec <- c("mouse", "rat", "cat")
#subsetting vectors by giving thema location
animal_vec[2]

#dataframes are 2D
surveys[1,1] #[row, column]
head(surveys)
surveys[2,1] 
# whole first column as a vector
surveys[ ,1] # leave one of those dimensions blank says to get everything from that dimension. this outputs as a vector
surveys[1] # using a single number with no number outputs a dataframe with one column
head(surveys[1]) 
#pull out the first 3 values in the 6th col:
surveys[1:3,6] # so this is subsetting the vector 1,2,3 and giving back the values for those spots

#pull out a whole single observation
surveys[5, ] # gives back a dataframe with the length of 1 row and 13 cols 

#negative sign to exclude indices
surveys[1:5, -1] # this give all the columns except the first

surveys[-10:34786, ] # what we want is all the cols and onyl the first 10 rows, but r throws error
surveys[-c(10:34786), ] # so instead use -c(), this will exclude everything you put in -c()
surveys[c(10, 15, 20), ] 
surveys[c(10, 15, 20, 10), ] # calls the 2nd 10 row 10.1 bc all row names need to be different

# more ways to subset
surveys["plot_id"] # gives back single column as df
surveys[ , "plot_id"] # gives back single column but as vector
surveys[["plot_id"]] # first pulling out single column as df, and then going one step deeper and askign for what is inside of that df- so gives yout he stuff inside of that df, so a single column as a vector
# think of single bracket [] as giving you a train car, and double brackets [[ ]] gives you what is inside of that train car
#DOUBLE BRACKETS ARE USEFUL FOR LISTS- WE WILL COME BACK TO THIS

surveys$year #gives back a single col as vector 

#Challenge
#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.
surveys_200 <- surveys[200, ]
#Notice how nrow() gave you the number of rows in a data.frame?
surveys[nrow(surveys), ]
  #Use that number to pull out just that last row in the data frame.
#Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.
tail(surveys)
#Pull out that last row using nrow() instead of the row number.
Create a new data frame (surveys_last) from that last row.

#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.
34786/2 # instead of using this, use an expression below
surveys_middle <- surveys[nrow(surveys)/2, ]
surveys_middle


#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.
surveys[-c(7:nrow(surveys)),]


#Factors : factors are stored as integers with labels assigned to them.

surveys$sex

#creating our own factor
sex <- factor(c("male", "female", "female", "male"))
sex # r assigns 1 to level female and 2 to level male, so R labels 1 male and 2 female 
class(sex) # class tells us a higher level attribute of the thing
typeof(sex) # tells more description of what is in the object
levels(sex) # levels gives back a character vectore of the levels
levels(surveys$genus)
nlevels(sex) #gives back number of levels

concentration <- factor(c("high", "medium", "high", "low"))
concentration <- factor(concentration, levels = c("low", "medium", "high")) # put the levels in the order you want
concentration

#lets try adding to a factor
concentration <- c(concentration, "very high") # can't just add value that doesnt match level, turns all your values into a character vector
concentration

#lets just make them characters
as.character(sex)


#factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018)) # these are just labels, under the hood they are just integers
as.numeric(year_factor) # now you just get the underlying integer values 
as.character(year_factor)
as.numeric(as.character(year_factor)) # now if you convert the character vector to a numeric you get the levels as a numeric
class(as.numeric(as.character(year_factor)))
#RECOMMMENDED WAY: above is a weird work around, below is safer
as.numeric(levels(year_factor))[year_factor]

# why all the factors???
?read.csv # as a default, read.csv defaults to turning all character strings as factors
surveys_no_factors <- read.csv("data/portal_data_joined.csv",stringsAsFactors = FALSE)
str(surveys_no_factors)

#renaming factors
sex <- surveys$sex
levels(sex)[1] <- "undetermined" #now anything that was blank is now the level undetermined
levels(sex)
head(sex)

#working with dates
library('lubridate') # this now calls on lubridate

my_date <- ymd("2015-01-01")
my_date
str(my_date) # being stored as a date with the year-month-day format

my_date <- ymd(paste("2015", "5", "17", sep = "-")) # paste takes a bunch of values and sticks them together into one printed string. sep denotes what you are seperating each of the strings with
my_date
#you can do this to multiple columns of data
paste(surveys$year, surveys$month, surveys$year, sep = "-")
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$year, sep = "-")) # have to use the ymd function so R knows it as a date
is.na(surveys$date)
surveys$date[is.na(surveys$date)]
#HW: check back tonight fore the assignment
#briannepalmer- partner 


