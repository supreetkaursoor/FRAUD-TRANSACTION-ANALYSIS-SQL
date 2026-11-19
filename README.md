# Credit Card Fraud Detection & Transaction Analysis | PostgreSQL

## 1. Project Overview

Credit card fraud is a major challenge for financial institutions. Identifying suspicious transactions requires analyzing historical spending patterns, transaction frequency, unusual transaction amounts, transaction timing and cardholder behaviour.

This project focuses on analyzing historical credit card transaction data using **PostgreSQL** to identify unusual spending patterns, investigate suspicious transactions and generate potential fraud risk indicators.

The project covers relational database design, data importing, SQL-based business analysis, transaction behaviour analysis, rule-based fraud scoring and statistical outlier detection.

## 2. Tools & Technologies

- **Database:** PostgreSQL
- **Database Design:** QuickDBD
- **Techniques:** SQL Analysis, Exploratory Data Analysis, Fraud Risk Scoring, Statistical Outlier Detection

## 3. Dataset Overview

The project uses five CSV files:

| Dataset | Description |
|---|---|
| card_holder.csv | Cardholder information |
| credit_card.csv | Credit card details |
| merchant.csv | Merchant information |
| merchant_category.csv | Merchant category details |
| transaction.csv | Historical transaction records |

**Dataset Size:** 3,500 transactions

## 4. Data Modeling & Data Engineering

- Designed an Entity Relationship Diagram (ERD) using QuickDBD.
- Created a relational database in PostgreSQL.
- Created five tables: `card_holder`, `credit_card`, `merchant`, `merchant_category` and `transaction`.
- Defined primary key and foreign key relationships where applicable.
- Imported CSV files into PostgreSQL using the `COPY` command.
- Validated imported records and corrected inconsistent credit card numbers using SQL UPDATE statements.

## 5. SQL Data Analysis

Performed SQL analysis covering business insights, transaction patterns, cardholder behaviour, merchant activity and potential fraud detection.

### A. Basic Business Insights

Analyzed overall transaction performance, including:

- Total number and value of transactions.
- Average, minimum and maximum transaction amounts.
- Number of unique cardholders, credit cards and merchants.
- Transaction count and total spending by merchant category.
- Average transaction amount by merchant category.
- Merchants with the highest transaction volume and transaction value.
- Cardholders with the highest number of transactions and total spending.
- Average spending per cardholder.
- Total spending and average transaction amount by credit card.
- Top 10 merchants and cardholders by total spending.

### B. Time-Based Analysis

Investigated transaction behaviour across different dates and hours.

- Daily transaction volume and total transaction amount.
- Average transaction amount by date.
- Dates with the highest transaction volume and spending.
- Busiest transaction hours.
- Total and average transaction amounts by hour.
- Daytime versus nighttime transaction activity.
- Identification of late-night transactions occurring between 12 AM and 5 AM.

### C. Cardholder & Merchant Analysis

Analyzed customer spending patterns and merchant relationships.

- Cardholders transacting across the highest number of merchants.
- Cardholders transacting across the highest number of merchant categories.
- Merchants with the highest average transaction amounts.
- Merchant categories with the highest average spending per cardholder.
- Cardholders with average transaction amounts above the overall average.
- Cardholders with the highest number of small-value transactions.
- Cards used across the highest number of different merchants.
- Merchants serving the highest number of unique cardholders.

### D. Fraud Detection Analysis

Investigated suspicious transaction patterns using different SQL-based indicators.

**1. Transaction Amount Analysis**

- Identified transactions exceeding the overall average transaction amount.
- Compared transaction amounts with the respective card's average transaction amount.
- Identified cards with average transaction amounts above the overall average.
- Investigated transactions significantly higher than normal card spending.
- Identified transactions falling within the top 1% of transaction amounts using `PERCENT_RANK()`.

**2. Transaction Frequency Analysis**

- Identified multiple transactions within 1, 5 and 10 minutes.
- Investigated transactions occurring at the same merchant within 5 minutes.
- Identified transactions at different merchants within 2, 5 and 10 minutes.
- Investigated sudden increases in transaction amounts within short periods.
- Checked for duplicate transactions involving the same card, merchant, amount and timestamp.

**3. Late-Night Transaction Analysis**

- Identified transactions occurring between 12 AM and 5 AM.
- Identified cards with the highest number of late-night transactions.
- Analyzed cardholders with higher late-night spending.

**4. Rule-Based Fraud Risk Scoring**

Developed a transaction-level fraud scoring approach using three indicators:

| Indicator | Condition | Score |
|---|---|---:|
| High Amount | Transaction amount greater than the respective card's average transaction amount | 1 |
| Rapid Transaction | Another transaction occurring within 10 minutes of the previous transaction on the same card | 1 |
| Late-Night Activity | Transaction occurring between 12 AM and 5 AM | 1 |

