
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Code Challenges

#### 1\. Simple decision tree

Example taken from Hazen (2014). Competing cancer and AIDS risks
decision tree. Assume discrete time of single years. An individual
starts in the `Well` state. They can transition into `Dead`, `Cancer &
AIDS`, `Cancer`, `AIDS` or remain in the `Well` state.

Event probabilities are

  - ![\\delta\_0 = 1.182
    \\times 10^{-3}](https://latex.codecogs.com/png.latex?%5Cdelta_0%20%3D%201.182%20%5Ctimes%2010%5E%7B-3%7D
    "\\delta_0 = 1.182 \\times 10^{-3}"): Die from other causes
  - ![\\delta\_c
    = 0.025](https://latex.codecogs.com/png.latex?%5Cdelta_c%20%3D%200.025
    "\\delta_c = 0.025"): Die from recurent prostate cancer
  - ![\\delta\_a
    = 0.080](https://latex.codecogs.com/png.latex?%5Cdelta_a%20%3D%200.080
    "\\delta_a = 0.080"): Die from AIDS
  - ![\\beta\_c
    = 0.0027](https://latex.codecogs.com/png.latex?%5Cbeta_c%20%3D%200.0027
    "\\beta_c = 0.0027"): Cancer recurs
  - ![\\beta\_a
    = 0.0083](https://latex.codecogs.com/png.latex?%5Cbeta_a%20%3D%200.0083
    "\\beta_a = 0.0083"): Develop AIDS

#### 2\. Markov-cycle tree

<img src="figs/markov_cycle_tree.png" width="75%" />

#### 3\. Discrete-time Markov model

<img src="man/figures/README-unnamed-chunk-2-1.png" width="75%" />

##### Calculate mean QALYs

Calculate cumulative proportion of patient cycles in each state and take
product with health utilities for each respectively.

Define the state utilities
![R(\\cdot)](https://latex.codecogs.com/png.latex?R%28%5Ccdot%29
"R(\\cdot)"):

  - `Well`: 1.0
  - `Cancer`: 0.60
  - `AIDS`: 0.50
  - `Cancer & AIDS`: 0.30
  - `Dead`: 0

#### 4\. One-cycle Markov-cycle tree

We can rearrange the Markov-cycle tree to closer resemble to Markov
model by collapsing the branches into a single cycle and simply
combining the probabilities.

<img src="figs/onecycle_markovcycletree.png" width="65%" />

#### 6\. Roll back Markov-cycle tree

We can calculate the mean QALYs using the markov-cycle tree
representation without calculating the cumulative proportion of time of
patient cycles in each health state. This is done by rolling back using
the recursive equation ([value
iteration](https://en.wikipedia.org/wiki/Markov_decision_process#Value_iteration)):

  
![
V\_n(i) = R(i) + \\sum\_j p\_{ij} V\_{n-1}(j)
](https://latex.codecogs.com/png.latex?%0AV_n%28i%29%20%3D%20R%28i%29%20%2B%20%5Csum_j%20p_%7Bij%7D%20V_%7Bn-1%7D%28j%29%0A
"
V_n(i) = R(i) + \\sum_j p_{ij} V_{n-1}(j)
")  

#### 5\. Roll back stochastic tree

So far we have only considered discrete time. The Markov-cycle tree
representation can be extended to continuous time as a *stochastic
tree*. Probabilities are now replaced by rates. This change is
represented by zigzag lines in the diagrams. This is clearly a more
compact representation.

We can calculate mean QALY in an analogous way to the discrete-time case
by rolling back using the recursive equation:

  
![
V(S) = \\frac{R(i)}{\\sum\_j \\lambda\_j} + \\sum\_j p\_j V(S\_j)
](https://latex.codecogs.com/png.latex?%0AV%28S%29%20%3D%20%5Cfrac%7BR%28i%29%7D%7B%5Csum_j%20%5Clambda_j%7D%20%2B%20%5Csum_j%20p_j%20V%28S_j%29%0A
"
V(S) = \\frac{R(i)}{\\sum_j \\lambda_j} + \\sum_j p_j V(S_j)
")  

<img src="figs/stochastic_tree.png" width="75%" />

  - `Cancer`: ![\\lambda\_c
    = 0.03250](https://latex.codecogs.com/png.latex?%5Clambda_c%20%3D%200.03250
    "\\lambda_c = 0.03250")/year
  - `AIDS`: ![\\lambda\_a
    = 0.10](https://latex.codecogs.com/png.latex?%5Clambda_a%20%3D%200.10
    "\\lambda_a = 0.10")/year
  - `Dead from Cancer`: ![\\mu\_c
    = 0.3081](https://latex.codecogs.com/png.latex?%5Cmu_c%20%3D%200.3081
    "\\mu_c = 0.3081")/year
  - `Dead from AIDS`: ![\\mu\_a
    = 0.9970](https://latex.codecogs.com/png.latex?%5Cmu_a%20%3D%200.9970
    "\\mu_a = 0.9970")/year
  - `Dead other`: ![\\mu\_0
    = 0.014191](https://latex.codecogs.com/png.latex?%5Cmu_0%20%3D%200.014191
    "\\mu_0 = 0.014191")/year

### References

<div id="refs" class="references">

<div id="ref-Hazen2014">

Hazen, Gordon B. 2014. “Stochastic Trees : A New Technique for Temporal
Medical Decision Modeling,” no. August 1992.
<https://doi.org/10.1177/0272989X9201200302>.

</div>

</div>
