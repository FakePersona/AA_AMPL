# parameters and variables
             set V;

# vector, the cost of each food
             set E within {i in V, j in V};
             
param l {E};
var x {E}, binary;
var f {E}, >= 0, <= card(V);

var i {V}, >= 0, <= 1;
var s {V}, >= 0, <= 1;
var t {V}, >= 0, <= 1;


# the decision variables
# the optimization problem objective
      maximize totallength : sum{(k,j) in E} l[k,j]*x[k,j];



# the constraint

subject to c17 {v in V} : i[v] + s[v] + t[v] <= 1;
subject to c18 {v in V} : s[v] + i[v] = sum{(a,b) in E:a=v} x[a,b];
subject to c19 {v in V} : t[v] + i[v] = sum{(a,b) in E:b=v} x[a,b];

subject to c20a : sum{v in V} s[v] = 1;
subject to c20b : sum{v in V} t[v] = 1;

subject to c22 {(a,b) in E} : f[a,b] <= card(V)*x[a,b];
subject to c23 {v in V} : sum{(a,b) in E:b=v} f[a,b] - sum{(a,b) in E:a=v} f[a,b] >= i[v] - s[v]*card(V) + t[v];
subject to c24 {v in V} : s[v] * card(V) + i[v] <= sum{(a,b) in E:a=v} f[a,b];
