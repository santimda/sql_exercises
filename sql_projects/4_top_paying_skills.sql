/*
Question: What are the top-paying skills for Data Scientists?
- Look at the average salary asscoiated with each skill for Data Scientist jobs
- Focus on roles with specified salaries (remove nulls)
- Remove skills that are not commonly listed (less than 10 occurrences)
- Why? Idenfity the most financially rewarding skills for Data Scientists
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary, -- round to integers
    COUNT(*) AS num_jobs
FROM job_posting_fact
INNER JOIN skills_job_dim ON job_posting_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
HAVING 
    COUNT(*) > 10 
ORDER BY
    AVG(salary_year_avg) DESC
LIMIT 20;

/* 
Here is a breakdown of the results for top-paying skills for Data Scientists.

The highest-paying clusters are:
1. Data infrastructure
→ Spark, Airflow, BigQuery

2. ML systems
→ PyTorch, Hugging Face

3. Distributed/backend systems
→ Go, DynamoDB

4. Specialised domains
→ Neo4j, GDPR

🔍 Subtle but important insight

High salary correlates with:
- impact radius (how much of the company depends on your work)
- system complexity
- difficulty of replacement

Not with:
- individual tools per se

*/