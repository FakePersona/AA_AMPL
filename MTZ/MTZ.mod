# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set A within {1..N,1..N};
param l {A};
var x {1..(N+2),1..(N+2)}, binary;
var y {1..N}, >= 0;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in A} l[i,j]*x[i,j];

# the constraints
      subject to  in_d {i in 1..(N+2)} : sum{j in 1..(N+2)} x[i,j] <= 1;
subject to out_d {i in 1..(N+2)} : sum{j in 1..(N+2)} x[j,i] <= 1;
subject to flow {i in 1..N} : sum{j in 1..(N+2)} x[i,j] - sum{j in 1..(N+2)} x[j,i] = 0;
subject to flow_in : sum{j in 1..N} x[N+1,j] - sum{j in 1..N} x[j,N+1] = 1;
subject to flow_out : sum{j in 1..N} x[N+2,j] - sum{j in 1..N} x[j,N+2] = -1;

subject to order {(i,j) in A} : y[j] - y[i] >= x[i,j] - (1-x[i,j])*N;

subject to exist {(i,j) in {1..N,1..N}}: x[i,j] <= if (i,j) in A then 1 else 0;
