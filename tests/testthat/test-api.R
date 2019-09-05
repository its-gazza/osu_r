require(osur)

test_that("Beatmap works", {
  api <- Sys.getenv('osu_api')
  bm_info <- get_beatmap(beatmap_id = '1944412', api_key = api)
  expect_equal(bm_info$beatmap_id, '1944412')
  expect_equal(bm_info$version, "Veteran")
})
