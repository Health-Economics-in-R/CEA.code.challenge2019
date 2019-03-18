
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Code Challenges

The following questions are for the virtual code challenge for
participants in the [R for trial & model-based cost-effectiveness
analysis
workshop](http://www.statistica.it/gianluca/teaching/r-hta-workshop/2019/)
taking place 9 July 2019 at University College London. See the
associated [GitHub
repo](https://github.com/Health-Economics-in-R/CEA.code.challenge2019)
for more details.

#### 1\. A simple decision tree

This example is taken from Hazen (2014). The problem is concerned with a
competing risk cancer and AIDS decision tree. We will assume discrete
time of single years. An individual starts in the `Well` state. They can
transition into `Dead`, `Cancer & AIDS`, `Cancer`, `AIDS` or remain in
the `Well` state.

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

##### *C1. Define a (single year) decision tree.*

#### 2\. Markov-cycle tree

A Markov-cycle tree was introduced by Hollenberg and is a representation
of a Markov process in which the possible events taking place during
each cycle are represented by a probability tree. This is one way of
simplifying determining probabilities from multiple paths.

The diagram for the Markov-cycle tree of the example in Hazen (2014) is
given below.

<img src="figs/markov_cycle_tree.png" width="75%" />

The terminal state are now root or source states, meaning the process
returns to the left hand side to be
repeated.

##### *C2. Extend the model of C1 for multiple cycles and thus create a Markov-cycle tree.*

#### 3\. One-cycle Markov-cycle tree

We can rearrange the Markov-cycle tree to closer resemble to Markov
model by collapsing the branches into a single cycle and simply
combining the
probabilities.

<img src="figs/onecycle_markovcycletree.png" width="65%" />

##### *C3. Modify the model of C2 to create a One-cycle Markov-cycle tree.*

#### 4\. Discrete-time Markov model

Clearly, the Markov-cycle tree can also be represented as a
discrete-type Markov model. The transition probabilities can be
calculated by combining relevant path probabilities from the decision
tree as done for the one-cycle Markov-cycle tree. The model is shown
below (note that death is not shows for simplicity).

<img src="man/figures/README-unnamed-chunk-3-1.png" width="75%" />

##### *C4. Create the equivalent discrete-time Markov model.*

#### 5\. Calculate mean QALYs

Define the state utilities:

  - `Well`: ![R\_w=](https://latex.codecogs.com/png.latex?R_w%3D "R_w=")
    1.0
  - `Cancer`: ![R\_c=](https://latex.codecogs.com/png.latex?R_c%3D
    "R_c=") 0.60
  - `AIDS`: ![R\_a=](https://latex.codecogs.com/png.latex?R_a%3D "R_a=")
    0.50
  - `Cancer & AIDS`:
    ![R\_{ca}=](https://latex.codecogs.com/png.latex?R_%7Bca%7D%3D
    "R_{ca}=") 0.30
  - `Dead`: ![R\_d=](https://latex.codecogs.com/png.latex?R_d%3D "R_d=")
    0

##### *C5. Calculate cumulative proportion of patient cycles in each state and take product with health utilities for each respectively to obtain expected QALYs.*

#### 6\. Roll back Markov-cycle tree

A neat strength is that we can calculate the mean QALYs using the
one-cycle Markov-cycle tree representation without calculating the
cumulative proportion of time of patient cycles in each health state.
This is done by rolling back using the recursive equation ([value
iteration](https://en.wikipedia.org/wiki/Markov_decision_process#Value_iteration)):

  
![
V\_n(i) = R(i) + \\sum\_j p\_{ij} V\_{n-1}(j)
](https://latex.codecogs.com/png.latex?%0AV_n%28i%29%20%3D%20R%28i%29%20%2B%20%5Csum_j%20p_%7Bij%7D%20V_%7Bn-1%7D%28j%29%0A
"
V_n(i) = R(i) + \\sum_j p_{ij} V_{n-1}(j)
")  
where ![V\_n(i)](https://latex.codecogs.com/png.latex?V_n%28i%29
"V_n(i)") are the values at node
![i](https://latex.codecogs.com/png.latex?i "i") at step
![n](https://latex.codecogs.com/png.latex?n "n"), in our case the
expected
QALYs.

##### *C6. Calculate the mean QALYs using the one-cycle Markov-cycle tree and value iteration.*

#### C7 (BONUS CHALLENGE): Roll back stochastic tree

So far we have only considered discrete time. The Markov-cycle tree
representation can be extended to continuous time as a *stochastic tree*
(see Hazen (2014) for details). Probabilities are now replaced by rates.
This change is represented by zigzag lines in the diagrams. This is
clearly a more compact representation.

We can calculate mean QALY in an analogous way to the discrete-time case
by rolling back using the recursive equation:

  
![
V(S) = \\frac{R(i)}{\\sum\_j \\lambda\_j} + \\sum\_j p\_j V(S\_j)
](https://latex.codecogs.com/png.latex?%0AV%28S%29%20%3D%20%5Cfrac%7BR%28i%29%7D%7B%5Csum_j%20%5Clambda_j%7D%20%2B%20%5Csum_j%20p_j%20V%28S_j%29%0A
"
V(S) = \\frac{R(i)}{\\sum_j \\lambda_j} + \\sum_j p_j V(S_j)
")  
The new model diagram is given below.

<img src="figs/stochastic_tree.png" width="75%" />

The rates for state transitions are:

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
  - `Dead other`: ![\\mu\_o
    = 0.014191](https://latex.codecogs.com/png.latex?%5Cmu_o%20%3D%200.014191
    "\\mu_o = 0.014191")/year

##### *C7. Create the stochastic tree model and calculate the mean QALYs using value iteration.*

### References

<div id="refs" class="references">

<div id="ref-Hazen2014">

Hazen, Gordon B. 2014. “Stochastic Trees : A New Technique for Temporal
Medical Decision Modeling,” no. August 1992.
<https://doi.org/10.1177/0272989X9201200302>.

</div>

</div>
