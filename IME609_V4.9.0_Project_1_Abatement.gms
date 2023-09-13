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

scalar aff_abt /24.5/
       beccus_abt /152/
       daccus_abt /512/
       ocfer_abt /229/;       

Variable x(i), sectemiss(i), Z, cbtaxsect(i), Y;
Variable A, B, D, Oth;

equation e1, edum, e2,e3, cost,afflimit, ccuslimit;
e1(i).. x(i) - sum(j, t(i,j)*x(j)) =e= td(i,'Total Demand');
e2(i).. x(i)*ei(i,'EI') =e= sectemiss(i);
e3.. sum(i,sectemiss(i)) =e= Z;
edum.. Z - (A + B + D + Oth) =e= 0;
cost.. Y =e= A*aff_abt + B*beccus_abt + D*daccus_abt;
afflimit.. A =l= 51;
ccuslimit.. B + D =l= 173;

model m /all/;

solve m using lp minimizing Y;

display x.l;
display td;

display sectemiss.l;


*https://www.oecd.org/tax/tax-policy/carbon-pricing-background-notes.pdf

*abatement from Afforestation
*abatement from CCUS
*only 8% of land is available for afforestation
*only 29,000 ha land available for afforestation
*https://www.iea.org/reports/bioenergy-with-carbon-capture-and-storage
*https://asia.nikkei.com/Spotlight/Datawatch/Aging-forests-likely-to-hinder-Japan-s-decarbonization-efforts