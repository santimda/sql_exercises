/*
Question: What are the most in-demand skills for Data Scientists?
- Join job postings to inner join table
- Identify the top 5 in-demand skills for a Data Scientist role
- Focus on all job postings.
- Why? Provide insights into the most sought-after skills for 
Data Scientists, helping job seekers prioritize their skill development.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_posting_fact
INNER JOIN skills_job_dim ON job_posting_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist'
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;