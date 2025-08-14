expt <- function(df = tt, coupe) {
  zz <- tt |>
    dplyr::select(nom, ends_with(coupe))
  names(zz) <- c("nom", "form", "a", "b", "c")
  zz |>
    rowwise() |>
    mutate(mes_exp = mean(c(a, b, c), na.rm = TRUE))
}

coupes <- c("nerf_dt", "gaine_dt", "nerf_gch", "gaine_gch")
tbdiff <- NULL
for (i in coupes) {
  zz <- expt(tt, i)
  tbdiff <- rbind(tbdiff, zz)
}
#
tbdiff <- tbdiff |>
  rowwise() |>
  mutate(valmes = if_else(abs(form - mes_exp) > 1, 0, 1))
