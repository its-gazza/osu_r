require(osur)

test_that("Beatmap api", {
  # Set up API + beatmap info
  osu_api <- Sys.getenv("osu_api")
  bm_info <- get_beatmap(beatmap_id = 1944412, api_key = osu_api)

  expect_equal(bm_info$beatmap_id, "1944412")
  expect_warning(get_beatmap(beatmap_id = "abcd", osu_api))
  expect_warning(get_beatmap("1944412", "weird_api"))
  expect_warning(get_beatmap("194412"))
})

test_that("User api", {
  osu_api <- Sys.getenv("osu_api")
  user <- "thematrixk"
  user_info <- get_user(
    user = "thematrixk",
    api_key = osu_api,
    string = TRUE
  )

  expect_equal(tolower(user_info$username), user)
  expect_warning(get_user("thematrix", osu_api, string = FALSE, id = FALSE)) # No identifier used
  expect_warning(get_user("thematrix", osu_api, string = FALSE, id = FALSE)) # conflicting identifier used
  expect_warning(get_user("thematrix", string = FALSE, id = FALSE)) # No identifier used
  expect_warning(get_user("thematrix", id = TRUE)) # No identifier used
  expect_warning(get_user("thematrixk", 123, string = TRUE, id = FALSE)) # Incorrect api
  expect_warning(get_user("thematrixk", osu_api, id = TRUE, string = TRUE)) # Incorrect type
  expect_warning(get_user("somerandomname", osu_api, id = TRUE))
})
