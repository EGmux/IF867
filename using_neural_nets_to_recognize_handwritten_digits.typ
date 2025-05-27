#let comment(body) = emph(text(blue)[#body])
#let warning(body) = emph(text(orange)[#body])
#set math.mat(delim: "[")

== Sigmoid neurons simulating perceptrons, part I
Suppose we take all the weights annd biases in a network of perceptrons, and multiply them by a positive constant, $c > 0$. Show that the behaviour of the network doesn't change.

remember that a perceptron is defined as

$
  \ "output" = cases(
    0 "if" w dot x + b <= 0,
    1 "if" w dot x + b > 0
  ) \
  \ c (w dot x + b) <= c 0 \
  \ c w dot c x + b c <= 0 \
  "and"
  \ c (w dot x +b) > c 0 \
  \ c w dot c x + b c > 0 \
$

note we can simplify the above equation by defining $w' = c w, x' = c x, b' = b c$
then

$
  \ "output" = cases(
    0 "if" c' dot x' + b' <= 0,
    1 "if" c' dot x' +b' > 0
  ) \
$

and we have the same form as before, so the behavior of the network doesn't change.


== Sigmoid neurons simulating perceptrons, part II

Suppose we have the same setup as the last problem - a network of perceptrons. Suppose also that the overall input to the network of perceptrons has been chosen. We won't need the actual input value, we just need the input to have been fixed. Suppose the weights and biases are such that

$w dot x + b!= 0$ for the input $x$ to any particular perceptron in the network. Now replace all the perceptrons in the network by sigmoid neurons, and multiply the weigths and biases by a positive constant $c > 0$. Show that in the limit as $c arrow.r infinity$ the behaviour of this network of sigmoid neurons is exactly the same as the network of perceptrons. How can this fail when $w dot x + b = 0$ for one of the perceptrons?

remember the definition of the sigmoid neuron

$
  \ sigma(z) = 1 / (1 + exp^(-z)) \
  \ z = w dot x + b \
  "now consider multiple neurons"
  \ "outputsys" = Sigma^(n)_(j=0) sigma_j(z) \
  \ "outputsys" = Sigma^(n)_(j=0) 1 / (1 + exp^(-(w_j dot x_j + b_j))) \
  \ "outputsys" = Sigma^(n)_(j=0) 1 / (1 + exp^(-(c(w_j dot x_j + b_j)))) \
  \ "outputsys" = lim_(c arrow.r infinity )(Sigma^(n)_(j=0) 1 / (1 + exp^(-(c w_j dot c x_j + c b_j)))) \
  \ "outputsys" = lim_(c arrow.r infinity) (Sigma^(n)_(j=0) 1 / (1 + exp^(plus.minus infinity))) \
  \ "outputsys" = lim_(c arrow.r infinity) (Sigma^(n-k)_(j=0) 1 / (infinity) = 0) + (Sigma^(k-1)_(j=n-k+1) 1) \
$

so indeed is the desired behavior, considering all perceptrons follow $w dot x + b != 0$.

if one of the perceptrons outputs 0, then

$
  \ "outputsys" = lim_(c arrow.r infinity) (Sigma^(n-1)_(j=0) 1 + 1 / (1 + exp^(-c(w_n dot x_n + b_n)))) \
  \ "outputsys" = lim_(c arrow.r infinity) (Sigma^(n-1)_(j=0) 1 + 1 / (1 + exp^(-0))) \
  \ "outputsys" = lim_(c arrow.r infinity) ((Sigma^(n-k)_(j=0) 1) +(Sigma^(k-2)_(j=(n-k)+1) 0) + 1 / (2)) \
$

one of the neurons output $1 / 2$ a value not valid for a perceptron, thus it won't be a valid perceptron emulation anymore.

== There is a way of determining the bitwise representation of a digit by adding an extra layer to the three-layer network above. The extra layer converts the output from the previous layer into a binary representation, as illustrated in the figure below. Find a set of weights and biases for the new output layer. Assume that the first 3 layers of neurons are such that the correct output in the third layer (i.e, the old output layer) has activation at least $0.99$, and incorrect outputs have activation less than $0.01$

