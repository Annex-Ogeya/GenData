USE stud_db;

# Create a view for each question, the view name is in the brackets and in italics
# Using JOIN get the student names, school id, email, phone number (new_stud_details)
CREATE VIEW new_stud_details AS
SELECT p.stud_name, p.stud_ID, s.stud_email, c.phone_number
FROM personal_details p
JOIN school_details s ON p.stud_ID = s.stud_ID
JOIN contact_details c ON s.stud_email = c.stud_email;

# Create a table with all the details from contacts to school and financial details (full_stud_details)
CREATE VIEW full_stud_details AS
SELECT p.national_ID, p.stud_ID, p.stud_name, p.phone_number AS personal_phone, p.age, p.gender,
       s.current_home_county, s.secondary_school_county, s.residence, s.stud_email,
       c.next_of_kin_name, c.next_of_kin_relation, c.next_of_kin_contacts,
       f.sem_fee, f.fee_paid
FROM personal_details p
JOIN school_details s ON p.stud_ID = s.stud_ID
JOIN contact_details c ON s.stud_email = c.stud_email
JOIN financial_details f ON p.stud_ID = f.stud_ID;

# Add student names on any empty row of stud_name in financial_details
UPDATE financial_details f
JOIN personal_details p ON f.stud_ID = p.stud_ID
SET f.stud_name = p.stud_name
WHERE f.stud_name IS NULL;

set SQL_SAFE_UPDATES = 0;

# On the financial_details table add a column, fee_cleared, that has True if student has cleared current fee and False if not (financial_details_view)
ALTER TABLE financial_details
ADD COLUMN fee_cleared BOOLEAN;

UPDATE financial_details
SET fee_cleared = CASE 
                     WHEN fee_paid >= sem_fee THEN TRUE
                     ELSE FALSE
                  END;

CREATE VIEW financial_details_view AS
SELECT * FROM financial_details;

# Get the national ID and name of all students who have cleared their fees (fee_cleared)
CREATE VIEW fee_cleared AS
SELECT p.national_ID, f.stud_name
FROM personal_details p
JOIN financial_details f ON p.stud_ID = f.stud_ID
WHERE f.fee_cleared = TRUE;

# Get the total sum of fees paid so far and the total current deficit (total_fee_balance)
CREATE VIEW total_fee_balance AS
SELECT SUM(fee_paid) AS total_fees_paid,
       SUM(sem_fee - fee_paid) AS total_deficit
FROM financial_details;

# Get the count of students who share a current home county i.e., Say Nairobi, get the number of students who’s current_home_county is Nairobi, and so on for all available counties (home_county_count)
CREATE VIEW home_county_count AS
SELECT current_home_county, COUNT(*) AS student_count
FROM school_details
GROUP BY current_home_county;

# Get the count of Male and/or Female students from each secondary_school_county (secondary_school_count)
CREATE VIEW secondary_school_count AS
SELECT s.secondary_school_county,
       SUM(CASE WHEN p.gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
       SUM(CASE WHEN p.gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM personal_details p
JOIN school_details s ON p.stud_ID = s.stud_ID
GROUP BY s.secondary_school_county;

# Get the percentage of students who set their next_of_kin as Mother vs those that set it as Father1. (kin_percentage)
CREATE VIEW kin_percentage AS
SELECT 
    ROUND(100 * SUM(CASE WHEN next_of_kin_relation='Mother' THEN 1 ELSE 0 END) / COUNT(*),2) AS mother_percentage,
    ROUND(100 * SUM(CASE WHEN next_of_kin_relation='Father' THEN 1 ELSE 0 END) / COUNT(*),2) AS father_percentage
FROM contact_details;

select * from kin_percentage;
select * from fee_cleared;
select * from total_fee_balance;