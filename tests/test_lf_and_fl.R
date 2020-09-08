# test last_first and first_last

# test data has 2 tags; 2881 only detected at a single station, 2487 has a bunch of detections at its last station (BCN).

# last_first should return BCN/2012-03-23 01:45:37 for 2847

library(tagtales)
load("tests/first_last_test_data.rda")

lf = last_first(chk, "TagID", "DateTimePST", "GroupedStn")

fl = first_last(chk, "TagID", "DateTimePST", "GroupedStn")


stopifnot(lf$last_arrival[lf$TagID == 2847] == as.POSIXct("2012-03-23 01:45:37", format = "%Y-%m-%d %H:%M:%S", tz = "Pacific/Pitcairn"))

stopifnot(all.equal(range(chk$DateTimePST[chk$TagID == 2881])[1], 
                    fl$first_det[fl$TagID == 2881], 
                    lf$first_det[lf$TagID == 2881]))

stopifnot(all.equal(range(chk$DateTimePST[chk$TagID == 2881])[2],
                      fl$last_det[fl$TagID == 2881],
                      lf$last_arrival[lf$TagID == 2881]))
