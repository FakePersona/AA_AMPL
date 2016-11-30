# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set E within {1..N,1..N};
set S := {(i,j) in {N+1..N+1,1..N}};
set T := {(i,j) in {1..N,N+2..N+2}};
set A := (E union (S union T));
param l {E};
var x {A}, binary;
var y {1..N}, >= 0;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in E} l[i,j]*x[i,j];

# the constraints
      subject to out_d {v in 1..(N+2)} : sum{(i,j) in A:j=v} x[i,j] <= 1;
subject to flow {v in 1..N} : sum{(i,j) in A:i=v} x[i,j] - sum{(i,j) in A: j=v} x[i,j] = 0;
subject to flow_in : sum{(i,j) in A:i=N+1} x[i,j] - sum{(i,j) in A: j=N+1} x[i,j] = 1;
subject to flow_out : sum{(i,j) in A:i=N+2} x[i,j] - sum{(i,j) in A: j=N+2} x[i,j] = -1;

subject to order {(i,j) in E} : y[j] - y[i] >= x[i,j] - (1-x[i,j])*N;
