set i 'sector' /S1*S3/;

PARAMETERS
 
A(i) /S1 2,
      S2 3,
      S3 4  /

C(i) /S1 6,
      S2 7,
      S3 8  /
B(i) /S1 1,
      S2 2,
      S3 1  /
D(i) /S1 4,
      S2 5,
      S3 3  /;

POSITIVE VARIABLES
 P
 X;
 
EQUATIONS
 DEMAND
 SUPPLY;
 
SUPPLY.. sum(i,A(i)) + sum(i,B(i))*X =G= P;
DEMAND.. X =G= sum(i,C(i)) + sum(i,D(i))*P;
MODEL EQUIL /SUPPLY.X, DEMAND.P/;
SOLVE EQUIL USING MCP;