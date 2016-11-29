# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set A within {1..N,1..N};
param l {A};
var x {1..(N+2),1..(N+2)}, binary;
var f {1..(N+2),1..(N+2)}, >= 0, <= N;
var ind {1..N}, binary>= 0;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in A} l[i,j]*x[i,j];

# the constraints
      subject to  in {i in 1..N} : sum{j in 1..N} x[i,j] <= 1;
subject to out {i in 1..N} : sum{j in 1..N} x[j,i] <= 1;
subject to flow {i in 1..N} : sum{j in 1..N} x[i,j] - sum{j in 1..N} x[j,i] = O;
subject to flow_in : sum{j in 1..N} x[n+1,j] - sum{j in 1..N} x[j,n+1] = 1;
subject to flow_out : sum{j in 1..N} x[n+1,j] - sum{j in 1..N} x[j,n+1] = -1;
subject to order {i in 1..N} : sum{j in 1..N} f[j,i] - sum{j in 1..N} f[i,j] = ind[i];
subject to circulating {(i,j) in 1..(N+2),1..(N+2)} : f[i,j] <= N*x[i,j];
subject to init : sum{j in 1..N} f[N+1,j] = sum{j in 1..N} ind[j];
subject to cons {v in 1..(N+2)} : sum{j in 1..(N+2)} x[j,v] = ind[v]


