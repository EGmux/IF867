#let comment(body) = emph(text(blue)[#body])
#let warning(body) = emph(text(orange)[#body])
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
