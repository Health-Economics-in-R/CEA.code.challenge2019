Code Challenges
---------------

The following questions are for the virtual code challenge for
participants in the [R for trial & model-based cost-effectiveness
analysis
workshop](http://www.statistica.it/gianluca/teaching/r-hta-workshop/2019/)
taking place 9 July 2019 at University College London. See the
associated [GitHub
repo](https://github.com/Health-Economics-in-R/CEA.code.challenge2019)
for more details.

Jump to challenge here: [C1](#C1), [C2](#C2), [C3](#C3), [C4](#C4),
[C5](#C5), [C6](#C6), [C7](#C7).

<br><br>

#### 1. A simple decision tree

This example is taken from Hazen (2014). The problem is concerned with a
competing risk cancer and AIDS decision tree. We will assume discrete
time of single years. An individual starts in the `Well` state. They can
transition into `Dead`, `Cancer & AIDS`, `Cancer`, `AIDS` or remain in
the `Well` state.

Event probabilities are

-   *δ*<sub>0</sub> = 1.182 × 10<sup> − 3</sup>: Die from other causes
-   *δ*<sub>*c*</sub> = 0.025: Die from recurent prostate cancer
-   *δ*<sub>*a*</sub> = 0.080: Die from AIDS
-   *β*<sub>*c*</sub> = 0.0027: Cancer recurs
-   *β*<sub>*a*</sub> = 0.0083: Develop AIDS

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C1. Define a (single year) decision tree.

<br><br>

#### 2. Markov-cycle tree

A Markov-cycle tree was introduced by Hollenberg and is a representation
of a Markov process in which the possible events taking place during
each cycle are represented by a probability tree. This is one way of
simplifying determining probabilities from multiple paths.

The diagram for the Markov-cycle tree of the example in Hazen (2014) is
given below.

<img src="figs/markov_cycle_tree.png" width="75%" />

The terminal state are now root or source states, meaning the process
returns to the left hand side to be repeated.

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C2. Extend the model of C1 for multiple cycles and thus create a
Markov-cycle tree.

<br><br>

#### 3. One-cycle Markov-cycle tree

We can rearrange the Markov-cycle tree to closer resemble to Markov
model by collapsing the branches into a single cycle and simply
combining the probabilities.

<img src="figs/onecycle_markovcycletree.png" width="65%" />

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C3. Modify the model of C2 to create a One-cycle Markov-cycle tree.

<br><br>

#### 4. Discrete-time Markov model

Clearly, the Markov-cycle tree can also be represented as a
discrete-time Markov model. The transition probabilities can be
calculated by combining relevant path probabilities from the decision
tree as done for the one-cycle Markov-cycle tree. The model is shown
below (note that death is not shows for simplicity).

<img src="man/figures/README-unnamed-chunk-3-1.png" width="75%" />

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C4. Create the equivalent discrete-time Markov model.

<br><br>

#### 5. Calculate mean QALYs

Define the state utilities:

-   `Well`: *R*<sub>*w*</sub>= 1.0
-   `Cancer`: *R*<sub>*c*</sub>= 0.60
-   `AIDS`: *R*<sub>*a*</sub>= 0.50
-   `Cancer & AIDS`: *R*<sub>*c**a*</sub>= 0.30
-   `Dead`: *R*<sub>*d*</sub>= 0

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C5. Calculate cumulative proportion of patient cycles in each state and
take product with health utilities for each respectively to obtain
expected QALYs.

<br><br>

#### 6. Roll back Markov-cycle tree

A neat strength is that we can calculate the mean QALYs using the
one-cycle Markov-cycle tree representation without calculating the
cumulative proportion of time of patient cycles in each health state.
This is done by rolling back using the recursive equation ([value
iteration](https://en.wikipedia.org/wiki/Markov_decision_process#Value_iteration)):

*V*<sub>*n*</sub>(*i*) = *R*(*i*) + ∑<sub>*j*</sub>*p*<sub>*i**j*</sub>*V*<sub>*n* − 1</sub>(*j*)
where *V*<sub>*n*</sub>(*i*) are the values at node *i* at step *n*, in
our case the expected QALYs.

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C6. Calculate the mean QALYs using the one-cycle Markov-cycle tree and
value iteration.

<br><br>

#### C7 (BONUS CHALLENGE): Roll back stochastic tree

So far we have only considered discrete time. The Markov-cycle tree
representation can be extended to continuous time as a *stochastic tree*
(see Hazen (2014) for details). Probabilities are now replaced by rates.
This change is represented by zigzag lines in the diagrams. This is
clearly a more compact representation.

We can calculate mean QALY in an analogous way to the discrete-time case
by rolling back using the recursive equation:

$$
V(S) = \\frac{R(i)}{\\sum\_j \\lambda\_j} + \\sum\_j p\_j V(S\_j)
$$
The new model diagram is given below.

<img src="figs/stochastic_tree.png" width="75%" />

The rates for state transitions are:

-   `Cancer`: *λ*<sub>*c*</sub> = 0.03250/year
-   `AIDS`: *λ*<sub>*a*</sub> = 0.10/year
-   `Dead from Cancer`: *μ*<sub>*c*</sub> = 0.3081/year
-   `Dead from AIDS`: *μ*<sub>*a*</sub> = 0.9970/year
-   `Dead other`: *μ*<sub>*o*</sub> = 0.014191/year

<br>
<style>
div.blue { background-color:#e6f0ff; border-radius: 2px; padding: 5px;}
</style>

C7. Create the stochastic tree model and calculate the mean QALYs using
value iteration.

<br><br>

 
<hr />
<p style="text-align: center;">
Written by <a href="https://github.com/n8thangreen/">Nathan Green</a>
</p>
<p style="text-align: center;">
<span
style="color: #808080;"><em><a href="mailto:nathan.green@imperial.ac.uk" class="email">nathan.green@imperial.ac.uk</a></em></span>
</p>
<!-- Add icon library -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Add font awesome icons -->
<p style="text-align: center;">
<a href="https://github.com/n8thangreen/" class="fa fa-github"></a>
</p>

 

### References

Hazen, Gordon B. 2014. “Stochastic Trees : A New Technique for Temporal
Medical Decision Modeling,” no. August 1992.
<https://doi.org/10.1177/0272989X9201200302>.
