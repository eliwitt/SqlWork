SELECT ID, vin, YEAR, MAKE, MODEL, MODEL_SHORT, MODEL_RAW, STYLE, STYLE_RAW, CYLINDERS, 
                      ENGINE_TYPE, ENGINE_CUBIC_INCHES, WHEEL_DRIVE, AIR_BAG, ABS, ANTI_THEFT, DOORS, SPECIAL_RISK_INDICATOR, 
                      RESTRICTED_VEHICLE_CODE, PERFORMANCE_CODE_VSR, SYMBOL_VSR, SYMBOL_NON_VSR, LIABILITY_SYMBOL, LIABILITY_SYMBOL_OLD, 
                      MEDPAY_SYMBOL, MEDPAY_SYMBOL_OLD, NUM_VIN_CHARS, VIN_CHANGE_INDICATOR, EFFECTIVE_DATE, MODIFICATION_DATE, SOURCE
FROM         VinLookup_0510
WHERE (MODEL LIKE 'Camry %le%') AND 
(YEAR = '2005') AND 
(STYLE like '4 Door Sedan%') AND 
(ENGINE_CUBIC_INCHES = '2.4') and 
cylinders = '4' and 
engine_type = '' and
effective_date < '08/01/2009'
/*   the following is my car
returns more than 1
WHERE     (MODEL LIKE 'Sierra 1500 %extended cab sle%') AND (YEAR = '2009') AND 
(STYLE like '4 Door Pickup - Four Wheel Drive') AND (ENGINE_CUBIC_INCHES = '6.0') and
effective_date < '08/01/2009'
WHERE     (MODEL LIKE 'Sierra %extended cab%') AND (YEAR = '2009') AND 
(STYLE like '4 Door Pickup%') AND (ENGINE_CUBIC_INCHES = '6.0') and
effective_date < '08/01/2009'

WHERE     (MODEL LIKE 'Vue%') AND (YEAR = '2007') AND 
(STYLE = 'Utility Vehicle - Two Wheel Drive') AND (ENGINE_CUBIC_INCHES = '3.5') and
effective_date < '08/01/2009'

returns more than one
WHERE     (MODEL LIKE 'Titan %le%') AND (YEAR = '2005') AND 
(STYLE = '4 Door Pickup - Four Wheel Drive') AND (ENGINE_CUBIC_INCHES = '5.6') and
effective_date < '08/01/2009'
					oooorrrrrr
WHERE     (MODEL LIKE 'Titan %le%') AND (YEAR = '2005') AND 
(STYLE like '4 Door Pickup%') AND (ENGINE_CUBIC_INCHES = '5.6') and
effective_date < '08/01/2009'


return more than one
WHERE     (MODEL LIKE 'Galant%se%') AND (YEAR = '2006') AND 
(STYLE = '4 Door Sedan') AND (ENGINE_CUBIC_INCHES = '2.4') and
effective_date < '08/01/2009'

WHERE     (MODEL LIKE 'Camry %le%') AND (YEAR = '2005') AND 
(STYLE like '4 Door Sedan%') AND (ENGINE_CUBIC_INCHES = '2.4') and
effective_date < '08/01/2009'

WHERE     (MODEL LIKE 'Suburban %ls%') AND (YEAR = '2005') AND 
(STYLE like 'Utility Vehicle%') AND (ENGINE_CUBIC_INCHES = '5.3') and
effective_date < '08/01/2009'
*/
