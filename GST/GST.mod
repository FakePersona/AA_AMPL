# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set A within {1..N,1..N};
param l {A};
var x {1..N,1..N}, binary;
var f {1..N,1..N}, >= 0, <= N;

var i {1..N}, >= 0, <= 1;
var s {1..N}, >= 0, <= 1;
var t {1..N}, >= 0, <= 1;


# the decision variables
# the optimization problem objective
      maximize totallength : sum{(k,j) in A} l[k,j]*x[k,j];

      

# the constraint

subject to c17 {v in 1..N} : i[v] + s[v] + t[v] <= 1;
subject to c18 {v in 1..N} : s[v] + i[v] = sum{j in 1..N} x[v,j];
subject to c19 {v in 1..N} : t[v] + i[v] = sum{j in 1..N} x[j,v];

subject to c20a : sum{v in 1..N} s[v] = 1;
subject to c20b : sum{v in 1..N} t[v] = 1;

subject to c22 {(k,j) in  {1..N,1..N}} : f[k,j] <= N*x[k,j];
subject to c23 {v in 1..N} : sum{j in 1..N} f[j,v] - sum{j in 1..N} f[v,j] >= i[v] - s[v]*N + t[v];
subject to c24 {v in 1..N} : s[v] * N + i[v] <= sum{j in 1..N} f[v,j];
