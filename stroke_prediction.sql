#previewing the entire table#
SELECT 
    *
FROM
    clean_stroke_prediction;
    
#to determine the number of observations with 'yes' from stroke#
SELECT 
    COUNT(*)
FROM
    clean_stroke_prediction
WHERE
    stroke = 'yes'; #180 observations#
    
    
#creating a new table with categorized colum according to WHO standard#
CREATE TABLE new_stroke_prediction AS (
SELECT
  id,
  gender,
  age,
  hypertension AS hypertensive,
  heart_disease,
  ever_married AS marriage_status,
  work_type,
  residence_type,
  smoking_status,
  stroke,
  CASE
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi BETWEEN 18.5
  AND 24.9 THEN 'Healthy weight'
    WHEN bmi BETWEEN 25.0 AND 29.9 THEN 'Overweight'
    WHEN bmi >=30 THEN 'Obese'
END
  AS body_mass_index,
  CASE
    WHEN avg_glucose_level BETWEEN 70 AND 140 THEN 'Normal'
    WHEN avg_glucose_level >140 THEN 'High'
    WHEN avg_glucose_level <70 THEN 'Low'
END 
	AS glucose_level,
CASE 
    WHEN age < 10 THEN '<10'
    WHEN age BETWEEN 10 AND 19 THEN '10-19'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49' 
    WHEN age BETWEEN 50 AND 59 THEN '50-59' 
    WHEN age BETWEEN 60 AND 69 THEN '60-69' 
    WHEN age BETWEEN 70 AND 79 THEN '70-79' 
    WHEN age BETWEEN 80 AND 89 THEN '80-89'
  END AS ages
 
FROM
clean_stroke_prediction);


#ANALYSIS#


#to determine the relationship between stroke and gender#
SELECT 
    COUNT(stroke) AS STROKE_COUNT, gender
FROM
    new_stroke_prediction
WHERE
    stroke = 'yes'
GROUP BY gender;   #females have higher incidence of stroke at 105 and male at 75#


#to determine the relationship between stroke and body_mass_index (bmi)#
SELECT 
    COUNT(stroke) AS stroke_count, body_mass_index
FROM
    new_stroke_prediction
WHERE
    stroke = 'yes'
GROUP BY body_mass_index
ORDER BY stroke_count; #incidence of stroke increases withh BMI#


#to determine the relationship between stroke and glucose level#
SELECT 
    COUNT(stroke) AS stroke_count, glucose_level
FROM
    new_stroke_prediction
WHERE
    stroke = 'yes'
GROUP BY glucose_level
ORDER BY stroke_count; #pqtients with low glucose level have a ver low chance of getting stroke#


#to determine the relationship between stroke and smoking status#
SELECT 
    COUNT(stroke) AS stroke_count, smoking_status
FROM
    new_stroke_prediction
WHERE
    stroke = 'yes'
GROUP BY smoking_status
ORDER BY stroke_count; #smoking has no relationship with stroke in patients with this data#


#to determine the relationship between stroke and age#
SELECT 
    COUNT(stroke) AS stroke_count, ages
FROM
    new_stroke_prediction
WHERE
    stroke = 'yes'
GROUP BY ages
ORDER BY stroke_count; #incidence of stroke increases with age seems to be low between ages 80-89#


#confirming that the drop between ages 80-89 is due to low amounts of available data within this age range#
SELECT 
    COUNT(*)
FROM
    new_stroke_prediction
WHERE
    ages = '80-89' ; #149 observations in ages 80-89#

SELECT 
    COUNT(*) as _60s_count
FROM
    new_stroke_prediction
WHERE
    ages = '60-69'; #485 observations in ages 60-69#
    
    # the decrease in ages 80-89 is due to lesser amount of available data within this age range#

