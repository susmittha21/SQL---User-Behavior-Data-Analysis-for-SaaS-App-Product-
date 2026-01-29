
# User Behavior & Funnel Analysis for a SaaS Product using SQL

---

## Problem Statement

SaaS products generate large volumes of user interaction data, but without structured analysis, it is difficult to understand how users behave after signup, where they drop off, and which acquisition sources drive meaningful engagement and conversions.

This project analyzes user behavior data to identify engagement patterns, funnel drop-offs, and conversion performance using SQL.

The objective of this analysis is to:

- Analyze user acquisition sources and signup trends
- Understand user engagement and activity behavior
- Perform funnel and drop-off analysis
- Measure conversion rates from signup to purchase
- Estimate time taken by users to convert
- Derive actionable insights that can support product and marketing decisions
  
---

## Dataset Description

The dataset represents user activity data from a SaaS / app-based product and consists of two tables:

- users table: <br>
user_id – Unique user identifier <br>
signup_date – Date user signed up <br>
source – Acquisition source (ads, organic, referral) <br>
<br>
- events table:<br>
user_id – User identifier<br>
event_date – Date of event<br>
event_type – User action (signup, login, add_to_cart, purchase)


---

## Key Insights

- ~50% of users signed up but never logged in, indicating onboarding or intent mismatch.
- Organic and Referral sources contributed the highest number of signups.
- Only ~14% of total signups completed a purchase, highlighting funnel leakage.
- Average time from signup to purchase was ~3-4 days, suggesting a short decision cycle.
- A significant portion of users dropped off between signup and first login, making it the most critical funnel stage.

---

## TOOLS USED 
MySQL Workbench <br>
SQL 

---

