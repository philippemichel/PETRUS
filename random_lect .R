

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

rr <- c("AB", "AC", "BC")
zz <- sample(rr,210,replace = T)
nn <- 1:210
zz <- as.factor(zz)
zz <- tibble(nn,zz)
names(zz) <- c("num_patient", "relecteurs")

write_ods(zz, path = "relecteurs.ods", sheet = "relecteurs")
