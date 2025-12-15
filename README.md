#  Introduction
📈 Dive into the data job market! 
Focusing on **Data Engineering roles**, this project uncovers the 💰 top-paying skills, the technologies driving the highest salaries, and where industry demand aligns with high compensation. From backend-driven tools like Node and MongoDB, to high-value niche skills such as Rust, Clojure, and Solidity, this analysis highlights the technical stack that truly boosts earning potential in the data engineering field.

SQL queries? Check them out here: [project_sql folder](/project_sql/)
#  Background
As the demand for **data engineers** continues to grow, I am keen to understand which skills and technologies are most valued in the industry. This project investigates current **job postings** to identify the **highest-paying skills**, **in-demand technologies**, and where market demand intersects with compensation. 

The insights gained will guide my focus on developing a targeted skill set that aligns with industry needs and maximizes career opportunities in this rapidly evolving field.

### In this project, I explored the data engineering job market to answer the following key questions:

1. What are the top-paying data engineering jobs?
2. Which skills are required for these top-paying roles?
3. Which skills are currently in high demand for data engineering positions?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for career growth in data engineering?:
#  Tools i used
To perform this analysis, I leveraged the following tools:
- **SQL & PostgreSQL** – for querying and analyzing job posting data.
- **Visual Studio Code** – as the development environment for writing and testing queries.
- **Git & GitHub** – for version control, collaboration, and hosting the project repository.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data engineering job market. Here's how i approached each question:

### 1. Top paying Data Engineering jobs
To identify the top-paying data engineering roles, I queried job postings with non-null salaries, focusing on “Data Engineer” positions available globally. The query retrieves the job ID, title, company, location, schedule type, salary, and posting date, ordered by highest salary

```sql
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
    job_title_short = 'Data Engineer'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of top-paying data engineering jobs in 2023:

- Most high-paying roles are “Data Engineer” positions, with senior titles like Principal, Staff, Director, and Manager also well-compensated.

- Salaries range from $242k to $325k, offered by both tech giants (Meta, Twitch) and specialized firms (Engtal, Durlston Partners).

- Remote and full-time positions dominate, showing that flexibility and stability are key features of top-paying roles.

![Top Paying Roles](/assets/1_top_paying_jobs.png)
*Bar graph visualizing the salaries for the top 10 jobs for data engineers*

### 2. Skills required for top-paying Data Engineering roles

To identify the skills required for the top-paying data engineering roles, I queried the skills associated with the highest-paying “Data Engineer” positions globally. The query retrieves the job ID, title, company, schedule type, salary, and listed skills for these top roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        job_schedule_type,   
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim
        USING(company_id)
    WHERE 
        job_title_short = 'Data Engineer'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    USING (job_id)
INNER JOIN skills_dim
    USING (skill_id)
ORDER BY salary_year_avg DESC
LIMIT 10;
```

Here's the breakdown of skills required for top-paying data engineering jobs:

- **Core technical skills:** Python is required in nearly all top-paying roles. SQL, Spark, Pandas, NumPy, PySpark, Hadoop, Kafka, and Kubernetes are frequently listed.
- **Advanced and specialized skills for senior roles:** Machine learning frameworks such as TensorFlow, Keras, and PyTorch appear for Director-level positions. Cloud platforms like AWS, GCP, and Azure are important for Principal and remote roles.

- **Programming language diversity:** Scala, R, Java, Go, and Perl show up across various senior or managerial roles, highlighting the value of versatility.

- **Key takeaway:** To target high-paying data engineering positions, candidates should focus on Python, Spark, SQL, and cloud experience. Advanced ML tools and big data frameworks are essential for leadership or highly specialized roles

![Top Paying Roles](/assets/2_top_paying_job_skills.png)
*Bar graph visualizing the top skills for data engineers*

### 3. Most In-Demand Skills
To identify the most in-demand skills, I counted occurrences of each skill across all Data Engineer job postings. This shows which skills are highly sought after in the current job market.

```sql
SELECT 
    skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS skill_demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    USING(job_id)
INNER JOIN skills_dim
    USING(skill_id)
WHERE 
    job_title_short = 'Data Engineer'
GROUP BY skill_name
ORDER BY skill_demand_count DESC
LIMIT 10;
```
Breakdown:
- Python, SQL, and Spark are the most frequently required skills.
- These foundational tools are essential for building, maintaining, and optimizing data pipelines.
- Mastery of these skills is key for both entry-level and senior roles.

