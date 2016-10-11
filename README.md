# point-mass-filter

Matlab implementation of a 2D and 3D Point Mass Filter (PMF). This implementation is based on the 
descritption from Niclas Bergman's Thesis [Recursive Bayesian Estimation
Navigation and Tracking Applications](http://www.control.isy.liu.se/research/reports/Ph.D.Thesis/PhD579.pdf), Chapter 5. Both implemenations relay on [N-dimensional sparse arrays
](http://ch.mathworks.com/matlabcentral/fileexchange/29832-n-dimensional-sparse-arrays) which is included in this distribution.

## 2D PMF

The folder [PMF_2D](https://github.com/gpldecha/point-mass-filter/tree/master/PMF_2D) contains two examples of how to use the  2D PMF filter. 

### Example 1

Run script [Example1.m](https://github.com/gpldecha/point-mass-filter/blob/master/PMF_2D/Example1.m) and you should see 
an orange packman agent follows a circular motion whilst measuring distances and bearings (red line) to a wall (black line).
You should see both figures illustrated below after runing the scripts. 

<img src="./docs/pmf_2D_example1.png" alt="Example1_pmf" height="350" >
<img src="./docs/likelihood.png"      alt="Example1_lik" height="350">

### Example 2

Run script [Example1.m](https://github.com/gpldecha/point-mass-filter/blob/master/PMF_2D/Example1.m) and you should see the figure below appear. To control the agent use your arrow keys and press Esc to exit the simulation loop.

<center>
<img src="./docs/blue_search.gif"  alt="Example2" height="400" align="middle">
</center>

## 3D PMF

The folder [PMF_3D](https://github.com/gpldecha/point-mass-filter/tree/master/PMF_2D) contains one example of how to use the filter. If you run [Example3.m](https://github.com/gpldecha/point-mass-filter/blob/master/PMF_3D/Example3.m) you should see something similar to the figure below. 

<center>
<img src="./docs/search_1_side.gif" alt="Example3" height="400" align="middle">
</center>
