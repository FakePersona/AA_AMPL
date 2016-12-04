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
var y {V}, >= 0;

# the decision variables
# the optimization problem objective
      maximize totallength : sum{(i,j) in E} l[i,j]*x[i,j];

# the constraints
subject to out_d {i in V} : sum{j in W} x[i,j] <= 1;
subject to flow {i in V} : sum{j in W} x[i,j] - sum{j in W} x[j,i] = 0;
subject to flow_in : sum{j in V} x['s',j] - sum{j in V} x[j,'s'] = 1;
subject to flow_out : sum{j in V} x['t',j] - sum{j in V} x[j,'t'] = -1;

subject to order {(i,j) in E} : y[j] - y[i] >= x[i,j] - (1-x[i,j])*card(V);

subject to exist {(i,j) in {W,W}}: x[i,j] <= if (i,j) in A then 1 else 0;
