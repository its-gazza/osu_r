require(osur)

test_that("Beatmap api", {
  osu_api <- Sys.getenv('osu_api')
  bm_info <- get_beatmap(beatmap_id = 1944412, api_key = osu_api)

  print(bm_info$beatmap_id)
  expect_equal(bm_info$beatmap_id, '1944412')
  expect_warning(get_beatmap(beatmap_id = 'abcd', osu_api))
  expect_warning(get_beatmap('1944412', 'weird_api'))
})

test_that("User api", {
  osu_api <- Sys.getenv('osu_api')
  user <- 'thematrixk'
  user_info <- get_user(user = 'thematrixk',
                        api_key = osu_api,
                        type = 'string')

  expect_equal(tolower(user_info$username), user)
  expect_warning(get_user('thematrixk', 123, 'string')) # Incorrect api
  expect_warning(get_user('thematrixk', osu_api, 'id')) # Incorrect type
})
