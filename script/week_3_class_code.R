# week 3 class code

read.csv("data/tidy.csv")

x<- 4 # this is a vector of length one
# for more values, use function c(value, value, value, etc..), which means combine or concatonate

weight_g <- c(50, 60, 31, 89)
weight_g

#now characters:

animals <- c("mouse", "rat", "dog", "cat")
animals

#vector exploration tools:

length(weight_g)
length(animals)
# everything in a vector has to be the same data type! check using class fucntion
class(weight_g)
class(animals)

#to get structure of an object, use str()
str(weight_g)
str(animals)


weight_g <- c(weight_g, 105) # be careful about adding values and running this line multiple times 
weight_g

weight_g <- c(25, weight_g)
weight_g

#6 types of atomic vectors: first 4 are the main ones we will work with
#numeric (or double, can have decimals)
#character
#logical (true and false)
#integer (have to be whole round numbers)
#complex
#raw (r can store things as bits, you probably won’t use this)

typeof(weight_g)
class(weight_g)
typeof(animals)
class(animals)

weight_integer <- c(20L, 21L, 22L) # you can specify you want to make it an integer by putting L at end of number
class(weight_integer)
typeof(weight_integer)

#challenge: what happens to these vectors:

num_char <- c(1, 2, 3, "a") # this would default as character
typeof(num_char)

num_logical <- c(1, 2, 3, TRUE) # this defaults as a numeric, True  = 1 , False = 0
typeof(num_logical)
class(num_logical)

char_logical <- c("a", "b", "c", TRUE) #this defaults as character
class(char_logical)
char_logical

tricky <- c(1, 2, 3, "4") # this defaults as character
class(tricky)
tricky

combined_logical <- (num_logical, char_logical)
#this is called coersion: R makes all  the values in a vector the same data type, and it defaults it to the least specific type. So most simple: character, anything can be a character. then is double (can be numbers or decimals), and then integers, last is true false- can be 0 and 1 or characters

# challenge: How many values in combined_logical are "TRUE" (as a character) in the following example:
num_logical <- c(1, 2, 3, TRUE) 
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

#subsetting vectors
animals[3]

animals[2:3] # or
animals[c(2,3)]

#conditional subsetting:

weight_g[c(T, F, T, T, F, T, T)]
weight_g > 50

weight_g[weight_g > 50]


# multiple conditions
weight_g[weight_g < 30 | weight_g > 50]
weight_g[weight_g >= 30 & weight_g  == 90]

#searching for characters
animals[animals == "cat" | animals == "rat"] 

animals %in% c("rat", "antelope", "jackalope", "hypogryph")
# this gives you back a logical vector, but to get the name of the animals back, put this ^ in the []
animals[animals %in% c("rat", "antelope", "jackalope", "hypogryph")]
#says give me the animals that is true in the this vector, True False vectors in the sqaure brackets give the actual entry that is true 


# challenge:
"four" > "five" # why does this come out as true?
"eight" > "five" # sorts alphabetically 
"a" >"b" # this is false bc a is trhe first letter in the alphabet


#missing values 

heights <- c( 2,4,4,NA,6)
str(heights) # kept all as numeric
mean(weight_g)
mean(heights) # get back NA, bc R does not like the NA in there
max(heights) # also get back NA
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

#Functions useful for working with NAs:
is.na(heights) # tells you were NAs are
na.omit(heights)
complete.cases(heights) # removes all rows from a dataframe that have missing values, gives back a logical, TRUE means that is is a complete case 


