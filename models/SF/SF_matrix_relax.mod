# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set A within {1..N,1..N};
param l {A};
var x {1..(N+2),1..(N+2)}, >= 0, <= 1;
var f {1..(N+2),1..(N+2)}, >= 0, <= N;
var ind {1..N}, binary;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in A} l[i,j]*x[i,j];

# the constraints
#      subject to  in_d {i in 1..(N+2)} : sum{j in 1..(N+2)} x[i,j] <= 1;
subject to out_d {i in 1..N} : sum{j in 1..N+2} x[j,i] <= 1;
subject to flow {v in 1..N} : sum{j in 1..(N+2)} x[v,j] - sum{i in 1..(N+2)} x[i,v] = 0;
subject to flow_in : (sum{j in 1..N+2} x[N+1,j]) - (sum{i in 1..N+2} x[i,N+1]) = 1;
subject to flow_out : (sum{j in 1..N+2} x[N+2,j]) - (sum{i in 1..N+2} x[i,N+2]) = -1;

subject to order_11 {i in 1..N} : sum{j in 1..N+2} f[j,i] - sum{j in 1..N+2} f[i,j] = ind[i];
subject to circulating_8 {(i,j) in  {1..(N+2),1..(N+2)}} : f[i,j] <= N*x[i,j];
subject to init_10: sum{j in 1..N} f[N+1,j] = sum{j in 1..N} ind[j];
subject to cons_12 {v in 1..(N)} : sum{j in 1..(N+2)} x[j,v] = ind[v];

subject to start_13: sum{i in 1..N+2} x[N+1,i] =1;
subject to end_14: sum{i in 1..N+2} x[i,N+2] =1;

subject to exist {(i,j) in {1..N,1..N}}: x[i,j] <= if (i,j) in A then 1 else 0;
