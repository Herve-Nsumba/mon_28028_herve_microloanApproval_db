
# System Architecture Overview

The Microloan Approval & Risk Evaluation System uses a structured, layered PL/SQL architecture designed for modularity, maintainability, and analytical extensibility.

---

## **1. Architecture Layers**

### **A. Data Layer**
Contains Oracle database objects:
- Tables (Borrowers, Loans, Payments, Risk Evaluations, Holidays, Audit_Log)
- Constraints (PK, FK, CHECK)
- Indexes for performance

### **B. Logic Layer**
Implements business rules through:
- Stored procedures (loan creation, approval, payments)
- Functions (risk scoring, validation, KPI calculations)
- Packages (grouping all logic in `microloan_pkg`)
- Cursors for multi-row operations

### **C. Control Layer**
Enforces database policies:
- Triggers (insert/update/delete restrictions)
- Compound triggers (Payments table auditing)
- Auditing subsystem (inserted via log_audit)

### **D. BI Layer**
Supports analytics:
- Aggregation queries
- Dimensional modeling
- KPI calculations
- Dashboard-ready views

---

## **2. Workflow Diagram (Text Version)**

```
Borrower → Loan Application → Risk Evaluation → Approval/Reject → Payments → BI Reporting
```

---

## **3. Data Flow Summary**
- **Borrower submits loan → LOANS table**
- **Risk recalculated → RISK_EVALUATIONS updated**
- **Loan approved → triggers business rules**
- **Payment logged → PAYMENTS table**
- **All actions audited → AUDIT_LOG**
- **BI dashboards read aggregated tables**

---

## **4. Technology Stack**
- Oracle Database 21c XE
- PL/SQL stored packages
- SQL Developer for development
- BI tools (Tableau / PowerBI / Looker)

---

## **5. Architectural Goals**
- Maintain clean separation of logic
- Support high audit fidelity
- Allow BI-ready reporting
- Enable scalability for future enhancements
