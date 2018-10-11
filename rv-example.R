source("rv.r")

dice <- rv(1:6)
plot(dice, main = "abc")
mean(dice)

P(dice > 3)
plot(dice)
plot(dice + dice)
plot(dice + dice + dice)
plot(dice + dice + dice + dice)
