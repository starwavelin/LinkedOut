select SE.from_name, SE.to_name, SE.skill 
from single_endorse SE, single_skill SS
where SS.skill = SE.skill and SE.from = SS.url and SE.from <> SE.to and
	/* person endorses the other for this skill is endorsed by a third person */
	0 < (select count(*) from single_endorse SEE
		 where SE.from <> SEE.from and SE.to <> SEE.from and SE.skill = SEE.skill and SEE.to = SE.from) and
	/* person endorses the other for this skill is endorsed by a third person */
	0 < (select count(*) from single_endorse SEE
         where SE.from <> SEE.from and SE.to <> SEE.from and SE.skill = SEE.skill and SEE.to = SE.to)