| Skills | Skills_demand_count |
|:--------:| :-----------: |
| sql | 113375 |
| python | 108265 |
| aws | 62174 |
| azure | 60823 |
| spark | 53789 |
| java | 35642 |
| kafka | 29163 |
| hadoop | 28883 |
| scala | 28791 |
| databricks | 27532 |


### 4. Skills Driving Salary
To identify which skills are associated with higher salaries, I calculated the average salary for job postings requiring each skill. This highlights which skills contribute to better compensation in Data Engineering roles.

```sql
SELECT 
    skills AS skill_name,
    ROUND(AVG(salary_year_avg), 2) AS avg_year_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    USING(job_id)
INNER JOIN skills_dim
    USING(skill_id)
WHERE 
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
GROUP BY skill_name
ORDER BY avg_year_salary DESC
LIMIT 25;
```
Breakdown:
- Specialized technologies like Node, MongoDB, Solidity, Rust, Kafka, and Kubernetes command higher pay.
- Expertise in niche areas increases earning potential.
- These skills are highly valued in top-tier positions.

| Skills | Avg_Salary ($USD) |
|:--------:| :-----------: |
| node | 181861.78 |
| mongo | 179402.54 |
| ggplot2 | 176250.00 |
| solidity | 166250.00 |
| vue | 159375.00 |
| codecommit | 155000.00 |
| ubuntu | 154455.00 |


### 5. Optimal Skills to Learn
To determine the most optimal skills to learn for career growth in data engineering, I combined the insights from the most in-demand skills and those driving higher salaries. This approach identifies skills that are both frequently required and associated with better compensation.

```sql
WITH top_demand_skills AS (
    SELECT 
        skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS skill_demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        USING(job_id)
    INNER JOIN skills_dim
        USING(skill_id)
    WHERE 
        job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skill_id, skills
), top_skill_salary AS (
    SELECT 
        skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 2) AS avg_year_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        USING(job_id)
    INNER JOIN skills_dim
        USING(skill_id)
    WHERE 
        job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skill_id, skills
)
SELECT 
    top_demand_skills.skill_id,
    top_demand_skills.skills,
    skill_demand_count,
    avg_year_salary
FROM top_demand_skills
INNER JOIN top_skill_salary 
    USING(skill_id)
WHERE skill_demand_count > 10
ORDER BY 
    avg_year_salary DESC,
    skill_demand_count DESC
LIMIT 25;
```

![Optimal Skills](/Data_jobs_analysis/assets/5_optimal_skills.png)
*Scatter plot visualizing the optimal skills for data engineers*

#  What i learned
Throughout this adventure, I dived deep into working with data, exploring its patterns and stories. I strengthened my SQL querying skills, learned how to aggregate and summarize large datasets effectively, and developed a sharper analytical mindset. Each challenge pushed me to think critically, uncover insights, and approach problems more strategically, making me more confident in turning raw data into meaningful conclusions.


#  Conclusions
### Insights
1. **Top-Paying Jobs:**
Remote, full-time Data Engineer roles offer the highest salaries.
These positions highlight the growing value of flexibility and experience.
Targeting them can significantly boost career earnings.
2. **Skills for Top Roles:**
Python, Spark, Big Data tools, and cloud platforms (AWS, Azure, GCP) dominate high-paying positions.
Mastering these skills is essential for senior-level roles.
They form the foundation of advanced data engineering work.
3. **Most In-Demand Skills:**
Python, SQL, and Spark appear most frequently across all roles.
These are critical for building and maintaining modern data pipelines.
They remain the core toolkit for aspiring Data Engineers.
4. **Skills Driving Salary:**
Specialized technologies like Node, MongoDB, Solidity, Rust, Kafka, and Kubernetes command higher pay.
Expertise in niche areas increases earning potential.
These skills are highly valued in top-tier positions.
5. **Optimal Skills to Learn:**
Combine high-demand and high-pay skills: Python, SQL, Spark, Kafka, Kubernetes, Node, and MongoDB.
Focusing on these ensures job security and financial reward.
They are strategic for remote and premium Data Engineer roles.

### Closing Thoughts
Throughout this project, I not only explored the Data Engineer job market but also significantly enhanced my own skills. Writing SQL queries, analyzing top-paying roles, and identifying key in-demand skills strengthened my analytical thinking and data-handling abilities. This experience has made me more confident in understanding the market, interpreting data, and applying insights-skills that I can carry forward into future projects and my career growth in data engineering.