form <- tt |>
  dplyr::select(id, nom, starts_with("formation")) |>
  pivot_longer(cols = 3:6, names_to = "nerf", values_to = "formation") |>
  mutate(nerf = str_sub(nerf, 11))

expert <- tt |>
  dplyr::select(id, nom, starts_with("expert")) |>
  pivot_longer(cols = 3:14, names_to = "nerf2", values_to = "experts") |>
  mutate(nerf2 = str_sub(nerf2, 10))

coupes <- c("nerf_dt", "gaine_dt", "nerf_gch", "gaine_gch")
zz <- tt |>
  dplyr::select(id, starts_with("expert"))
nc <- 14
for (nn in coupes) {
  zz <- zz |>
    rowwise() |>
    mutate(xx = mean(c_across(ends_with(nn)), na.rm = TRUE)) |>
    ungroup()
  colnames(zz)[nc] <- paste0("moy_", nn)
  nc <- nc + 1
}
expx <- zz |>
  dplyr::select(!starts_with("expert")) |>
  pivot_longer(cols = 2:5, values_to = "experts")

tot <- form |>
  right_join(expx, by = "id")
