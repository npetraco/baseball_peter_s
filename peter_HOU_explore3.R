library(tidyverse)

#hits <- read.csv("/home/npetraco/latex/papers/baseball_peter_s/HOU.home.season.hits2.csv")
hits <- read.csv("C:/Users/aliso/latex/baseball_peter/HOU.home.season.hits2.csv")
hits

# Now let use add some fields
# I had to change pitches to a character field to count length
# I added a field l.pitches for the lenth of the pitching field entry.
# Using Tidyverse commands to try to learn them 

hitsm <- hits %>% mutate(pitches = as.character(pitches), l.pitches = nchar(pitches))
head(hitsm)

#Now simple summary of counts

# Summary of counts of hits
hitsm %>% group_by(hit.cod) %>% summarise(n=n())

#Summary of average length of pitch sequnce by pitch type
hitsm %>% group_by(hit.cod) %>% summarise(mean(l.pitches))

filter(hitsm, hit.cod=="S")
arrange(hitsm, l.pitches)
arrange(hitsm, desc(l.pitches))
select(hitsm, retroID, pitches)
select(hitsm, retroID)[,1]
select(hitsm, -retroID)

# Peter:
# Try this. The mean  length of the HR sequences averages are longer than S, D, T.  
# Does this hold with more data? Is it significant? I don't see any reason why this would be true. 
# But you could probably run it through all at bats for all teams. 

# In a given game, HR seq lengs vs S, D, T seq lengs??
# Average over games?
# Just go down the whole season?