#figure(
  image("Screenshot from 2025-05-13 10-21-35.png", width: 80%),
  caption: [
    source: http://neuralnetworksanddeeplearning.com/chap1.html
  ],
)

let's review binary representation from 0 to 9, also consider the MSB(most significant bit) to be mapped to the top neuron in the output layer and the LSB(least significant bit) to be mapped to the bottom neuron in the output layer.

$
  \ 0_10 = 0000_b \
  \ 1_10 = 0001_b \
  \ 2_10 = 0010_b \
  \ 3_10 = 0011_b \
  \ 4_10 = 0100_b \
  \ 5_10 = 0101_b \
  \ 6_10 = 0110_b \
  \ 7_10 = 0111_b \
  \ 8_10 = 1000_b \
  \ 9_10 = 1001_b \
$

now the weights and biases

$
  \ w_0 = mat(1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.01, 1 / 0.01)^T, b_0 = -99 \
  \ w_1 = mat(1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.99, 1 / 0.01, 1 / 0.01, 1 / 0.01, 0 / 0.01, 1 / 0.99, 1 / 0.99)^T, b_1 = -99 \
  \ w_2 = mat(1 / 0.99, 1 / 0.99, 1 / 0.01, 1 / 0.01, 0 / 0.99, 1 / 0.99, 1 / 0.01, 1 / 0.01, 1 / 0.99, 1 / 0.99)^T, b_1 = -99 \
  \ w_3 = mat(1 / 0.99, 1 / 0.01, 1 / 0.99, 1 / 0.01, 1 / 0.99, 1 / 0.01, 1 / 0.99, 1 / 0.01, 1 / 0.99, 1 / 0.01)^T, b_1 = -99 \
$

now we test

$
  \ "assume 0 triggered in the old layer" \
  \ 1 / 0.99*0.99 + (0.01 / 0.99)*7 + (0.01 / 0.01)*2 = 1 + 7 / 99 + 2 - 99 < 0 &, #comment("so the MSB bit is reset") \
  \ 1 / 0.99 * 0.99 + (0.01 / 0.99)*5 + (0.01 / 0.01)*4 = 1 + 5 / 99 + 4 - 99 < 0 &, #comment("so the bit before the MSB is reset") \
  \ 1 / 0.99 * 0.99 + (0.01 / 0.99)*5 + (0.01 / 0.01)*4 = 1 + 5 / 99 + 4 - 99 < 0 &, #comment("so this bit is also reset") \
  \ 1 / 0.99 * 0.99 + (0.01 / 0.99)*5 + (0.01 / 0.01)*5 = 1 + 5 / 99 + 5 - 99 < 0 &, #comment("so the LSB is also reset") \
$

meaning the output is $0 0 0 0$ as we expected, but we can also check 5 for instance, two bits are expected to be activated

$
  \ "assume 5 triggered in the old layer" \
  \ 1 / 0.99 * 0.99 + (0.01 / 0.99)*7 + (0.01 / 0.01)*2 = 1 + 7 / 99 + 2 - 99 < 0 &, #comment("so the MSB is reset, as expected") \
  \ (0.99 / 0.01) + (0.01 / 0.99)*6 + (0.01 / 0.01)*3 = 99 + 6 / 99 + 3 - 99 > 0 &, #comment("bit set") \
  \ (0.99 / 0.99) + (0.01 / 0.99)*5 + (0.01 / 0.01)*4 = 1 + 5 / 99 + 4 - 99 < 0 &, #comment("so bit reset") \
  \ (0.99 / 0.01) + (0.01 / 0.99)*5 + (0.01 / 0.01)*4 = 99 + 5 / 99 + 4 - 99 > 0 &, #comment("so bit set") \
$

we can see the output is $0101$ as expected, analogous tests can be applied to other outputs in the "old output layer"

