
###################
library(readxl)
#library(here)
rm(list=ls())
source("mdl/define.scenario.r"); source("mdl/landscape.dyn.r")  
scenarios <- read_xlsx("Scenarios2.xlsx", sheet="Feuil1")
i=10
for (i in 1:4) {

scn.name <-scenarios$No[i] # paste(scenarios$No[i],"C", sep="")
define.scenario(scn.name)
nrun <-  scenarios$nrun[i]
time.horizon <- 80
write.maps <-  FALSE
plot.fires <-  FALSE
is.wildfires <- scenarios$Fire[i] =="Y"  
is.clearcut <-  scenarios$Harvest[i] =="Y" 
is.partialcut <-  scenarios$Harvest[i] =="Y" 
is.fuel.modifier <-  1
is.clima.modifier <-  1
clim.scn <- scenarios$rcp[i]#  "rcp45"
replanif <- scenarios$replanning[i] == "Y"# TRUE
th.small.fire <-  50
wflam <-  0.7
wwind <-  0.3
pigni.opt <-  "rand"
target.old.pct <-  0
a.priori <- 1-scenarios$a.priori[i]
salvage.rate.FMU <- scenarios$Prop.salv[i] # 0.2
scn.art <-  i
persist <- scenarios$persist[i] #"no.pers"


# Write the name of any updated parameter in the following call
dump(c("nrun", "time.horizon","write.maps","plot.fires", "is.wildfires","is.clearcut",
       "is.partialcut","is.fuel.modifier","is.clima.modifier","clim.scn","replanif",
       "th.small.fire","wflam","wwind","pigni.opt","target.old.pct","a.priori","salvage.rate.FMU",
       "scn.art","persist"), 
     paste0("outputs/", scn.name, "/scn.custom.def.r"))
# Run this scenario (count the time it takes)
system.time(landscape.dyn(scn.name))

 
}

