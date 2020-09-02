library(tagtales)

load("tag_tale_test_df.rda")

# Should work with either characters or columns
a = tag_tales(tag_tale_test_df, "TagID", "GroupedStn", "DateTimePST")
b = tag_tales(tag_tale_test_df, tag_tale_test_df$TagID, tag_tale_test_df$GroupedStn, "DateTimePST")

stopifnot(all.equal(a,b))

stopifnot(nrow(a) == 5)
