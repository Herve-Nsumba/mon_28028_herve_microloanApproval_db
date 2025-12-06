
# Design Decisions Documentation

This file explains the rationale behind major design choices in the Microloan Approval & Risk Evaluation System.

---

## **1. Normalized Relational Structure**
Tables follow 3NF to reduce redundancy and ensure data integrity:
- BORROWERS separated from LOANS
- RISK_EVALUATIONS separate to support recalculation
- PAYMENTS separate for many-to-one relationship

This improves maintainability and BI clarity.

---

## **2. Use of PL/SQL Packages**
All procedures and functions are grouped under `microloan_pkg`:
- Cleaner namespace
- Easier code management
- Supports modularity and abstraction

---

## **3. Error Logging Approach**
A central `error_log` table was chosen because:
- It keeps application audit separate from business audits
- Provides a debugging trail
- Supports future monitoring dashboards

---

## **4. Business Rule Enforcement via Triggers**
In Phase VII, restrictions on DML operations are implemented using triggers because:
- Database-level policies enforce consistency even if UI changes
- Ensures zero bypass regardless of client application
- Simplifies control logic through the restriction-check function

---

## **5. BI Architecture Choices**
KPIs and dashboards are based on:
- Industry-standard microfinance metrics
- Availability of structured data from base tables
- Separation of fact vs. dimension data for clarity

---

## **6. Use of Explicit Cursors**
Explicit cursors chosen for multi-row risk recalculation because:
- They satisfy academic requirements
- Provide full control over row-by-row processing
- Easy to expand into bulk operations later

---

## **7. Holiday-based Access Restrictions**
A holidays table was created because:
- Dates change yearly
- School/business closures need updates without changing code
- Supports BI analysis of blocked operations

---

# Summary
These decisions ensure the system is modular, scalable, auditable, and BI-ready. Each architectural choice was made to satisfy both academic requirements and real-world microfinance workflows.
