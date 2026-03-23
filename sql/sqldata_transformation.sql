--step 1 ==> Append all monthly seles tables together
create or replace table `rfm-project-for-data-analysis.Sales.sales_2025` as
select *
from `rfm-project-for-data-analysis.Sales.sales2025*`

--step 2 ==> Calculate the recency , frequency , monetary r,f,m rank
create or replace view rfm-project-for-data-analysis.Sales.rfm_matrix as
WITH current_date AS (
  SELECT CURRENT_DATE() AS analysis_date
),
rfm AS (
  SELECT 
    CustomerID,
    MAX(OrderDate) AS last_order_date,
    DATE_DIFF(cd.analysis_date, MAX(OrderDate), DAY) AS recency,
    COUNT(*) AS frequency,
    SUM(OrderValue) AS monetary
  FROM `rfm-project-for-data-analysis.Sales.sales_2025`,
       current_date cd
  GROUP BY CustomerID, cd.analysis_date
)

select 
  rfm.*,
  row_number() over(order by recency asc) as r_rank, 
  row_number() over(order by frequency desc) as f_rank,
  row_number() over(order by monetary desc) as m_rank
from rfm

-- Step 3: Assign deciles (10=best, 1=worst)
CREATE OR REPLACE VIEW `rfm-project-for-data-analysis.Sales.rfm_scores`
AS
SELECT
    *,
    NTILE(10) OVER(ORDER BY recency DESC) as r_score,
    NTILE(10) OVER(ORDER BY frequency ASC) as f_score,
    NTILE(10) OVER(ORDER BY monetary ASC) as m_score
from `rfm-project-for-data-analysis.Sales.rfm_matrix`

--step 4: calculate the total score
CREATE or replace view `rfm-project-for-data-analysis.Sales.rfm_total_score`
as
select 
  CustomerID,
  recency, 
  frequency, 
  monetary, 
  r_score,
  f_score,
  m_score,
  (r_score+ f_score+ m_score) as total_score
from `rfm-project-for-data-analysis.Sales.rfm_scores`
order by total_score DESC

--step 5: powerBI ready rfm segment table
create or replace view `rfm-project-for-data-analysis.Sales.rfm_segments_final`
as 
select 
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  total_score,
  case 
    when total_score >= 27 then 'Champions'
    when total_score >= 24 then 'Loyal Customers'
    when total_score >= 21 then 'Potential Loyalists'
    when total_score >= 18 then 'Promising'
    when total_score >= 14 then 'Needs Attention'
    when total_score >= 10 then 'At Risk'
    else 'Lost Customers'
end as rfm_segment
from `rfm-project-for-data-analysis.Sales.rfm_total_score`
order by total_score DESC

