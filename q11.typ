#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
)
#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
  align: (x, y) => (
    if x > 0 { center } else { left }
  ),
)

== Question 11

Given the following loss function and activation function as well as the network parameters:

- *Loss function*
$ \ E = (hat(y) - y_i)^2 \ $

- *Activation function*

$ \ Y = 1 / (1 + e^(-Z)), Z = W dot X \ $

- *Parameters*

$
  \ W_t = 0,4 \
  \ X = 3 \
  \ Y_i = 0,9 \
  \ eta = 0,1 \
$

=== 1. Compute the following intermediate values

- Z

$ \ Z = 0,4 * 3 = 1,2 \ $

- Y

$ \ Y = 1 / (1 + e^-Z) = 1 / (1 + e^-1,2) = 0,7685 \ $

- E

$ \ E = (0,7658 - 0,9)^2 = 0,0180 \ $

=== 2. Compute the partial derivatives

- $(partial E) / (partial Y)$

$ \ (partial E) / (partial Y) = 2(hat(y) - y_i) \ $

- $(partial Y) / (partial Z)$

$ \ (partial Y) / (partial Z) = (e^(-z)) / (1 + e^(-z))^2 \ $

- $(partial Z) / (partial W)$

$ \ (partial Z) / (partial W) = X\ $

=== 3. Compute the gradient using the chain rule

$
  \ (partial E) / (partial W) = (partial E) / (partial Y) (partial Y) / (partial Z) (partial Z) / (partial W) = (2X(hat(y)-y_i)(e^(-z))) / (1+e^(-z))^2 = 0,1432 \
$


=== 4. Update the weights

$ \ W_(t+1) = W_t - eta (partial E) / (partial W) \ $

$ \ W_(t+1) = 0,4 - 0,1 dot 0,1432 = 0,3856 \ $


