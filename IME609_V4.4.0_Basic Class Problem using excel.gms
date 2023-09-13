set i 'sector' /S1*S20/;

alias (i,j);

parameter t(i,*);
$CALL GDXXRW JAPANINPUT_V2.xlsx par=t rng=COEFFOUT_INPUT!A1:U21
$GDXIN JAPANINPUT_V2.gdx
$LOAD t
$GDXIN 

*parameter d(i);

Variable x(i), totaloutput,d(i);

equation e1, etot, etotdem;
e1(i).. x(i) - sum(j, t(i,j)*x(j)) =e= d(i);
etot.. totaloutput =e= 0;
etotdem.. 1000000 =e= sum(i,d(i));

model m /all/;

solve m using lp minimizing totaloutput;

display x.l;
