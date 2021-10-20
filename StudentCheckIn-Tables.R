#Import data
F21.StudentCheck.In <- read.csv("~/Dropbox/00-UCLA/Courses/DH125-Stats/Data/F21-StudentCheck-In.csv", comment.char="#")

#View data
View(F21.StudentCheck.In)

#Create an outcome table of current emotions when students took the check-in survey
table(F21.StudentCheck.In$Current_Emotion)

#Create a simple bar plot of current emotions
barplot(table(F21.StudentCheck.In$Current_Emotion))

#Create a ggplot barplot with flipped coordinates to view the full descriptions of sentiments
#First add ggplot2 to your library
library(ggplot2)

#Create a barplot without a y-value by tell R to consider Current_Emotion as a factor
#Use stat="count" to count the number of instances of each emotional category
#width=.8 sets the width of the bar
#set theme with theme_minimal or theme_classic. For more, see https://ggplot2.tidyverse.org/reference/ggtheme.html
#Use +coord_flip() to switch the axes so we can read the full descriptions of sentiments
#Then add labels, including a title and x- and y-axis labels.
emotions <- ggplot(F21.StudentCheck.In, aes(x=factor(Current_Emotion)))+
  geom_bar(stat="count", width=.8, fill="steelblue")+
  theme_minimal()+coord_flip()
emotions + labs(title="Emotions Reported by DH Students in October 2021", 
                    x="Count", y = "Emotions")

#CONTINGENCY TABLES
#Create a contingency table of students' class and year
table(F21.StudentCheck.In$Class, F21.StudentCheck.In$Year)

#Create a contingency table of students' year and current emotion
yr_emo <- table(F21.StudentCheck.In$Year, F21.StudentCheck.In$Current_Emotion)

#Examine the joint probability table for the Year-Emotion contingency table.
#If a student is chosen at random, what is their likely year and emotional state?
prop.table(yr_emo)
#The highest joint probability is for a stressed out senior (19%), so this is the most
#likely combination.

#Use either RowSums and ColSums or outcome tables
#to examine individual probabilities for each emotion and each year. Outcome tables
#are the simplest, so here are examples for each variable:
prop.table(table(F21.StudentCheck.In$Year))
prop.table(table(F21.StudentCheck.In$Current_Emotion))

#Now let's explore students' year and primary stressor with a frequency contingency 
yr_stressor <- table(F21.StudentCheck.In$Year, F21.StudentCheck.In$Primary_Stressor_Simple)
yr_stressor

#as well as a joint probability table
prop.table(yr_stressor)

#Conditional Probability using the margin argument.
#Of the students in each year, which stressors are most often reported as primary?
prop.table(yr_stressor, margin=1)
#The top 3 stressors for juniors are, in order: coursework, applications & relationships.
#The top 3 for seniors are: Coursework, applications & relationships
#The top stressor for sophomores is new living situation.

#Now let's see which year is most common by stressor: 
prop.table(yr_stressor, margin=2)
#Of those concerned about applications, 65% are seniors and 35% are juniors.
#Of those concerned about coursework, 71% are seniors and 29% are juniors. 
#Of those concerned about finances, 50% are seniors and 50% are juniors, and
#the same holds true for grief and relationships. 

#We can also examine these questions based on transfer status. Try this out as practice.
#Be sure to take the time to determine what your results mean and not just your
#ability to run the code in R.
