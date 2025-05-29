

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

=== Question 4


==== 1. Explain the basic principle behind gradient descent. Why this technique is core in machine learning?

The gradient descent is a optimization technique, by optimization technique we mean it updates the model parameters given a function of such parameter iteratively.
the explanation is much easier if we start by mentioning the equation

$ \ theta' = theta - eta nabla C_theta \ $

now if we imagine the overall solution space as a subset of $RR^3$ and remembering that $nabla C_theta$ is a vector aligned with the direction of largest change in the dimension $theta$. The minus sign implies an update to the value of the parameter in the opposite direction. Note that we expect the positive direction to point away from a global minimum thus increasing the training loss, that's the reason for the minus sign.

This reason why this technique is core in machine learning is due to most mainstream optimizations being variations of the gradient descent.

==== 2. Explain the distinctions between batch, mini-batch and stochastic gradient descent, make sure to compare advantages and disadvantages of each.

SGD (stochastic gradient descent) estimates the value of the gradient after each sample

$ \ theta = theta' - eta nabla C_theta_i, i in RR^d \ $

notable advantage is reduction in training time, however training performance might be impacted however due to the noise the algorithm might get unstuck from saddle or local minima points.

Batch gradient descent is essential the technique described in the previous question with the modification in how we compute the final gradient

$ \ theta = theta' - eta / n Sigma_i nabla C_theta_i, i in RR^d \ $

advantages is possibly a good accuracy, but a notable disadvantages is no tolerance for error if the algorithm get stuck in a saddle or local minima it might never "unstuck" thus possibility of no convergence might be high in some cases.

Mini batch gradient descent is a variation of Batch gradient descent where a subset of samples are selected and thus learning happens faster and also resistant to saddle and local minima the disadvantage is more fine tuning in the hyperparameters required and not as accurate as the Batch gradient descent.



