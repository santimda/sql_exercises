-- Subquery exemple 

FROM (-- SubQuery starts here
    SELECT *
    FROM job_posting_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here


-- Another example of subquery to find companies that 
-- have job postings mentioning "no degree required"

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT company_id 
    FROM job_posting_fact
    WHERE job_no_degree_mention = TRUE
    ORDER BY company_id
); 


-- CTE example
WITH january_jobs AS (
    SELECT *
    FROM job_posting_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;  


/*
Another example of CTE to find the companies that
have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS (
    SELECT 
            company_id,
            COUNT(*) AS total_jobs
    FROM 
            job_posting_fact
    GROUP BY
            company_id
)   
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY 
    company_job_count.total_jobs DESC
LIMIT 10;