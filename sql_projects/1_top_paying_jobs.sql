/* 
Question: What are the top-paying data scientist jobs? 
- Identify the top 10 highest-paying data scientist jobs that are available remotely.
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlight the top-paying opportunities for data scientists, offering insights into employment.  
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
LIMIT 10;