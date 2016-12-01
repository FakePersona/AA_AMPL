# parameters and variables
             set V;

# vector, the cost of each food
             set E within {i in V, j in V};
set S := setof{v in V}('s',v);
set T := setof{v in V}(v,'t');
set A := (E union (S union T));
param l {E};
var x {A}, binary;
var y {V}, >= 0;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in E} l[i,j]*x[i,j];

# the constraints
subject to out_d {v in V} : sum{(i,j) in A:j=v} x[i,j] <= 1;
subject to flow {v in V} : sum{(i,j) in A:i=v} x[i,j] - sum{(i,j) in A: j=v} x[i,j] = 0;
subject to flow_in : sum{(i,j) in A:i='s'} x[i,j] - sum{(i,j) in A: j='s'} x[i,j] = 1;
subject to flow_out : sum{(i,j) in A:i='t'} x[i,j] - sum{(i,j) in A: j='t'} x[i,j] = -1;

subject to order {(i,j) in E} : y[j] - y[i] >= x[i,j] - (1-x[i,j])*card(V);