== Prove the assertion of the last paragraph. _Hint_: If you're not already familiar with the _Cauchy-Schawarz inequality_, you may find it helpful to familiarize yourself with it.

We'll derive the proof without the inequality by applying analytic geometry techniques

$ \ gradient C dot Delta v \ $

given the above expression we need to minimize it

note that both $gradient C$ and $Delta v$ are vectors, thus we can start by projecting the $Delta v$ vector in the $gradient C$ one.

$ \ Delta v = (<gradient C, Delta v>) / (norm(gradient C)norm(gradient C)) gradient C \ $

we also know the dot product of both vectors can be expressed as

$
  \ cos theta = (<gradient C, Delta v>) / ( norm(gradient C)norm(Delta v) )\
  \ cos theta norm(gradient C)norm(Delta v) = <gradient C, Delta v>\
$

thus substituting the last equation in the projection one

$ \ Delta v = (cos theta norm(Delta v)) / norm(gradient C) = (cos theta)epsilon / norm(gradient C) gradient C \ $

remember we want to minimize this function so we choose $cos theta = -1 arrow.r.double theta = pi$

and we arrive at the desired equation

$ \ Delta v = - eta gradient C, eta = epsilon / norm(gradient C) \ $

== I explained gradient descent when $C$ is a function of two variables, and when it's a function of more than two variables. What happens when $C$ is a function of just one variable? Can you provide a geometric interpretaion of what gradient descent is doing in the one-dimensional case?

imagine a cubic curve

#set text(size: 10pt)
#import "@preview/cetz:0.3.2"
#import "@preview/cetz-plot:0.1.1": *
#let f1(x) = calc.pow(x, 3)
#let f2(x) = calc.pow(3 * x, 2) // derivative
#let tx(x) = 5 + x / 2
#let ty(x, c: 0) = calc.abs(5 + (x * 10 / 1000)) + c
#cetz.canvas({
  import cetz.draw: *
  plot.plot(
    name: "plot",
    size: (10, 10),
    x-tick-step: 1,
    y-tick-step: none,
    {
      let domain = (-10, 10)
      plot.add(f1, domain: domain)
      plot.add-anchor("pt", (1, 3))
      plot.add-anchor("pt2", (3, 27))
      plot.add-anchor("pt3", (4, 64))
      plot.add-anchor("pta", (-9, -729))
      plot.add-anchor("ptb", (9, 729))
      // plot.add-anchor("pa", (1, 3))
      // plot.add-anchor("pa2", (3, 27))
      // plot.add-anchor("pa3", (4, 64))
    },
  )

  line("plot.pt", (tx(1) + 1, ty(3)), mark: (end: "stealth"))
  line("plot.pt", (tx(1) - 1, ty(3)), mark: (end: "stealth"))
  line("plot.pta", (tx(-9) + 0.7, (ty(-729) - 1) + 2), mark: (end: "stealth"))
  line("plot.pta", (tx(-9), ty(-729) - 1), mark: (end: "stealth"))
  line("plot.ptb", (tx(9) + 0.7 - 0.3, (ty(729) - 4) + 1.8), mark: (end: "stealth"))
  line("plot.ptb", (tx(9) - 0.7 - 0.3, (ty(729) - 4) - 1.8), mark: (end: "stealth"))
  // line("plot.ptb", (tx(-4) - 1, ty(-64)), mark: (end: "stealth"))
  // line("plot.pt3", (5 + 4, 5), mark: (end: "stealth"))
  // line("plot.pa", (5 - 1, 5), mark: (end: "stealth"))
  // line("plot.pa2", (5 - 3, 5), mark: (end: "stealth"))
  // line("plot.pa3", (5 - 4, 5), mark: (end: "stealth"))
})

note that if we start from the leftmost point the algorithm would halt, due to the fact that, due to domain constraints, there's no where else to go, however if we start in the rightmost side, one can see that eventually the algoritm is going to halt in the region where $(d f) / (d x) = 0$ a saddle point or maybe in the leftmost point, _depends on the learning rate_, meaning that the algorithm is effectively slicing a plane,if we consider this path to belong to a surface, and looking for points where $(d f) / (d x) = 0$ that happens in sadddle points, global and local minima.

