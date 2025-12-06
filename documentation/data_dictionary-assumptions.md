# 📘 Data Dictionary

After Normalization (1NF → 3NF) this is the final result of all the tables.

## 1.BORROWER

| Column Name       | Data Type     | Description                    | Constraints      |
| ----------------- | ------------- | ------------------------------ | ---------------- |
| borrower_id       | NUMBER(10)    | Unique borrower identifier     | PK               |
| full_name         | VARCHAR2(100) | Borrower’s full legal name     | NOT NULL         |
| national_id       | VARCHAR2(20)  | National identification number | UNIQUE, NOT NULL |
| phone             | VARCHAR2(20)  | Contact phone number           | NOT NULL         |
| email             | VARCHAR2(100) | Email address                  | NULL             |
| occupation        | VARCHAR2(50)  | Type of work or business       | NULL             |
| income_level      | NUMBER(10,2)  | Monthly income estimate        | NULL             |
| registration_date | DATE          | Date borrower was registered   | DEFAULT SYSDATE  |

## 2.LOAN_APPLICATION

| Column Name      | Data Type     | Description                                    | Constraints                  |
| ---------------- | ------------- | ---------------------------------------------- | ---------------------------- |
| application_id   | NUMBER(10)    | Unique loan application ID                     | PK                           |
| borrower_id      | NUMBER(10)    | ID of applicant                                | FK → BORROWER.borrower_id    |
| requested_amount | NUMBER(12,2)  | Amount requested by borrower                   | NOT NULL                     |
| purpose          | VARCHAR2(150) | Stated purpose for the loan                    | NOT NULL                     |
| application_date | DATE          | Submission date                                | DEFAULT SYSDATE              |
| status           | VARCHAR2(20)  | Application status (PENDING/APPROVED/REJECTED) | CHECK constraint             |
| risk_score       | NUMBER(5,2)   | System-evaluated risk score                    | NULL                         |
| loan_officer_id  | NUMBER(10)    | Officer who assessed the application           | FK → LOAN_OFFICER.officer_id |

## 3. LOAN_OFFICER

| Column Name    | Data Type     | Description                   | Constraints |
| -------------- | ------------- | ----------------------------- | ----------- |
| officer_id     | NUMBER(10)    | Unique identifier for officer | PK          |
| full_name      | VARCHAR2(100) | Officer’s name                | NOT NULL    |
| position_title | VARCHAR2(50)  | Job title                     | NOT NULL    |
| phone          | VARCHAR2(20)  | Contact number                | NOT NULL    |

## 4.LOAN

| Column Name       | Data Type    | Description                     | Constraints                          |
| ----------------- | ------------ | ------------------------------- | ------------------------------------ |
| loan_id           | NUMBER(10)   | Unique loan identifier          | PK                                   |
| application_id    | NUMBER(10)   | Approved application reference  | FK → LOAN_APPLICATION.application_id |
| approved_amount   | NUMBER(12,2) | Final amount approved           | NOT NULL                             |
| disbursement_date | DATE         | Date loan funds were released   | NOT NULL                             |
| interest_rate     | NUMBER(5,2)  | Interest rate (%)               | NOT NULL                             |
| loan_term_months  | NUMBER(3)    | Number of repayment months      | NOT NULL                             |
| status            | VARCHAR2(20) | Active, Completed, or Defaulted | CHECK constraint                     |

## 5.REPAYMENT

| Column Name  | Data Type    | Description                          | Constraints       |
| ------------ | ------------ | ------------------------------------ | ----------------- |
| repayment_id | NUMBER(10)   | Unique repayment identifier          | PK                |
| loan_id      | NUMBER(10)   | Loan being repaid                    | FK → LOAN.loan_id |
| due_date     | DATE         | Scheduled due date                   | NOT NULL          |
| amount_due   | NUMBER(12,2) | Amount expected for that installment | NOT NULL          |
| amount_paid  | NUMBER(12,2) | Amount borrower paid                 | NULL              |
| payment_date | DATE         | Actual date of payment               | NULL              |
| status       | VARCHAR2(20) | PAID / PENDING / LATE                | CHECK constraint  |

## 6.RISK_EVALUATION_LOG

| Column Name     | Data Type     | Description                              | Constraints                          |
| --------------- | ------------- | ---------------------------------------- | ------------------------------------ |
| log_id          | NUMBER(10)    | Unique log entry ID                      | PK                                   |
| application_id  | NUMBER(10)    | Related loan application                 | FK → LOAN_APPLICATION.application_id |
| evaluation_date | DATE          | Timestamp of evaluation                  | DEFAULT SYSDATE                      |
| risk_score      | NUMBER(5,2)   | Score generated by PL/SQL risk procedure | NOT NULL                             |
| remarks         | VARCHAR2(200) | Optional notes                           | NULL                                 |

# 📌 Assumptions

Below are the business and technical assumptions used when designing the system:

## Borrower & Application

- All borrowers must have a valid national ID.

- A borrower can have multiple applications but only one active application at a time.

- Applications cannot be approved without a risk evaluation.

- Risk scores range from 0 to 100.

## Loan Processing

- Loans must be linked to an approved loan application.

- A loan cannot be disbursed without specifying interest_rate and loan_term_months.

- Only loan officers can approve or reject applications.

## Repayments

- Every loan generates multiple scheduled repayments based on the loan term.

- A repayment installment is considered LATE if payment_date > due_date.

- Payments can be partial; status updates accordingly (handled by PL/SQL triggers or procedures).

## System Behavior

- Risk evaluation is generated automatically using PL/SQL procedures.

- All financial values use NUMBER(x,y) with two decimal places.

- Audit logs (risk evaluation logs) must never be deleted.

- Dates default to SYSDATE unless otherwise provided.

## Technical Assumptions

- Oracle Database 19c or higher is used.

- PL/SQL packages manage loan approval, scoring, and repayment calculations.

- All tables follow full 3NF normalization.
