#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
)

== Question 2

Describe the perceptron model structure. Explain the relationship between MLP networks(Multi layer perceptron) and the universal approximation theorem, make sure to mention the bias parameter in this model.

Perceptron is a learning model that receives as input a n dimensional vector of real numbers and returns either 1 or 0

The internal structure of a perceptron is given by the bias,$b$, and weights $w$ the number of weight parameters must be equal to the dimension of the input while only a single bias parameter is present.

The weights relate to the input vector by means of dot product and the bias is added to the final result to force a certain output, if the final answer is less than 0 then the output is 0 else is 1.

The multi layer perceptron (MLP) is a composition of sigmoid neurons layers, neurons that output a real number instead of a binary answer, the relationship between a MLP and the universal approximation theorem is that MLP's can compute any function given enough layers.
