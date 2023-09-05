new_chatbot <- function(){
  
  print("Lisa: Hello, I am Lisa Chatbot")
  username <- readline("What's your name?: ")
  
  print(paste("How can I help you for today:", username))
  print(paste("Here is the list that I can help you:", username ))
  
  help_list <- list(c("1.Abonement","2.Mobil_number","3.Contact staff"))
  print(help_list)
  
  help_list <- readline("please type number here: ")
  
    if(help_list == "1"){
      print("We have Plan A, Plan B, Plan C")
      print("You can check more details from www.mobil.no/plans")
    }else if (help_list == "2"){
      print ("You can check our number from : www.mobil.no/number")
      print("Thank you for using our chatbot")
    }else if (help_list == "3"){
          contact_num <- readline("What is your number? Our staff will contact you back in 15 min: ")
          print(paste("GREAT, This is your number:", contact_num))
          print("Type 'OK' to confirm or 'NO' to quit the program")
          
          decision <- readline("")
          if (decision == "NO") {
            print("Thank you. Hope to see you soon!")
          } else if (decision == "OK") {
            print(paste("OK, This is your number:", contact_num, "#Our staff will contact you soon"))
            print("Thank you for using the chatbot")
          } else {
            print("Thank you for using the chatbot")
            next
          }
    }
    else {
      print("Thank you for using Chatbot.")
      next
    }
}
