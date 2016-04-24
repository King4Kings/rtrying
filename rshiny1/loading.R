library(tidyr)
library(readr)
library(ggplot2)
library(data.table)
filename <- "../../rdata/issues.csv"
#filename()

issues <- read_csv(file=filename,trim_ws = TRUE,col_names = TRUE,na = c("NA","0"))
issues <- separate(issues ,`Discovered Test Process`,c("DiscoveredJ","Discovered"),sep = "/")
issues <- separate(issues ,`Cause Classification`,c("Cause","CauseJ"),sep = "/")
issues <- separate(issues ,`Function Category`,c("Function","FunctionJ"),sep = "/")
issues$`Due date`[issues$`Due date`=="" & issues$Status!="Closed"] <- format(Sys.Date(), "%m/%d/%Y")
issues <- as.data.table(issues)


View(issues)

issues$Project
#ggplot(diamonds,aes(x=carat,y=price,color=clarity)) + geom_point()
#problems(read_csv(file=filename))

#melt