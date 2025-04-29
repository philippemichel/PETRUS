

#  ------------------------------------------------------------------------
#
# Title : Randomisation des relectures
#    By : PhM
#  Date : 2025-04-24
#
#  ------------------------------------------------------------------------

# Table de randomisation des relecture afin d'avoir un tirage aléatoire pour deux relecteurs sur trois participants par examen.


# 1. Chargement des packages ------------------------------------------------
library(tidyverse)
library(readODS)
# 2. Creation de la table ---------------------------------------------------

rr <- c("Dr Al Tabaa, Dr Espita", "Dr Al Tabaa, Dr Ottaviani", "Dr Espita, Dr Ottaviani")
n <- 40
zz <- sample(rr,n,replace = T)
nn <- 1:n
zz <- as.factor(zz)
zz <- tibble(nn,zz)
names(zz) <- c("num_patient", "relecteurs")

# write_ods(zz, path = "relecteurs.ods", sheet = "relecteurs")

centres <- tibble(nn)

for(centre in 1:9){
  nom <- paste0("Centre 0",centre)
  if (centre == 1){zz <- rep("Dr Espita, Dr Ottaviani",n)}
  else{
      if (centre == 7){zz <- rep("Dr Al Tabaa, Dr Ottaviani",n)}
    else{
      if (centre == 9){zz <- rep("Dr Al Tabaa, Dr Espita",n)}
      else{zz <- sample(rr,n,replace = T)}}}
 zz <- as.factor(zz)
 zz <- tibble(zz)
 names(zz) <- nom
 centres <- cbind(centres,zz)
}



