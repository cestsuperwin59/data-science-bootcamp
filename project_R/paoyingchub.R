paoyingchub <- function (){
  print("============================================================")
  print("===============Welcome to Pao Ying Chub Game================")
  print("==Choose one of 'ROCK','SCISSOR','PAPER' againt our hand====")
  print("=========Instruction: type R, S, or P ======================")
  print("============================================================")
  
  options <-c("R","S","P")
  
  rounds <- 0
  score <- 0
  tie <- 0

  while(TRUE){
    user <- readline("Your Choose: ")
    com_hand <- sample(options,1)
    print("PAOOO YINGGGGGGGG CHUB!!!!")
    
    if(toupper(user) != "R" & toupper(user) != "S" & toupper(user) != "P" & toupper(user) != "EXIT"){
      print("Please select only R, S, P ")
    }else if (toupper(user) == "EXIT"){
      print("============Thank you for coming! Bye Bye===============")
      print("============Your Statistics=============================")
      print(paste("###Total round: ####", rounds))
      print(paste("###Your score: ####", score))
      print(paste("###Total Tie: ####", tie))
      if (rounds != 0) {
        (score/(rounds-tie)) * 100 -> win_rate
        print(paste("Your Win Rate:", win_rate, "%"))
      } else {
        print("Your Win Rate: Unidentified! (Please played the game?)")
      }
      break
    }else{
      print(paste("AI choose", com_hand)) 
      if ((toupper(com_hand) == "R" & toupper(user) == "S") | (toupper(com_hand) == "S" & toupper(user) == "P") | (toupper(com_hand) == "P" & toupper(user) == "R")){
        rounds <- rounds + 1
        score <- score + 0
        tie <- tie + 0
        print("Sorry! You lose this round.")
      }else if (toupper(com_hand) == toupper(user)) {
        rounds <- rounds + 1
        score <- score + 0
        tie <- tie + 1
        print("Hmm draw again, I guess.")
      } else {
        rounds <- rounds + 1
        score <- score + 1
        tie <- tie + 0
        print("** Wow! you're lucky! **")
      }
    }
  }
}
paoyingchub()    
   

