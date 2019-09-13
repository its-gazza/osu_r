require(osur)

test_that("Mod detection", {
  expect_equal(detect_mod(72), "HD,DT")
  expect_equal(detect_mod(576), "NC")
  expect_equal(detect_mod(16416), "PF")
  expect_equal(detect_mod(32767), "NF,EZ,TD,HD,HR,SD,DT,RX,HT,NC,FL,AP,SO,PF")
})
