# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set E within {1..N,1..N};
set S := {(i,j) in {N+1..N+1,1..N}};
set T := {(i,j) in {1..N,N+2..N+2}};
set A := (E union (S union T));
param l {E};
var x {A}, binary;
var f {A}, >= 0, <= N;
var ind {1..N}, binary;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in E} l[i,j]*x[i,j];

# the constraints
      subject to out_d {v in 1..(N+2)} : sum{(i,j) in A:j=v} x[i,j] <= 1;
subject to flow {v in 1..N} : sum{(i,j) in A:i=v} x[i,j] - sum{(i,j) in A: j=v} x[i,j] = 0;
subject to flow_in : sum{(i,j) in A:i=N+1} x[i,j] - sum{(i,j) in A: j=N+1} x[i,j] = 1;
subject to flow_out : sum{(i,j) in A:i=N+2} x[i,j] - sum{(i,j) in A: j=N+2} x[i,j] = -1;

subject to order_11 {v in 1..N} : sum{(i,j) in A:j=v} f[i,j] - sum{(i,j) in A:i=v} f[i,j] = ind[v];
subject to circulating_8 {(i,j) in  A} : f[i,j] <= N*x[i,j];
subject to init_10: sum{j in 1..N} f[N+1,j] = sum{j in 1..N} ind[j];
subject to cons_12 {v in 1..N} : sum{(i,j) in A:j=v} x[i,j] = ind[v];

subject to start_13: sum{i in 1..N} x[N+1,i] =1;
subject to end_14: sum{i in 1..N} x[i,N+2] =1;
