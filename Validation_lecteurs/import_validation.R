#  ------------------------------------------------------------------------
#
# Title : Import validation des lecteurs
#    By : PhM
#  Date : 2025-10-23
#
#  ------------------------------------------------------------------------


# Nombre de feuilles - À remplir !!!!
nsh <- 2
#
import_val <- function(sh) {
  nom <- read_ods("datas/validation.ods", sheet = sh, range = "C4:C5", col_names = FALSE)
  lect <- read_ods("datas/validation.ods", sheet = sh, range = "B11:E22", col_names = FALSE)
  exp <- read_ods("datas/validation.ods", sheet = sh, range = "R11:U22", col_names = FALSE)
  dif <- abs(lect - exp)
  names(dif)[1:4] <- c("nf_dt", "gn_dt", "nf_gch", "gn_gch")
  #
  nf <- c(dif$nf_dt, dif$nf_gch)
  gn <- c(dif$gn_dt, dif$gn_gch)
  nom <- rep(paste0(nom[1, 1], " (c", nom[2, 1], ")"), length(nf))
  ll <- tibble(nom = nom, nerf = nf, gaine = gn)
  return(ll)
}
#
val <- NULL
for (sh in 1:nsh) {
  ll <- import_val(sh)
  val <- bind_rows(val, ll)
}
#
var_label(val$nom) <- "Lecteur"
var_label(val$nerf) <- "Nerf optique (mm)"
var_label(val$gaine) <- "Gaine du nerf optique (mm)"

save(val, file = "datas/validation.RData")
load("datas/validation.RData")
