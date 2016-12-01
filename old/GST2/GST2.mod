# parameters and variables
             param N, integer, >0;

# vector, the cost of each food
              set E within {1..N,1..N};
param l {E};
var x {E}, binary;
var f {E}, >= 0, <= N;

var i {1..N}, >= 0, <= 1;
var s {1..N}, >= 0, <= 1;
var t {1..N}, >= 0, <= 1;


# the decision variables
# the optimization problem objective
      maximize totallength : sum{(k,j) in E} l[k,j]*x[k,j];



# the constraint

      subject to c17 {v in 1..N} : i[v] + s[v] + t[v] <= 1;
subject to c18 {v in 1..N} : s[v] + i[v] = sum{(a,b) in E:a=v} x[a,b];
subject to c19 {v in 1..N} : t[v] + i[v] = sum{(a,b) in E:b=v} x[a,b];

subject to c20a : sum{v in 1..N} s[v] = 1;
subject to c20b : sum{v in 1..N} t[v] = 1;

subject to c22 {(a,b) in E} : f[a,b] <= N*x[a,b];
subject to c23 {v in 1..N} : sum{(a,b) in E:b=v} f[a,b] - sum{(a,b) in E:a=v} f[a,b] >= i[v] - s[v]*N + t[v];
subject to c24 {v in 1..N} : s[v] * N + i[v] <= sum{(a,b) in E:a=v} f[a,b];
