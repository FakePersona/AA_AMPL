# parameters and variables
             set V;

# vector, the cost of each food
              set E within {V,V};
set W := V union (setof{1..1}('s') union setof{1..1}('t'));
set S := setof{v in V}('s',v);
set T := setof{v in V}(v,'t');
set A := (E union (S union T));
param l {E};
var x {W,W}, binary;
var f {W,W}, >= 0, <= card(V);
var ind {V}, binary;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in E} l[i,j]*x[i,j];

# the constraints
      subject to out_d {i in V} : sum{j in W} x[i,j] <= 1;
subject to flow {i in V} : sum{j in W} x[i,j] - sum{j in W} x[j,i] = 0;
subject to flow_in : sum{j in V} x['s',j] - sum{j in V} x[j,'s'] = 1;
subject to flow_out : sum{j in V} x['t',j] - sum{j in V} x[j,'t'] = -1;

subject to order_11 {i in V} : sum{j in W} f[j,i] - sum{j in W} f[i,j] = ind[i];
subject to circulating_8 {(i,j) in  {W,W}} : f[i,j] <= card(V)*x[i,j];
subject to init_10: sum{j in V} f['s',j] = sum{j in V} ind[j];
subject to cons_12 {v in V} : sum{j in W} x[j,v] = ind[v];

subject to start_13: sum{i in W} x['s',i] =1;
subject to end_14: sum{i in W} x[i,'t'] =1;

subject to exist {(i,j) in {W,W}}: x[i,j] <= if (i,j) in A then 1 else 0;

