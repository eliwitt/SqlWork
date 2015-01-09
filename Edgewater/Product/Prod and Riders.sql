select pro.*
from prd_product pro left join prd_rider rider
on pro.product_key = rider.rider_key
where pro.Product_key ='{53BEE772-00A3-477E-8EE4-03E4FA44568B}' 
or rider.product_key ='{53BEE772-00A3-477E-8EE4-03E4FA44568B}'