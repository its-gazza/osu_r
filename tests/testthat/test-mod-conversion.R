require(osur)

test_that("AR Convert", {
    sel_ar <- 9
    expect_equal(sel_ar, convert_ar(sel_ar, 0))
    expect_equal(sel_ar, convert_ar(sel_ar, 256))
})
