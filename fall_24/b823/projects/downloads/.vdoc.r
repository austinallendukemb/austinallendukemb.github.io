#
#
#
#
#
#
#
#
#
#
#
#
#
knitr::opts_chunk$set(echo = TRUE)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
buildings <- read.csv(textConnection("name,address
Green Light Building,1000 Univ. Rd
Lakeview Building,1080 Univ. Rd
East Grand Complex,3810 Univ. Rd
Mountainview Building,NULL"))
rooms <- read.csv(textConnection("room,building
1001,Green Light Building
1301,East Grand Complex
1311,Lakeview Building"))
students <- read.csv(textConnection("student_id,name,room,building
20240001,Alpha Beta,1001,Green Light Building
20240002,Gamma Delta,1311,Lakeview Building"))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
write.csv(buildings, quote = FALSE, row.names = FALSE)
write.csv(rooms, quote = FALSE, row.names = FALSE)
write.csv(students, quote = FALSE, row.names = FALSE)
#
#
#
