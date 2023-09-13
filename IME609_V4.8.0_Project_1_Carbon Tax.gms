set i 'sector' /S1*S20/;

alias (i,j);

parameter t(i,*);
$CALL GDXXRW JAPANINPUT_V2.xlsx par=t rng=COEFFOUT_INPUT!A1:U21
$GDXIN JAPANINPUT_V2.gdx
$LOAD t
$GDXIN 

parameter td(i,*) ;
$CALL GDXXRW JAPANINPUT_V2.xlsx par=td rng=TOTDEMAND_INPUTV!A1:B21
$GDXIN JAPANINPUT_V2.gdx
$LOAD td
$GDXIN

parameter ei(i,*) ;
$CALL GDXXRW JAPANINPUT_V2.xlsx par=ei rng=EMISSIONINTUSD_INPUT!A1:B21
$GDXIN JAPANINPUT_V2.gdx
$LOAD ei
$GDXIN 

Variable x(i), sectemiss(i), dummy, cbtaxsect(i);

equation e1, edum, e2,e3;
e1(i).. x(i) - sum(j, t(i,j)*x(j)) =e= td(i,'Total Demand');
e2(i).. x(i)*ei(i,'EI') =e= sectemiss(i);
e3(i).. sectemiss(i)*2.16 =e= cbtaxsect(i);
edum.. dummy =e= 0;

model m /all/;

solve m using lp minimizing dummy;

display x.l;
display td;
display sectemiss.l;


*https://www.oecd.org/tax/tax-policy/carbon-pricing-background-notes.pdf