Each satisfied condition contributes 1 point. The three indicator scores are added to calculate a transaction-level fraud score ranging from 0 to 3.

Further analysis included:

- Identifying the 20 transactions with the highest fraud scores.
- Identifying the 10 credit cards with the highest overall fraud risk.
- Finding cardholders with the highest number of transactions flagged by the defined indicators.
- Identifying merchant categories frequently appearing in suspicious transaction patterns.
- Comparing the contribution of individual fraud indicators.
- Identifying cards triggering multiple fraud indicators simultaneously.

**Note:** Different fraud investigation queries use different time intervals, including 10 minutes, 1 hour and 4 hours, depending on the analysis. These conditions are not treated as one universal fraud rule.

### E. Statistical Outlier Detection

Used the **Standard Deviation Method (3-Sigma Rule)** to identify unusually high and low transaction amounts.

- Calculated the overall mean and standard deviation of transaction amounts.
- Identified transactions outside the range of mean ± 3 standard deviations.
- Counted statistical outlier transactions for each credit card.
- Identified cards with the highest number of statistical outliers.

## 6. Key Findings & Business Insights

### A. Overall Transaction Insights

| Metric | Finding |
|---|---:|
| Total Transactions | 3,500 |
| Total Transaction Amount | $142,761.95 |
| Average Transaction Amount | $40.79 |
| Minimum Transaction Amount | $0.51 |
| Maximum Transaction Amount | $2,249 |

### B. Fraud Detection Findings

**1. Cardholder Analysis**

- Kevin Spencer recorded approximately 141 transactions flagged by the defined suspicious activity indicators.
- Megan Price followed with approximately 120 flagged transactions.

**2. Highest-Risk Transaction**

- Transaction ID `1773` received a fraud score of **3**.
- It satisfied all three indicators: high transaction amount, rapid transaction and late-night activity.
- The associated card is shown in masked form: `XXXXXXXX8916`.

**3. Fraud Indicator Analysis**

Out of 3,500 transactions:

- 1,661 transactions exceeded their respective card's average transaction amount.
- 5 transactions met the 10-minute rapid transaction condition.
- 865 transactions occurred during late-night hours (12 AM–5 AM).

These are individual indicator counts and should not be added together as unique suspicious transactions because the indicators can overlap.

**4. Merchant Category Analysis**

- Pub recorded approximately 104 transactions appearing in the analyzed suspicious transaction pattern.
- Food Truck followed with approximately 87 transactions.
- Under a stricter combination of conditions, Pub recorded 9 occurrences and Bar recorded 8.

**5. Statistical Outlier Analysis**

- Identified 77 statistical outlier transactions using the three-standard-deviation method.
- Card `XXXXXXXX7465` recorded the highest number of statistical outlier transactions, with 11 occurrences.

**6. Highest Transaction Amount**

- The highest transaction amount was $2,249.
- It was recorded on December 13, 2018, at 3:51 PM.
- The associated card is shown in masked form: `XXXXXXXX0240`.

**7. High-Value Transaction Analysis**

- Card `XXXXXXXX0852` recorded the highest percentage of high-value transactions relative to its own average transaction amount.

## 7. SQL Concepts & Techniques Used

- SELECT, WHERE and ORDER BY
- GROUP BY and HAVING
- Aggregate Functions: COUNT, SUM, AVG, MIN and MAX
- Joins: INNER JOIN
- Subqueries and Nested Queries
- Common Table Expressions (CTEs)
- Window Functions: LAG(), LEAD(), AVG() OVER(), PERCENT_RANK()
- Conditional Logic: CASE WHEN
- FILTER clause
- Date and Time Functions: EXTRACT()
- Statistical Functions: STDDEV()
- Type Casting and Numeric Rounding
- Interval-based timestamp comparisons
- UPDATE and COPY commands

## 8. Challenges & Learnings

During this project, I worked on practical SQL challenges such as:

- Understanding relationships between multiple relational tables.
- Joining multiple tables to retrieve meaningful business information.
- Writing complex queries using subqueries and CTEs.
- Applying window functions to analyze transaction sequences.
- Identifying rapid transactions using timestamp differences.
- Developing rule-based fraud indicators and transaction-level risk scores.
- Handling numeric type conversion while rounding FLOAT values in PostgreSQL.
- Applying statistical methods to identify unusual transaction patterns.
- Comparing card-level transaction behaviour with overall transaction patterns.

## 9. Project Outcome

This project provided practical experience in relational database design, PostgreSQL querying, business data analysis, transaction pattern investigation and statistical outlier detection.

It demonstrated how SQL can be used to transform raw transaction records into meaningful business insights and how rule-based indicators can help prioritize potentially suspicious transactions for further investigation.

**Disclaimer:** Fraud scores and statistical outliers represent potential risk indicators, not confirmed fraudulent activities. Further investigation is required before classifying any transaction as fraud.
