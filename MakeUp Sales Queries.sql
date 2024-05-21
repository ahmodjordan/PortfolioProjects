SELECT 
	name,
	product,
	sum(dollars) as total_revenue,
	sum(units) as total_units
FROM makeupdata
GROUP BY name, product;


SELECT 
	name,
	location,
	dollars,
	units
FROM makeupdata
ORDER BY name;


