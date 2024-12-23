use telco_churn;

#check the dataset
select * from customerchurn_db;

#1.Total number of customers:-
select count(*) as Total_customer from customerchurn_db;

#2. Churn rate and the percentage of customers who churned:-
select (sum(case when churn ='Yes' then 1 else 0 end)*100)/count(*) as churn_percentage
from customerchurn_db;

#3. Number of customers by gender.:-
SELECT gender, COUNT(*) AS number_of_customers
FROM customerchurn_db
GROUP BY gender;

#4. Average tenure of customers.:-
select avg(tenure) as avg_tenure_by_month
from customerchurn_db;

#5. Percentage of senior citizens among the customers.:-
select 
case when SeniorCitizen = 1 then 'Senior' else 'Adult/Junior' end as category,SeniorCitizen,
count(customerID) as customer,
round(count(customerID)*100/(select count(customerID) from customerchurn_db),2) as percentage
from customerchurn_db
group by SeniorCitizen;

#6. Most popular payment method used by customers.:-
select PaymentMethod,count(*) as customer_count 
from customerchurn_db
group by PaymentMethod
order by customer_count desc
limit 1;

#7. Churn rate by contract type.:-
select contract,SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,round((sum(case when churn ='Yes' then 1 else 0 end)*100)/count(*),2) as churn_percentage
from customerchurn_db
group by contract;

#8. Impact of InternetService type on churn rate.:-
select InternetService,SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
round((sum(case when churn ='Yes' then 1 else 0 end)*100)/count(*),2) as churn_percentage
from customerchurn_db
group by InternetService;

#9. Churn rate categorized by monthly charges range (e.g., Low, Medium, High)
SELECT 
    CASE 
        WHEN MonthlyCharges < 50 THEN 'Low (0-50)'
        WHEN MonthlyCharges BETWEEN 50 AND 100 THEN 'Medium (50-100)'
        ELSE 'High (100+)' 
    END AS charge_range,
    COUNT(customerID) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS churn_rate
FROM customerchurn_db
GROUP BY charge_range;

#10. Number of customers using each type of Internet service.:-
select InternetService,SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
from customerchurn_db
group by InternetService;


#11. Distribution of customers based on streaming services usage (StreamingTV and StreamingMovies).
SELECT 
    SUM(CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END) AS streamingTv_customers,
    SUM(CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END) AS streamingMovies_customers
FROM customerchurn_db;

#12. Average monthly charges for customers based on contract type.
select Contract,round(avg(MonthlyCharges),2)as avg_monthly_charge
from customerchurn_db
group by Contract;

#13. Top 5 reasons for churn based on correlated attributes like Contract or InternetService.:-
SELECT 
    attribute,
    value,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM (
    SELECT 'Contract' AS attribute, Contract AS value, Churn FROM customerchurn_db
    UNION ALL
    SELECT 'InternetService', InternetService, Churn FROM customerchurn_db
    UNION ALL
    SELECT 'PaymentMethod', PaymentMethod, Churn FROM customerchurn_db
    UNION ALL
    SELECT 'tenure_group', 
           CASE 
               WHEN tenure <= 12 THEN '0-12 months' 
               WHEN tenure <= 24 THEN '13-24 months' 
               WHEN tenure <= 36 THEN '25-36 months' 
               ELSE '37+ months' 
           END, 
           Churn 
    FROM customerchurn_db
    UNION ALL
    SELECT 'MonthlyCharges_group',
           CASE 
               WHEN MonthlyCharges < 30 THEN 'Low (<$30)' 
               WHEN MonthlyCharges < 70 THEN 'Medium ($30-$70)' 
               ELSE 'High (>$70)' 
           END, 
           Churn 
    FROM customerchurn_db
) AS aggregated_data
GROUP BY attribute, value
ORDER BY churn_rate DESC
LIMIT 5;

#14. Relationship between tenure and average monthly charges for churned customers.:-
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 36 THEN '25-36 months'
        ELSE '37+ months'
    END AS tenure_group,
    AVG(MonthlyCharges) AS avg_monthly_charges
FROM 
    customerchurn_db
WHERE 
    Churn = 'Yes'
GROUP BY 
    tenure_group
ORDER BY 
    tenure_group;


#15. Total revenue lost due to churn.:-
SELECT SUM(TotalCharges) AS total_revenue_lost
FROM customerchurn_db
WHERE Churn = 'Yes';















