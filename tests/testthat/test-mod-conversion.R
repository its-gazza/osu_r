require(osur)

test_that("AR Convert", {
  # AR value from here: https://osu.ppy.sh/help/wiki/Beatmap_Editor/Song_Setup
  # No mod
  for (i in 1:10) {
    expect_equal(convert_ar(i, 0), i)
  }

  # HT
  expect_equal(convert_ar(0, 256), -5)
  expect_equal(convert_ar(1, 256), -3.67)
  expect_equal(convert_ar(2, 256), -2.33)
  expect_equal(convert_ar(3, 256), -1)
  expect_equal(convert_ar(4, 256), 0.33)
  expect_equal(convert_ar(5, 256), 1.67)
  expect_equal(convert_ar(6, 256), 3.33)
  expect_equal(convert_ar(7, 256), 5)
  expect_equal(convert_ar(8, 256), 6.33)
  expect_equal(convert_ar(9, 256), 7.67)
  expect_equal(convert_ar(10, 256), 9)

  # HT+HR
  expect_equal(convert_ar(0, 272), -5)
  expect_equal(convert_ar(1, 272), -3.13)
  expect_equal(convert_ar(2, 272), -1.27)
  expect_equal(convert_ar(3, 272), 0.6)
  expect_equal(convert_ar(4, 272), 2.67)
  expect_equal(convert_ar(5, 272), 5)
  expect_equal(convert_ar(6, 272), 6.87)
  expect_equal(convert_ar(7, 272), 8.73)
  expect_equal(convert_ar(8, 272), 9)
  expect_equal(convert_ar(9, 272), 9)
  expect_equal(convert_ar(10, 272), 9)

  # EZ
  for (sel_ar in 0:10) {
    expect_equal(convert_ar(sel_ar, 2), sel_ar / 2)
  }

  # HR
  for (sel_ar in 0:10) {
    expect_equal(convert_ar(sel_ar, 16), min(1.4 * sel_ar, 10))
  }

  # DT+EZ
  expect_equal(convert_ar(0, 66), 5)
  expect_equal(convert_ar(1, 66), 5.27)
  expect_equal(convert_ar(2, 66), 5.53)
  expect_equal(convert_ar(3, 66), 5.8)
  expect_equal(convert_ar(4, 66), 6.07)
  expect_equal(convert_ar(5, 66), 6.33)
  expect_equal(convert_ar(6, 66), 6.6)
  expect_equal(convert_ar(7, 66), 6.87)
  expect_equal(convert_ar(8, 66), 7.13)
  expect_equal(convert_ar(9, 66), 7.4)
  expect_equal(convert_ar(10, 66), 7.67)

  # DT
  expect_equal(convert_ar(0, 64), 5)
  expect_equal(convert_ar(1, 64), 5.53)
  expect_equal(convert_ar(2, 64), 6.07)
  expect_equal(convert_ar(3, 64), 6.6)
  expect_equal(convert_ar(4, 64), 7.13)
  expect_equal(convert_ar(5, 64), 7.67)
  expect_equal(convert_ar(6, 64), 8.33)
  expect_equal(convert_ar(7, 64), 9)
  expect_equal(convert_ar(8, 64), 9.67)
  expect_equal(convert_ar(9, 64), 10.33)
  expect_equal(convert_ar(10, 64), 11)

  # DT + HR
  expect_equal(convert_ar(0, 80), 5)
  expect_equal(convert_ar(1, 80), 5.747, tolerance = 0.01)
  expect_equal(convert_ar(2, 80), 6.493, tolerance = 0.01)
  expect_equal(convert_ar(3, 80), 7.24)
  expect_equal(convert_ar(4, 80), 8.07)
  expect_equal(convert_ar(5, 80), 9)
  expect_equal(convert_ar(6, 80), 9.93)
  expect_equal(convert_ar(7, 80), 10.87)
  expect_equal(convert_ar(8, 80), 11)
  expect_equal(convert_ar(9, 80), 11)
  expect_equal(convert_ar(10, 80), 11)
})

