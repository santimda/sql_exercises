/*
Find job postings from the first quarter that have a salary > 70k
- Combine job posting tables from the first quarter (Jan-Mar)
- Get job postings with an average yearly salary greater than 70k
*/

SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Scientist'
ORDER BY quarter1_job_postings.salary_year_avg DESC