=== Prove equations BP3 and BP4

remember the following, already proved by the author

$
  \ delta_j^l = (partial C) / (partial z_k^l) & #comment(", error due to weighted sum in the j-th neuron in the l-th layer ") \
  \ z_j^l =sum_k w_(j k)^l a_k^(l-1) + b_j^l & #comment(", j-th neuron in the l-th layer weighted sum")\
  \
$

now we need to prove the following

$ \ (partial C) / (partial b_j) = delta_j^l \ $

this can be easily be proven by chain rule application

$ \ (partial C) / (partial b_j^l) = (partial C) / (partial z_j^l)(partial z_j^l) / (partial b_j^l) = delta_j^l \ $

the $(partial z_j^l) / (partial b_j^l) = 1$

this proves BP3

now we prove BP4, again by applying the chain rule

$ \ (partial C) / (partial w_(j k)^l) = (partial C) / (partial z_j^l) (partial z_j^l) / (partial w_(j k)^l) \ $

and the partial derivative for $(partial z_j^l) / (partial w_(j k)^l) = a_k^(l-1)$

thus we have $(partial C) / (partial w_(j k)^l) = a_k^(l-1) delta_j^l$ as desired.

=== *Backpropagation with a single modified neuron* Suppose we modify a single neuron in a feedforward network so that the output from the neuron is given by $f(Sigma_j w_j x_j + b)$, where $f$ is some function other than the sigmoid. How should we modify the backpropagation algorithm in this case?

First we start by computing the error due to the weighted sum in the last layer, the output layer.

$ \ (partial C) / (partial z_j^L) = (partial C) / (partial a_j^L) (partial a_j^L) / (partial z_j^L) \ $

note the modification in this case, the second term will change for $j = h$

thus

$ \ (partial C) / (partial z_h^L) = (partial C) / (partial a_h^L) (partial a_h^L)f'(z_h^L) \ $

and for the other case, j $!=$ h
$ \ (partial C) / (partial z_j^L) = (partial C) / (partial a_j^L) (partial a_j^L)sigma'(z_j^L) \ $

now we consider how this impacts the backpropagate step

$ \ (partial C) / (partial z_j^l) = Sigma_k (partial C) / (partial z_k^(l+1)) (partial z_k^(l+1)) / (partial z_j^l)\ $

remembering the notation for $(partial C) / (partial z_k^l) equiv delta_k^l$

$ \ delta_l^j = delta_k^(l+1) Sigma_k (Sigma_(j!=h) w_(k j)^(l+1) a_j^l + b_k^(l+1)+w_(k h)^(l+1)f'(z_h^l)) \ $

the updates won't change their form, only the output error and backpropagate

=== Backpropagation with linear neurons Suppose we replace the usual non-linear $sigma$ function with $sigma(z) = z$ throughout the network. Rewrite the backpropagation algorithm for this case.

again we start by computing the output error

$ \ delta_j^L equiv (partial C) / (partial z_j^L) \ $

and by chain rule

$ \ (partial C) / (partial z_j^L) = (partial C) / (partial a_j^L) (partial a_j^L) / (partial z_j^L) \ $

note that the activation function changed, thus the partial derivative is $1$

$ \ (partial C) / (partial z_j^L) = (partial C) / (partial a_j^L) \ $

now we consider the backpropagate task

$ \ delta_j^l equiv Sigma_k (partial C) / (partial z_k^(l+1)) (partial z_k^(l+1)) / (partial z_j^l) \ $

thus we can simplify this to

$ \ delta_j^l = delta_k^(l+1) (partial (Sigma_j w_(k j)^(l+1) f(z_j^l) + b_k^(l+1))) / (partial z_j^l) \ $

and we simplify this again to

$ \ delta_j^l = Sigma_k w_(k j)^(l+1) delta_k^(l+1) \ $




