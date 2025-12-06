--DATA INSERTION
BEGIN
    FOR i IN 1..150 LOOP
        INSERT INTO borrowers (
            first_name, last_name, dob, gender, phone, email,
            occupation, income, registration_date
        ) VALUES (
            'First'||i,
            'Last'||i,
            DATE '1985-01-01' + MOD(i, 8000),
            CASE WHEN MOD(i,2)=0 THEN 'M' ELSE 'F' END,
            '078' || TO_CHAR(100000 + i),
            'user'||i||'@mail.com',
            CASE 
                WHEN MOD(i,3)=0 THEN 'Teacher'
                WHEN MOD(i,3)=1 THEN 'Farmer'
                ELSE 'Engineer'
            END,
            50000 + (i * 150),
            SYSDATE - MOD(i, 400)
        );
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..200 LOOP
        INSERT INTO loans (
            borrower_id, loan_amount, loan_term, interest_rate,
            loan_status, application_date
        ) VALUES (
            MOD(i,150) + 1,       -- borrower_id range 1–150
            100000 + (i * 500),
            CASE 
                WHEN MOD(i,4)=0 THEN 12
                WHEN MOD(i,4)=1 THEN 6
                WHEN MOD(i,4)=2 THEN 24
                ELSE 36
            END,
            5 + MOD(i, 4),
            CASE 
                WHEN MOD(i,3)=0 THEN 'Approved'
                WHEN MOD(i,3)=1 THEN 'Pending'
                ELSE 'Rejected'
            END,
            SYSDATE - MOD(i, 200)
        );
    END LOOP;
END;
/



BEGIN
    FOR i IN 1..200 LOOP
        DECLARE 
            cs NUMBER := 300 + MOD(i * 13, 500);
        BEGIN
            INSERT INTO risk_evaluations (
                loan_id, credit_score, risk_level, evaluation_date
            ) VALUES (
                i,        -- loan_id 1–200
                cs,
                CASE 
                    WHEN cs >= 650 THEN 'Low'
                    WHEN cs >= 500 THEN 'Medium'
                    ELSE 'High'
                END,
                SYSDATE - MOD(i, 50)
            );
        END;
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..300 LOOP
        INSERT INTO payments (
            loan_id, payment_date, amount_paid, payment_method
        ) VALUES (
            MOD(i,200) + 1,          -- valid loan_id
            SYSDATE - MOD(i, 180),
            10000 + (i * 120),
            CASE
                WHEN MOD(i,3)=0 THEN 'Mobile Money'
                WHEN MOD(i,3)=1 THEN 'Cash'
                ELSE 'Bank Transfer'
            END
        );
    END LOOP;
END;
/