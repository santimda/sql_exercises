-- Count the number of Data Scientist job postings by month
SELECT 
    count(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_posting_fact
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    month 
ORDER BY month ASC;
