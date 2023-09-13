set i 'sector' /S1*S20/;

alias (i,j);

parameter t(i,*);
$CALL GDXXRW JAPANINPUT_V2.xlsx par=t rng=COEFFOUT_INPUT!A1:U21
$GDXIN JAPANINPUT_V2.gdx
$LOAD t
$GDXIN 

parameter d(i) /S1*S20 = 100/ ;


Variable x(i), dummy;

equation e1, edum;
e1(i).. x(i) - sum(j, t(i,j)*x(j)) =e= d(i);
edum.. dummy =e= 0;

model m /all/;

solve m using lp minimizing dummy;

display x.l;
display d;
