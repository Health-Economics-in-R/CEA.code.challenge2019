#
# code challenge solutions
# N Green
#


delta0 <- 0.001182
deltac <- 0.025
deltaa <- 0.08
betac <- 0.0027
betaa <- 0.0083

# dead, cancer & AIDS, cancer, AIDS, well

p_dead <- c(1,0,0,0,0)

p_CA <-
  c(delta0 + (1-delta0)*deltac + (1-delta0)*(1-deltac)*deltaa, (1-delta0)*(1-deltac)*(1-deltaa),0,0,0)

p_cancer <-
  c(delta0 + (1-delta0)*deltac, (1-delta0)*(1-deltac)*betaa, (1-delta0)*(1-deltac)*(1-betaa),0,0)

p_AIDS <-
  c(delta0 + (1-delta0)*deltaa, (1-delta0)*betac*(1-deltaa), 0, (1-delta0)*(1-betac)*(1-deltaa), 0)

p_well <-
  c(delta0, (1-delta0)*betac*betaa, (1-delta0)*betac*(1-betaa), (1-delta0)*(1-betac)*betaa, (1-delta0)*(1-betac)*(1-betaa))


trans <- matrix(c(p_dead, p_CA, p_cancer, p_AIDS, p_well),
                nrow = 5, byrow = TRUE)

sutils <- c(0,0.3,0.6,0.5,1)
scosts <- c(0,200,100,50,0)
probs <- matrix(c(0,0,0,0,1), nrow = 1)

n_cycles <- 1000
qalys <- NULL
costs <- NULL

for (i in 1:n_cycles) {
  
  probs <- rbind(probs, probs[i, ] %*% trans)
}

for (i in 1:n_cycles) {
  
  qalys <- rbind(qalys, probs[i, ]*sutils)
  costs <- rbind(costs, probs[i, ]*scosts)
}


colSums(qalys)
colSums(costs)

total_qalys <- sum(qalys) #90.47
total_costs <- sum(costs)

