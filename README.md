## GENDATA CAPSTONE - Customer Behavior and Credit Insights
For this capstone I downloaded a dataset from kaggle https://www.kaggle.com/datasets/arjunbhasin2013/ccdata.This case requires to develop a customer segmentation to define marketing strategy.The
sample Dataset summarizes the usage behavior of about 9000 active credit card holders during the last 6 months. The file is at a customer level with 18 behavioral variables.This dataset contains demographic information, credit limits, billing statements, and payment history for credit card clients in Taiwan from April 2005 to September 2005.

## Problem Statement
Credit card providers need to understand customer spending behavior, credit utilization, and default risk in order to:

- Optimize credit limits

- Identify high-value customers

- Detect high-risk clients early

- Personalize offerings (e.g., credit increases, loyalty programs)

This capstone project uses the Default of Credit Card Clients dataset to explore customer usage behavior, tenure, credit limits, payments, and risk patterns.
The goal is to build a Tableau dashboard that can support data-driven decisions in credit management.

## Project Objectives and KPIs
### Primary Objectives
- Segment customers based on credit behavior
- Visualize monthly activity
- Analyze credit utilization and risk
- Build a dashboard to support strategic decisions

  ### KPIs Tracked
- Average Credit Limit
- Monthly Total Activity (Purchases + Cash Advance + Payments)
- Credit Utilization Ratio
- Risk Score
- Customer Segments (Heavy vs Light Users)

## Data Pipeline
- Raw CSV (Kaggle)
     - ↓
- MySQL Database
     - ↓
- Data Cleaning & Normalization
     - ↓
- Loading Data into BiqQuery
    -  ↓
- Tableau Connection
    -  ↓
- Dashboard & Insights

  ## ERD DIAGRAM
  
## Dashboard Overview

### Dashboard Components
 - Customer Segmentation (High vs Low Activity)
 - Purchases vs Payments Scatter
 - Total Activity Bar Chart 
- Credit Limit Distribution Chart
- Credit Utilization vs Risk Scatter
- Tenure vs Credit Limit Plot
- Customer Detail Table
- Filters for Segments, Risk, Tenure.

## Key Insights
- Customers with longer tenure often have higher credit limits.

- Heavy users demonstrate unique risk and spending patterns compared to light users.

- High credit utilization correlates with increased default likelihood.

- Customer segmentation enables targeted credit limit adjustments and retention strategies.

## Recommendations
- Optimize Credit Limits Based on Utilization
- Monitor High-Risk Customers
- Reward High-Value Customers,e.g cashbacks,loyalty points and installment plans
- Enhance Collections Strategy
- Engage Low-Activity Customers,e.g educating on card benefits.

## Dashboard Preview

<img width="1488" height="795" alt="image" src="https://github.com/user-attachments/assets/d3bfefd2-387a-4c02-9ae6-ae4232bc7b9a" />

<https://public.tableau.com/app/profile/annex.ogeya/viz/CustomerCreditCardAnalysis_17640672604130/Dashboard1?publish=yes/>
