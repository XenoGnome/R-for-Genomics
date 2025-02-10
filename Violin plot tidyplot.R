library(tidyplots)

study |> 
  tidyplot(x = treatment, y = score, color = treatment, width = 55, height = 70) |> 
  add_violin(draw_quantiles = 0.5) |> 
  add_data_points_beeswarm() |>
  add_test_asterisks() |>
  add_title(title = "tidyplot test Violin" )

head(study)
