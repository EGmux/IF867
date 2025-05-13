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
