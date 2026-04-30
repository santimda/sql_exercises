/* 
Question: What skills are required for the top-paying data scientist jobs? 
- Use the top 20 highest-paying data scientist jobs from the first query
- Add the specific skills required for these roles
- Why? Help job seekers understand which skills are in demand for the 
    highest-paying positions.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_posting_fact
    LEFT JOIN company_dim ON job_posting_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 20
)   
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;


-- Extra step: count the appearance of each skill in the top-paying jobs to identify the most in-demand skills
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_posting_fact
    LEFT JOIN company_dim ON job_posting_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 20
)   
SELECT 
    skills,
    COUNT(*) AS skill_count
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
HAVING
    COUNT(*) > 1
ORDER BY
    skill_count DESC;