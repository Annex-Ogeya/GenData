
# SQL schema for CC GENERAL dataset (MySQL syntax)
# Normalized design

CREATE DATABASE CC_General_DB;
USE CC_General_DB;

CREATE TABLE customers (
  cust_id VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE account_summary (
  cust_id VARCHAR(20) NOT NULL,
  balance DECIMAL(14,2),
  balance_frequency FLOAT,
  credit_limit DECIMAL(14,2),
  tenure INT,
  FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE purchases_summary (
  cust_id VARCHAR(20) NOT NULL,
  purchases DECIMAL(14,2),
  oneoff_purchases DECIMAL(14,2),
  installments_purchases DECIMAL(14,2),
  purchases_frequency FLOAT,
  oneoff_purchases_frequency FLOAT,
  purchases_installments_frequency FLOAT,
  purchases_trx INT,
  FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE cash_advance_summary (
  cust_id VARCHAR(20) NOT NULL,
  cash_advance DECIMAL(14,2),
  cash_advance_frequency FLOAT,
  cash_advance_trx INT,
  FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE payments_summary (
  cust_id VARCHAR(20) NOT NULL,
  payments DECIMAL(14,2),
  minimum_payments DECIMAL(14,2),
  prc_full_payment FLOAT,
  FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

# Denormalized single-table option (matches original file)
CREATE TABLE cc_general (
  cust_id VARCHAR(20) NOT NULL PRIMARY KEY,
  balance DECIMAL(14,2),
  balance_frequency FLOAT,
  purchases DECIMAL(14,2),
  oneoff_purchases DECIMAL(14,2),
  installments_purchases DECIMAL(14,2),
  cash_advance DECIMAL(14,2),
  purchases_frequency FLOAT,
  oneoff_purchases_frequency FLOAT,
  purchases_installments_frequency FLOAT,
  cash_advance_frequency FLOAT,
  cash_advance_trx INT,
  purchases_trx INT,
  credit_limit DECIMAL(14,2),
  payments DECIMAL(14,2),
  minimum_payments DECIMAL(14,2),
  prc_full_payment FLOAT,
  tenure INT
);

# Insert into customers
INSERT INTO customers (cust_id)
VALUES ('C10001'), ('C10002'), ('C10003');

# Insert into account_summary
INSERT INTO account_summary (cust_id, balance, balance_frequency, credit_limit, tenure)
VALUES 
('C10001', 1200.50, 0.85, 5000, 12),
('C10002', 800.75, 0.78, 4000, 10),
('C10003', 1500.00, 0.92, 7000, 15);

# Insert into purchases_summary
INSERT INTO purchases_summary (cust_id, purchases, oneoff_purchases, installments_purchases, purchases_frequency, oneoff_purchases_frequency, purchases_installments_frequency, purchases_trx)
VALUES
('C10001', 3000.00, 1200.00, 1800.00, 0.80, 0.60, 0.50, 25),
('C10002', 1500.00, 700.00, 800.00, 0.75, 0.55, 0.40, 20),
('C10003', 4200.00, 2200.00, 2000.00, 0.85, 0.65, 0.55, 35);

# Insert into cash_advance_summary
INSERT INTO cash_advance_summary (cust_id, cash_advance, cash_advance_frequency, cash_advance_trx)
VALUES
('C10001', 600.00, 0.30, 4),
('C10002', 400.00, 0.25, 3),
('C10003', 1000.00, 0.40, 6);

# Insert into payments_summary
INSERT INTO payments_summary (cust_id, payments, minimum_payments, prc_full_payment)
VALUES
('C10001', 2000.00, 150.00, 0.80),
('C10002', 1200.00, 100.00, 0.70),
('C10003', 3000.00, 200.00, 0.85);

# ERD DIAGRAM

# Combine the Data Using Primary & Foreign Keys
# Create an analytical View
CREATE VIEW vw_customer_full AS
SELECT 
    c.cust_id,

    # Account Summary
    a.balance,
    a.balance_frequency,
    a.credit_limit,
    a.tenure,

    # Purchases Summary
    p.purchases,
    p.oneoff_purchases,
    p.installments_purchases,
    p.purchases_frequency,
    p.oneoff_purchases_frequency,
    p.purchases_installments_frequency,
    p.purchases_trx,

    # Cash Advance Summary
    ca.cash_advance,
    ca.cash_advance_frequency,
    ca.cash_advance_trx,

    # Payments Summary
    pay.payments,
    pay.minimum_payments,
    pay.prc_full_payment,


# Basic calculations
# Total Monthly Activity Score


(COALESCE(p.purchases,0)
 + COALESCE(ca.cash_advance,0)
 + COALESCE(pay.payments,0)) AS total_activity,



    # Credit utilization ratio
    (CASE 
        WHEN a.credit_limit > 0 THEN a.balance / a.credit_limit
        ELSE NULL
     END) AS credit_utilization_ratio,

    # Purchase behavior split
    (CASE 
        WHEN p.purchases > 0 THEN p.oneoff_purchases / p.purchases
        ELSE NULL
     END) AS oneoff_purchase_ratio,

    (CASE 
        WHEN p.purchases > 0 THEN p.installments_purchases / p.purchases
        ELSE NULL
     END) AS installments_purchase_ratio,

    # Sample risk score
    (
        COALESCE((a.balance / a.credit_limit),0) * 0.4 +
        COALESCE(ca.cash_advance_frequency,0) * 0.3 +
        COALESCE((1 - pay.prc_full_payment),0) * 0.3
    ) AS risk_score
    
    FROM customers c
LEFT JOIN account_summary a ON c.cust_id = a.cust_id
LEFT JOIN purchases_summary p ON c.cust_id = p.cust_id
LEFT JOIN cash_advance_summary ca ON c.cust_id = ca.cust_id
LEFT JOIN payments_summary pay ON c.cust_id = pay.cust_id;

select * from payments_summary limit 3;
SELECT * FROM vw_customer_full;