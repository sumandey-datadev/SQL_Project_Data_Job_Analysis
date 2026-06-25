SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS averagesalary
FROM
    skills_dim
INNER JOIN
    skills_job_dim ON skills_dim.skill_id=skills_job_dim.skill_id
INNER JOIN
    job_postings_fact ON skills_job_dim.job_id=job_postings_fact.job_id
WHERE 
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home=TRUE
GROUP BY
    skills
ORDER BY 
    averagesalary DESC
LIMIT 25;
