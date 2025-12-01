/*
Questions: what are the top paying jobs?
- identify the top 10 highest paying Data analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove NULLS).
- Why? Highlights the top-paying opportunities for Data Analysts, offering insights into employments
*/

SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,   
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim
    USING(company_id)
WHERE 
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;