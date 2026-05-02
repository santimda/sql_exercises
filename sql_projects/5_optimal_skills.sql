/*
Question: What are the most optimal skills to learn (a.k.a. in high
demand and a high paying skill)?
- Identify skills in high demand and associated with high 
average salaries for Data Scientist roles. 
- Concentrate on remote positions with specified salaries
- Why? Offer strategic insights for career development
*/

-- First a long version using CTEs for clarity, then a more concise version without CTEs.

WITH skills_demand AS (
    SELECT 
        s.skill_id,
        s.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_posting_fact jp
    INNER JOIN 
        skills_job_dim ON jp.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim s ON skills_job_dim.skill_id = s.skill_id
    WHERE 
        jp.job_title_short LIKE 'Data Scientist' AND
        jp.job_work_from_home = TRUE AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY 
        s.skill_id
), average_salary AS (
    SELECT 
        s.skill_id,
        ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary
    FROM 
        job_posting_fact jp
    INNER JOIN 
        skills_job_dim s ON jp.job_id = s.job_id
    INNER JOIN 
        skills_dim ON s.skill_id = skills_dim.skill_id
    WHERE 
        jp.job_title_short LIKE 'Data Scientist' AND
        jp.job_work_from_home = TRUE AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY 
        s.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM 
    skills_demand
INNER JOIN 
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE 
    skills_demand.demand_count > 10 AND
    average_salary.avg_salary > 100000
ORDER BY 
    demand_count DESC, avg_salary DESC
LIMIT 20


-- rewrite this same query more concisely

SELECT 
    s.skill_id,
    s.skills,
    COUNT(jp.job_id) AS demand_count,
    ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary
FROM 
    job_posting_fact jp
INNER JOIN 
    skills_job_dim sj ON jp.job_id = sj.job_id
INNER JOIN
    skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    jp.job_title_short LIKE 'Data Scientist' AND
    jp.job_work_from_home = TRUE AND
    jp.salary_year_avg IS NOT NULL
GROUP BY 
    s.skill_id
HAVING 
    COUNT(jp.job_id) > 10 AND
    AVG(jp.salary_year_avg) > 100000
ORDER BY 
    demand_count DESC, avg_salary DESC
LIMIT 20;   