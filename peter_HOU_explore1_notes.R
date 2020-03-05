library(retrosheet)

## get the play-by-play data at Houston. These are all HOU home games 
dat.hou.home.play <- getRetrosheet(type = "play", year = 2016, team = "HOU")

game.num   <- 1
game.plays <- dat.hou.home.play[[game.num]]$play
game.plays

# Notes on format from retrosheet site:

# In: https://www.retrosheet.org/eventfile.htm#8  See also: https://www.retrosheet.org/location.htm
# Events made by the batter at the plate (play field)
# S$ single
# D$ double
# T$ triple
# A hit (excepting a home run) is indicated by one of S, D and T optionally followed by the fielder, $, initially handling the ball. If more than one fielder handles the ball the appropriate sequence of fielders is given. The fielder designation is omitted if that information is not known. The batter advance to the designated base is implicit.
# 
# play,8,0,pacit001,??,,S7
# is a minimal coding of a single showing that the left fielder first handled the ball. The ?? in the count field indicates the count at the time of the hit is unknown.
# 
# play,2,1,santn001,12,CFBX,D7/G5.3-H;2-H;1-H
# codes a bases loaded double fielded by the left fielder, a modifier showing the hit location code and advances for each of the base runners.
# 
# play,3,0,raint001,11,CBX,T9/F9LD.2-H
# describes a triple to right field, a hit location and a runner on second scoring.

# H or HR is the code for a home run leaving the park. The location modifier can be used to indicate where the ball left the playing field.
# 
# play,8,0,bellg001,21,CBBX,H/L7D
# indicates a solo home run into left field.
# 
# play,12,1,bichd001,02,FFFX,HR/F78XD.2-H;1-H
# shows a home run into center field with the runners on first and second scoring.
# 
# H$ or HR$ indicates an inside-the-park home run by giving a fielder as part of the code.
# 
# play,4,0,younr001,32,FBFFFBBX,HR9/F9LS.3-H;1-H

# play column
# first parse by /
# take element and parse it by character, NEEDED TO SEARCH FOR A STRING WITHIN??
# if we parse, examine if any of the hit codes appear. Problems w/ H and HR?? Looks like if hitcode appears, it should be the first character (except for HR??)

# Examine play only if team = "0"
hit.cods <- c("S", "D", "T", "H", "HR")

game.plays
play.num               <- 87
play                   <- game.plays[play.num,6]
play

play.portion1          <- strsplit(play, "/")[[1]][1] # play string portion 1 (there can be up to 3). See: https://www.retrosheet.org/eventfile.htm Event field play record
play.portion1

play.portion1.char.cod <- gsub("[[:digit:]]", "", play.portion1)
play.portion1.char.cod

hitQ <- play.portion1.char.cod %in% hit.cods
hitQ

pitch <- game.plays[play.num,5] # pitch string
pitch
grepl("X", pitch) # X means ball put into play. So we should get TRUE if there is a hit code
