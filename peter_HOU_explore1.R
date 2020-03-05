library(retrosheet)

## get the play-by-play data at Houston. These are all HOU home games 
dat.hou.home.play <- getRetrosheet(type = "play", year = 2016, team = "HOU")


num.home.games <- length(dat.hou.home.play)
num.home.games

# Check: HOU always home team?:
t(sapply(1:length(dat.hou.home.play), function(xx){dat.hou.home.play[[xx]]$info[2,]}))

dat.hou.home.play[[1]]$id
dat.hou.home.play[[1]]$version
dat.hou.home.play[[1]]$info
dat.hou.home.play[[1]]$start
dat.hou.home.play[[1]]$play
dat.hou.home.play[[1]]$com
dat.hou.home.play[[1]]$sub
dat.hou.home.play[[1]]$data

# for 2016/2017 Peter wants:
# Home
# Home and Away for same players
#     Length at bat
#     Number of swinging strikes
#     Length of time of game

dat.hou.home.game <- getRetrosheet(type = "game", year = 2016)
hou.game.idxs <- which(dat.hou.home.game$HmTm == "HOU")
dat.hou.home.game

# During the 2017 and 2018 seasons the organization used a video camera in center field to film 
# the opposing catchers' signs to the pitchers. Astros players or team staffers watching the live 
# camera feed behind the dugout would then signal to their batter what kind of pitch was coming.
# Reoprted in Novebmer 2019
  

#https://cran.r-project.org/web/packages/Lahman/vignettes/strikeoutsandhr.html
#https://baseballwithr.wordpress.com/2015/11/30/retrosheet-package-part-2/
#retrosheet box scores
#http://www.seanlahman.com/files/database/readme58.txt

# http://mlb.mlb.com/stats/
# What about H:
# The number of times a batter hits the ball and reaches bases safely without aid of an error or 
# fielder's choice



# Peter toughts:
# Consider hit H = 1B + 2B + 3B + HR
# Consider H per game (per player too??)
# H0: H player means remain unchanged between 2017 2018 and 2019
# Cheating only happened in HOU? Ha: Bigger difference year to year home vs away in 2017?
# Look at change in Hone vs Away for HOU in preivious years and 2017. 