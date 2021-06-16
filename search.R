
# library(plot.matrix)

searchselection <- function(t, subj = 'any', reporter = 'any', timeframe = 'any', keyword = "") {
  if (length(timeframe) == 1 & timeframe[1] == 'any') {
    times = colnames(t)[2:length(colnames(t))]
  } else if (timeframe[1] == timeframe[2]){
    times = ifelse(timeframe[1] == "Prenatal", c("Prenatal"), c(timeframe[1])) 
  } else if (timeframe[1] != timeframe[2]){
    c1 = timeframe[1]
    c2 =  timeframe[2]
    times = colnames(t)[which(colnames(t) == c1):which(colnames(t) == c2)]
  }
  outt = t[, c('Measurement', times)]
  
  newx = c()
  newc = colnames(outt)[2:length(colnames(outt))]
  
  sel = ifelse(subj == 1, 'C', ifelse(subj == 2, 'M', 'P'))
  
  for (i in as.numeric(rownames(outt))) {
    if (any(mapply(grepl, sel, outt[i, newc], ignore.case = F))) {
        newx <- c(newx, i) 
    }  
  }
  
  if (subj != 'any') { outt = outt[newx, ] }
  
  if (keyword != "") { outt = outt[which(mapply(grepl, keyword, outt$Measurement, ignore.case = T)), ] }
    
  return(outt)
}
