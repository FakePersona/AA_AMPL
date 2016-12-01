# parameters and variables
             set V;

# vector, the cost of each food
             set E within {i in V, j in V};
set S := setof{v in V}('s',v);
set T := setof{v in V}(v,'t');
set A := (E union (S union T));
param l {E};
var x {A}, binary;
var f {A}, >= 0, <= card(V);
var ind {V}, binary;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in E} l[i,j]*x[i,j];

# the constraints
subject to out_d {v in V} : sum{(i,j) in A:j=v} x[i,j] <= 1;
subject to flow {v in V} : sum{(i,j) in A:i=v} x[i,j] - sum{(i,j) in A: j=v} x[i,j] = 0;
subject to flow_in : sum{(i,j) in A:i='s'} x[i,j] - sum{(i,j) in A: j='s'} x[i,j] = 1;
subject to flow_out : sum{(i,j) in A:i='t'} x[i,j] - sum{(i,j) in A: j='t'} x[i,j] = -1;


subject to order_11 {v in V} : sum{(i,j) in A:j=v} f[i,j] - sum{(i,j) in A:i=v} f[i,j] = ind[v];
subject to circulating_8 {(i,j) in  A} : f[i,j] <= card(V)*x[i,j];
subject to init_10: sum{j in V} f['s',j] = sum{j in V} ind[j];
subject to cons_12 {v in V} : sum{(i,j) in A:j=v} x[i,j] = ind[v];

subject to start_13: sum{j in V} x['s',j] =1;
subject to end_14: sum{i in V} x[i,'t'] =1;
