select idorno, idolin, idprdc, ttytcd
from vt2662afvp.srbisd SalInv 
	left join vt2662afvp.z3dr503a OrdAttrs on idorno = ttorno and idolin = ttline
  where idorno = 10157050;