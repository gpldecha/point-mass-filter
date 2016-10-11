# point-mass-filter

Matlab implementation of a 2D and 3D Point Mass Filter (PMF). This implementation is based on the 
descritption from Niclas Bergman's Thesis [Recursive Bayesian Estimation
Navigation and Tracking Applications](http://www.control.isy.liu.se/research/reports/Ph.D.Thesis/PhD579.pdf), Chapter 5. Both implemenations relay on [N-dimensional sparse arrays
](http://ch.mathworks.com/matlabcentral/fileexchange/29832-n-dimensional-sparse-arrays) which is included in this distribution.

## 2D PMF

### Example 1

The folder [PMF_2D](https://github.com/gpldecha/point-mass-filter/tree/master/PMF_2D) contains two examples of how to use the  2D PMF filter. In the first example (run script [Example1.m](https://github.com/gpldecha/point-mass-filter/blob/master/PMF_2D/Example1.m)) an agent (orange packman) follows a circular motion whilst measuring distance and bearing (red line) to a wall (black line), see both the illustrations below: 

<img src="./docs/pmf_2D_example1.png" alt="Example1_pmf" height="350" >
<img src="./docs/likelihood.png"      alt="Example1_lik" height="350">

### Example 2

<center>
<img src="./docs/blue_search.gif"  alt="Example2" height="400" align="middle">
</center>

## 3D PMF

<center>
<img src="./docs/search_1_side.gif" alt="Example3" height="400" align="middle">
</center>
