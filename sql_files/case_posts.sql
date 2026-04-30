SELECT 
    COUNT(job_id),
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_posting_fact
WHERE
    job_title_short IN ('Data Scientist', 'Data Engineer', 'Data Analyst')  
GROUP BY 
    location_category;