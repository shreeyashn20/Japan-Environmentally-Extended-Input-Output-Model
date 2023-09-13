set i 'sector' /S1*S20/;

alias (i,j);

parameter t(i,*);
$CALL GDXXRW JAPANINPUT_V2.xlsx par=t rng=COEFFOUT_INPUT!A1:U21
$GDXIN JAPANINPUT_V2.gdx
$LOAD t
$GDXIN 

parameter td(i,*) ;
$CALL GDXXRW JAPANINPUT_V2.xlsx par=td rng=TOTDEMAND_INPUT!A1:B21
$GDXIN JAPANINPUT_V2.gdx
$LOAD td
$GDXIN

parameter ei(i,*) ;
$CALL GDXXRW JAPANINPUT_V2.xlsx par=ei rng=EMISSIONINTUSD_INPUT!A1:B21
$GDXIN JAPANINPUT_V2.gdx
$LOAD ei
$GDXIN 

Variable x(i), sectemiss(i), dummy, alpha;

equation e1, edum, e2,e3;
e1(i).. x(i) - sum(j, t(i,j)*x(j)) =e= alpha*td(i,'Total Demand');
e2(i).. x(i)*ei(i,'EI') =e= sectemiss(i);
e3.. sum(i,sectemiss(i)) =l= 700;
edum.. dummy =e= 0;

model m /all/;

solve m using lp maximizing alpha;

display x.l;
display td;
display sectemiss.l;


