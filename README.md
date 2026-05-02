# Introduction
Analysis of data job market, exploring top-paying jobs and in-demand skills. 

SQL queries in [sql_projects](/sql_projects/)

# Background
Followed the [SQL Course](https://www.youtube.com/watch?v=7mz73uXD9DA) by Luke Barousse to practice SQL with real-world data.

### Questions addressed:
1. What are the top-paying data scientist jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
The key tools were:
- **SQL**: The backbone of the analysis, allowing me to query the database for critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & Github**: Standard version control software.


# The Analysis
I performed queries to retrieve specific insights. In particular, to obtain the optimal skills for data scientists I did:


```sql
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
```

The main takeaway is that Python, SQL, R and AWS are highly rewarding skills for Data Scientists. 


# Conclusions

These exercises helped me to polish my SQL skills and allowed me to pick up a few extra tools in the process. 
