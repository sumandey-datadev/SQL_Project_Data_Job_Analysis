WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS DemandCount

    FROM 
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN 
        skills_dim  ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home=TRUE
    GROUP BY 
        skills_dim.skill_id

),
avaerage_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
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
        skills_dim.skill_id
  
 )
 SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    DemandCount,
    averagesalary
FROM 
    skills_demand
INNER JOIN
    avaerage_salary ON skills_demand.skill_id=avaerage_salary.skill_id
WHERE
    DemandCount>10
ORDER BY
    averagesalary DESC,
    DemandCount DESC
LIMIT 25;
    
