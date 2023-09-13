set i 'sector' /S1*S20/;

alias (i,j);

parameter t(i,*);
$CALL GDXXRW JAPANINPUT_V2.xlsx par=t rng=COEFFOUT_INPUT!A1:U21
$GDXIN JAPANINPUT_V2.gdx
$LOAD t
$GDXIN 

parameter d(i,*) ;
$CALL GDXXRW JAPANINPUT_V2.xlsx par=d rng=DOMDEMAND_INPUT!A1:B21
$GDXIN JAPANINPUT_V2.gdx
$LOAD d
$GDXIN

parameter ef(i,*) ;
$CALL GDXXRW JAPANINPUT_V2.xlsx par=ef rng=EMISSION_INPUT!A1:B21
$GDXIN JAPANINPUT_V2.gdx
$LOAD ef
$GDXIN 

scalar ERG_INT /3/;

Variable x(i), dummy, sectemiss(i);

equation e1, edum, e2;
e1(i).. x(i) - sum(j, t(i,j)*x(j)) =e= d(i,'Domestic Demand');
edum.. dummy =e= 0;
e2(i).. x(i)*ef(i,'EF')*ERG_INT =e= sectemiss(i);

model m /all/;

solve m using lp minimizing dummy;

display x.l;
display d;
display sectemiss.l;
