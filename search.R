
# 

searchselection <- function(t, subj = 'any', timeframe = 'any', keyword = "") {
  if (timeframe[1] != timeframe[2]) {
    times = colnames(t)[which(colnames(t) == timeframe[1]):which(colnames(t) == timeframe[2])]
  } else if (timeframe[1] == timeframe[2]){
    times = c(timeframe[1])
  }
  outt = t[, c('Measurement', times)]
  
  newx = c()
  sel = c()
  
  if (any(mapply(grepl, c('Self.reports...ancestry...c..Child'), subj, ignore.case = F))) { sel <- c(sel, 'Cs') }
  if (any(mapply(grepl, c('Main.caregiver.reports...ancestry...c..Child'), subj, ignore.case = F))) { sel <- c(sel, 'Cm') }
  if (any(mapply(grepl, c('Teacher.reports...ancestry...c..Child'), subj, ignore.case = F))) { sel <- c(sel, 'Ct') }
  if (any(mapply(grepl, 'Questionnaires...ancestry....Mothers', subj, ignore.case = F)))  { sel <- c(sel, 'M') }
  if (any(mapply(grepl, 'Questionnaires...ancestry....Partners', subj, ignore.case = F))) { sel <- c(sel, 'P') }
  
  for (i in as.numeric(rownames(outt))) {
    for (s in sel){
      if (any(mapply(grepl, s, outt[i, times], ignore.case = F))) {
        newx <- c(newx, i) 
      } 
    }
  }
  
  if (length(subj) < 25) { outt = outt[unique(newx), ] }
  
  pos <- c()
  
  if (keyword != "") { 
    kws <- strsplit(keyword, ";")[[1]]
    for (k in kws) {
      pos <- c(pos, which(mapply(grepl, k, outt$Measurement, ignore.case = T))) }
    outt = outt[pos, ] 
  } 
  return(outt)
}
