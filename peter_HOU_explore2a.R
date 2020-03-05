library(retrosheet)

# We are interested in if a HOU player hit a ball into play. These would do that:
hit.cods <- c("S", "D", "T", "H", "HR")

## get the play-by-play data at Houston. These are all HOU home games 
dat.hou.home.play <- getRetrosheet(type = "play", year = 2016, team = "HOU")
num.games         <- length(dat.hou.home.play)

# Loop over games. Loop over plays
season.hit.mat <- NULL
for(i in 1:num.games) {
  game.num   <- i
  game.plays <- dat.hou.home.play[[game.num]]$play
  num.plays  <- nrow(game.plays)
  
  game.hit.mat <- NULL
  for(j in 1:num.plays){
    play.num <- j
    inning   <- game.plays[play.num,1]
    homeQ    <- game.plays[play.num,2] # To Examine play only if team = "0" (home)
    if(homeQ == "0") {
      play                   <- game.plays[play.num,6]
      play.portion1          <- strsplit(play, "/")[[1]][1]            # play string portion 1 (there can be up to 3). See: https://www.retrosheet.org/eventfile.htm Event field play record
      play.portion1.char.cod <- gsub("[[:digit:]]", "", play.portion1) # Hit type if there is one
      hitQ                   <- play.portion1.char.cod %in% hit.cods   # Check if there was a hit
      
      pitch         <- game.plays[play.num,5] # pitch string
      ball.in.playQ <- grepl("X", pitch) # X means ball put into play. So we should get TRUE if there is a hit code
      
      if(hitQ == TRUE) {
        play.hit.info <- c(i, game.plays[play.num,3], inning, play.portion1.char.cod, pitch, ball.in.playQ, ball.in.playQ == hitQ)
        #print(play.hit.info)
        game.hit.mat <- rbind(game.hit.mat, play.hit.info)
      }
      
    }
    
  }
  season.hit.mat <- rbind(season.hit.mat, game.hit.mat)
  
}
colnames(season.hit.mat) <- c("game.num","retroID", "inning", "hit.cod", "pitches", "ball.in.playQ", "play.hit.consistent?")
rownames(season.hit.mat) <- NULL
season.hit.mat