test_that("BPM Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_bpm <- runif(1, 0, 1000)
    expect_equal(convert_bpm(rnd_bpm, 0), rnd_bpm)
  }

  # Test HT
  for (i in 1:ITERATION) {
    rnd_bpm <- runif(1, 0, 1000)
    expect_equal(convert_bpm(rnd_bpm, 256), rnd_bpm * (3 / 4))
  }

  # Test DT
  for (i in 1:ITERATION) {
    rnd_bpm <- runif(1, 0, 1000)
    expect_equal(convert_bpm(rnd_bpm, 64), rnd_bpm * (3 / 2))
  }
})

test_that("Drain Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_drain <- runif(1, 0, 10)
    expect_equal(convert_drain(rnd_drain, 0), rnd_drain)
  }

  # Test HR
  for (i in 1:ITERATION) {
    rnd_drain <- runif(1, 0, 10)
    expect_equal(convert_drain(rnd_drain, 16), min(rnd_drain * 1.4, 10))
  }

  # Test EZ
  for (i in 1:ITERATION) {
    rnd_drain <- runif(1, 0, 10)
    expect_equal(convert_drain(rnd_drain, 2), rnd_drain / 2)
  }
})

test_that("Hit Length Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_length <- runif(1, 0, 1000)
    expect_equal(convert_hit_length(rnd_length, 0), rnd_length)
  }

  # Test HT
  for (i in 1:ITERATION) {
    rnd_length <- runif(1, 0, 1000)
    expect_equal(convert_hit_length(rnd_length, 256), rnd_length * (3 / 4))
  }

  # Test DT
  for (i in 1:ITERATION) {
    rnd_length <- runif(1, 0, 1000)
    expect_equal(convert_hit_length(rnd_length, 64), rnd_length * (3 / 2))
  }
})

test_that("Total Length Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_length <- runif(1, 0, 1000)
    expect_equal(convert_total_length(rnd_length, 0), rnd_length)
  }

  # Test HT
  for (i in 1:ITERATION) {
    rnd_length <- runif(1, 0, 1000)
    expect_equal(convert_total_length(rnd_length, 256), rnd_length * (3 / 4))
  }

  # Test DT
  for (i in 1:ITERATION) {
    rnd_length <- runif(1, 0, 1000)
    expect_equal(convert_total_length(rnd_length, 64), rnd_length * (3 / 2))
  }
})

test_that("Drain Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_drain <- runif(1, 0, 10)
    expect_equal(convert_drain(rnd_drain, 0), rnd_drain)
  }

  # Test HR
  for (i in 1:ITERATION) {
    rnd_drain <- runif(1, 0, 10)
    expect_equal(convert_drain(rnd_drain, 16), min(rnd_drain * 1.4, 10))
  }

  # Test EZ
  for (i in 1:ITERATION) {
    rnd_drain <- runif(1, 0, 10)
    expect_equal(convert_drain(rnd_drain, 2), rnd_drain / 2)
  }
})

test_that("Overall Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_overall <- runif(1, 0, 10)
    expect_equal(convert_overall(rnd_overall, 0), rnd_overall)
  }

  # Test HR
  for (i in 1:ITERATION) {
    rnd_overall <- runif(1, 0, 10)
    expect_equal(convert_overall(rnd_overall, 16), min(rnd_overall * 1.4, 10))
  }

  # Test EZ
  for (i in 1:ITERATION) {
    rnd_overall <- runif(1, 0, 10)
    expect_equal(convert_overall(rnd_overall, 2), rnd_overall / 2)
  }
})

test_that("Size Convert", {
  # Test no mod
  ITERATION <- 1000
  for (i in 1:ITERATION) {
    rnd_size <- runif(1, 0, 10)
    expect_equal(convert_size(rnd_size, 0), rnd_size)
  }

  # Test HR
  for (i in 1:ITERATION) {
    rnd_size <- runif(1, 0, 10)
    expect_equal(convert_size(rnd_size, 16), min(rnd_size * 1.3, 10))
  }

  # Test EZ
  for (i in 1:ITERATION) {
    rnd_size <- runif(1, 0, 10)
    expect_equal(convert_size(rnd_size, 2), rnd_size / 2)
  }
})
