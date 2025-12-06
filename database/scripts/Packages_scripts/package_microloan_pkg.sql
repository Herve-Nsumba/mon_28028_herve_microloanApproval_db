CREATE OR REPLACE PACKAGE microloan_pkg AS

  -- ========== FUNCTIONS ==========
  FUNCTION calculate_risk_score(
    p_loan_amount IN NUMBER,
    p_loan_term   IN NUMBER
  ) RETURN NUMBER;

  FUNCTION validate_phone(
    p_phone IN VARCHAR2
  ) RETURN VARCHAR2;

  FUNCTION average_payment(
    p_loan_id IN NUMBER
  ) RETURN NUMBER;

  -- ========== PROCEDURES ==========
  PROCEDURE create_loan(
    p_borrower_id   IN  NUMBER,
    p_loan_amount   IN  NUMBER,
    p_loan_term     IN  NUMBER,
    p_interest_rate IN  NUMBER DEFAULT 5,
    p_new_loan_id   OUT NUMBER,
    p_result        OUT VARCHAR2
  );

  PROCEDURE approve_loan(
    p_loan_id IN NUMBER,
    p_result  OUT VARCHAR2
  );

  PROCEDURE record_payment(
    p_loan_id     IN NUMBER,
    p_amount_paid IN NUMBER,
    p_method      IN VARCHAR2,
    p_result      OUT VARCHAR2
  );

  PROCEDURE batch_recalculate_risk(
    p_result OUT VARCHAR2
  );

END microloan_pkg;
/
