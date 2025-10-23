zz |>
  dplyr::select(technique, nerf, gaine, id) |>
  tbl_summary(
    by = technique,
    include = -id,
    type = all_continuous() ~ "continuous2",
    statistic = all_continuous() ~ c(
      "{mean} ± {sd}",
      "{min}, {max}"
    ), ,
    missing = "no"
  ) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Nerf optique**") |>
  add_p(
    test = list(all_continuous() ~ "paired.t.test"),
    group = id
  )



dd <- tc |>
  dplyr::select(coupe, technique, expert, nfdt, gndt) |>
  mutate(id = paste0(coupe, expert, "-dt"))
names(dd) <- c("coupe", "technique", "expert", "nerf", "gaine", "id")
gg <- tc |>
  dplyr::select(coupe, technique, expert, nfgch, gngch) |>
  mutate(id = paste0(coupe, expert, "-gch"))
names(gg) <- c("coupe", "technique", "expert", "nerf", "gaine", "id")
zz <- rbind(dd, gg) |>
  pivot_longer(cols = c(nerf, gaine))


zz |>
  dplyr::select(id, technique, name, value) |>
  tbl_summary(
    by = technique,
    include = -id,
    type = all_continuous() ~ "continuous2",
    statistic = all_continuous() ~ c(
      "{mean} ± {sd}",
      "{min}, {max}"
    ),
    missing = "no"
  ) |>
  add_p(
    test = list(all_continuous() ~ "paired.t.test"),
    group = id
  )
