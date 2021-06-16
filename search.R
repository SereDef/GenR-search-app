
# 

searchselection <- function(t, subj = 'any', timeframe = 'any', keyword = "") {
  if (timeframe[1] == "Prenatal" & timeframe[2] == '17y') {
    times = colnames(t)[2:length(colnames(t))]
  } else if (timeframe[1] == timeframe[2]){
    times = c(timeframe[1])
  } else if (timeframe[1] != timeframe[2]){
    times = colnames(t)[which(colnames(t) == timeframe[1]):which(colnames(t) == timeframe[2])]
  }
  outt = t[, c('Measurement', times)]
  
  newx = c()
  
  sel = ifelse(subj == 1, 'C', ifelse(subj == 2, 'M', 'P'))
  
  for (i in as.numeric(rownames(outt))) {
    if (any(mapply(grepl, sel, outt[i, times], ignore.case = F))) {
        newx <- c(newx, i) 
    }  
  }
  
  if (subj != 'any') { outt = outt[newx, ] }
  
  if (keyword != "") { outt = outt[which(mapply(grepl, keyword, outt$Measurement, ignore.case = T)), ] }
    
  return(outt)
}
