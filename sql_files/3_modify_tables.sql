COPY company_dim
FROM '/home/santiagodp/Documents/SQL/luke_course/advanced_exercises/csv_files/company_dim_table.csv'
DELIMITER E'\t' CSV HEADER;

COPY job_posting_fact
FROM '/home/santiagodp/Documents/SQL/luke_course/advanced_exercises/csv_files/job_postings_fact_table.csv'
DELIMITER E'\t' CSV HEADER;

COPY skills_dim
FROM '/home/santiagodp/Documents/SQL/luke_course/advanced_exercises/csv_files/skills_dim_table.csv'
DELIMITER E'\t' CSV HEADER;

COPY skills_job_dim
FROM '/home/santiagodp/Documents/SQL/luke_course/advanced_exercises/csv_files/skills_job_dim_table.csv'
DELIMITER E'\t' CSV HEADER;
