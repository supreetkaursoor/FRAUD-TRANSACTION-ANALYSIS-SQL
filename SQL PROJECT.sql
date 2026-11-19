create table card_holder(
id serial primary key,
name varchar (50) not null
);

create table credit_card(
card varchar (50) not null,
id_cardholder integer not null,
foreign key (id_cardholder) references card_holder (id)
);

create table merchant_category(
id serial primary key,
name varchar (50) not null
);

create table merchant(
id serial primary key,
name varchar (50) not null,
id_merchant_category integer,
foreign key (id_merchant_category) references merchant_category(id)
);

create table transaction(
id serial primary key,
date timestamp not null,
amount float not null,
card varchar (50) not null,
id_merchant integer not null,
foreign key (id_merchant) references merchant(id)
);


copy card_holder
from 'D:\supreet\card_holder.csv'
Delimiter','
csv header;

copy credit_card
from 'D:\supreet\credit_card.csv'
Delimiter ','
csv header;

copy merchant_category
from 'D:\supreet\merchant_category.csv'
Delimiter','
csv header;

copy merchant
from 'D:\supreet\merchant.csv'
Delimiter','
csv header;

copy transaction
from'D:\supreet\transaction.csv'
Delimiter ','
csv header;

select * from  card_holder
select * from credit_card
select * from merchant_category
select * from merchant
select * from transaction

UPDATE credit_card
SET card = CASE card
    WHEN '501809000000' THEN '501809222273'
    WHEN '501880000000' THEN '501879657465'
    WHEN '4319650000000' THEN '4319653513507'
    WHEN '4498000000000' THEN '4498002758300'
    WHEN '4741040000000' THEN '4741042733274'
    WHEN '30182000000000' THEN '30181963913340'
    WHEN '180099000000000' THEN '180098539019105'
    WHEN '213194000000000' THEN '213193946980303'
    WHEN '344120000000000' THEN '344119623920892'
    WHEN '372415000000000' THEN '372414832802279'
    WHEN '376028000000000' THEN '376027549341849'
    WHEN '3516950000000000' THEN '3516952396080240'
    WHEN '3517110000000000' THEN '3517111172421930'
    WHEN '3535650000000000' THEN '3535651398328200'
    WHEN '3561070000000000' THEN '3561072557118690'
    WHEN '3561950000000000' THEN '3561954487988600'
    WHEN '4027910000000000' THEN '4027907156459090'
    WHEN '4188160000000000' THEN '4188164051171480'
    WHEN '4263690000000000' THEN '4263694062533010'
    WHEN '4268490000000000' THEN '4268491956169250'
    WHEN '4506410000000000' THEN '4506405265172170'
    WHEN '5135840000000000' THEN '5135837688671490'
    WHEN '5175950000000000' THEN '5175947111814770'
    WHEN '5297190000000000' THEN '5297187379298980'
    WHEN '5500710000000000' THEN '5500708021555300'
    WHEN '6500240000000000' THEN '6500236164848270'
    WHEN '4159840000000000000' THEN '4159836738768850000'
    WHEN '4586960000000000000' THEN '4586962917519650000'
    WHEN '4866760000000000000' THEN '4866761290278190000'
    WHEN '4962920000000000000' THEN '4962915017023700000'
END
WHERE card IN (
    '501809000000',
    '501880000000',
    '4319650000000',
    '4498000000000',
    '4741040000000',
    '30182000000000',
    '180099000000000',
    '213194000000000',
    '344120000000000',
    '372415000000000',
    '376028000000000',
    '3516950000000000',
    '3517110000000000',
    '3535650000000000',
    '3561070000000000',
    '3561950000000000',
    '4027910000000000',
    '4188160000000000',
    '4263690000000000',
    '4268490000000000',
    '4506410000000000',
    '5135840000000000',
    '5175950000000000',
    '5297190000000000',
    '5500710000000000',
    '6500240000000000',
    '4159840000000000000',
    '4586960000000000000',
    '4866760000000000',
    '4962920000000000000'
);

SQL Project — Insight & Fraud Detection Questions

A. Basic Business Insights

What is the total number of transactions?
SELECT COUNT(*) AS NO_OF_TRANSACTION FROM TRANSACTION

What is the total transaction amount?
SELECT SUM(AMOUNT) AS TOTAL_TRANSACTION_AMOUNT FROM TRANSACTION

What is the average transaction amount?
SELECT ROUND(AVG(AMOUNT::NUMERIC),2)FROM TRANSACTION;

What is the minimum and maximum transaction amount?
SELECT MIN(AMOUNT) AS MIN_AMOUNT, MAX(AMOUNT) AS MAX_AMOUNT FROM TRANSACTION

How many unique cardholders are there?
SELECT COUNT(DISTINCT (ID)) AS NO_OF_CARDHOLDER FROM CARD_HOLDER

How many unique credit cards are there?
SELECT COUNT(DISTINCT(CARD)) AS NO_OF_CREDIT_CARD FROM CREDIT_CARD

How many unique merchants are there?
SELECT COUNT(DISTINCT(ID)) AS NO_OF_MERCHANT FROM MERCHANT

How many transactions occur in each merchant category?
SELECT COUNT(T.ID) AS TRANSACTIONS_PER_MERCHANT,
 MC.NAME FROM TRANSACTION AS T
 INNER JOIN
MERCHANT AS M 
ON T.ID_MERCHANT=M.ID
INNER JOIN MERCHANT_CATEGORY  AS MC  
ON MC.ID=M.id_merchant_category 
  GROUP BY 2 ORDER BY 1 DESC
  
What is the total transaction amount by merchant category?
SELECT ROUND(SUM(T.AMOUNT::NUMERIC),2) AS TOTAL_TRANSACTION,
 MC.NAME AS MERCHANT_CATEGORY
FROM TRANSACTION AS T
 INNER JOIN
MERCHANT AS M ON  T.ID_MERCHANT=M.ID
 INNER JOIN
MERCHANT_CATEGORY AS MC ON  MC.ID=M.id_merchant_category
GROUP BY 2 ORDER BY 1 DESC

What is the average transaction amount by merchant category?
SELECT ROUND(AVG(T.AMOUNT::NUMERIC),2) AS AVG_TRANSACTION, 
MC.NAME AS MERCHANT_CATEGORY
FROM TRANSACTION AS T 
INNER JOIN MERCHANT AS M 
ON  T.ID_MERCHANT=M.ID 
INNER JOIN
MERCHANT_CATEGORY AS MC
 ON  MC.ID=M.id_merchant_category
GROUP BY 2 ORDER BY 1 DESC

Which merchant has the highest number of transactions?
SELECT M.NAME, COUNT(T.ID) AS NO_OF_TRANSACTION FROM MERCHANT AS M INNER JOIN TRANSACTION AS T
ON M.ID=T.ID_MERCHANT GROUP BY 1 ORDER BY 2 DESC LIMIT 1

Which merchant generates the highest total transaction amount?
SELECT M.NAME, 
ROUND(SUM(T.AMOUNT::NUMERIC),2) AS TRANSACTION_AMOUNT 
FROM MERCHANT AS M 
INNER JOIN TRANSACTION AS T 
ON M.ID=T.ID_MERCHANT 
GROUP BY 1 ORDER BY 2 desc LIMIT 1

Which cardholder has made the highest number of transactions?
select ch.name, 
count(t.*) as no_of_transaction
 from transaction as t 
inner join credit_card as cc 
on cc.card=t.card
inner join card_holder as ch 
on ch.id=cc.id_cardholder 
group by ch.name order by 2 desc limit 1

Which cardholder has spent the highest total amount?
select ch.name, 
sum(t.amount) as total_amount
 from transaction as t
 inner join credit_card as cc 
on t.card=cc.card
inner join card_holder as ch 
on ch.id=cc.id_cardholder 
group by 1 order by 2 desc limit 1

What is the average spending per cardholder?
select ch.name, 
round(avg(t.amount::numeric),2) as avg_spending  
from transaction as t
 inner join credit_card as cc 
on t.card=cc.card
inner join card_holder as ch 
on ch.id=cc.id_cardholder 
group by 1 order by 2 desc 

What is the total spending by each credit card?
select cc.card ,
 round(sum(t.amount::numeric),2) as total_spend 
from transaction as t 
inner join credit_card as cc 
on t.card=cc.card
group by 1 order by 2 desc

Which credit card has the highest total spending?
select cc.card ,
 round(sum(t.amount::numeric),2) as total_spend 
from transaction as t 
inner join credit_card as cc
 on t.card=cc.card
group by 1 order by 2 desc limit 1

Which credit card has the highest average transaction amount?
select cc.card , 
round(avg(t.amount::numeric),2) as avg_transaction_amount 
from transaction as t 
inner join credit_card as cc 
on t.card=cc.card 
group by 1 order by 2 desc limit 1

What are the top 10 merchants by total transaction amount?
SELECT M.NAME, 
ROUND(SUM(T.AMOUNT::NUMERIC),2) AS TOTAL_TRANSACTION_AMOUNT 
FROM MERCHANT AS M 
INNER JOIN TRANSACTION AS T
ON M.ID=T.ID_MERCHANT
 GROUP BY 1 ORDER BY 2 DESC LIMIT 10

What are the top 10 cardholders by total spending?
select ch.name, 
round(sum(t.amount::numeric),2) as total_spend
from transaction as t 
inner join credit_card as cc 
on cc.card=t.card 
inner join card_holder as ch
 on ch.id=cc.id_cardholder
 group by 1 order by 2 desc limit 10

B. Time-Based Analysis

What is the total transaction amount by date?
SELECT DATE::DATE AS TRANSACTION_DATE, 
SUM(AMOUNT) AS TRANSACTION_AMOUNT 
FROM TRANSACTION 
GROUP BY 1 ORDER BY 1  

What is the number of transactions by date?
SELECT DATE::DATE AS TRANSACTION_DATE, 
COUNT(ID) AS TRANSACTION_NO FROM TRANSACTION 
GROUP BY 1 ORDER BY 2 DESC

What is the average transaction amount by date?
SELECT DATE::DATE AS TRANSACTION_DATE, 
ROUND(AVG(AMOUNT::NUMERIC),2) AS AVG_TRANSACTION_AMOUNT
 FROM TRANSACTION
GROUP BY 1 ORDER BY 2 DESC

Which date had the highest total transaction amount?
SELECT DATE::DATE AS TRANSACTION_DATE,
 SUM(AMOUNT) AS TRANSACTION_AMOUNT 
FROM TRANSACTION
GROUP BY 1 ORDER BY 2 DESC LIMIT 1

Which date had the highest number of transactions?
SELECT DATE::DATE AS TRANSACTION_DATE,
 COUNT(ID) AS NO_OF_TRANSACTION 
FROM TRANSACTION
GROUP BY 1 ORDER BY 2 DESC LIMIT 1

What are the busiest hours for transactions?
SELECT EXTRACT('HOUR' FROM DATE) AS HOUR,
COUNT(ID) AS NO_OF_TRANSACTION 
FROM TRANSACTION 
GROUP BY 1 ORDER BY 2 DESC

What is the total transaction amount by hour of the day?
SELECT EXTRACT('HOUR' FROM DATE) AS HOUR, 
ROUND(SUM(AMOUNT::NUMERIC),2) AS TRANSACTION_AMOUNT 
FROM TRANSACTION 
GROUP BY 1 ORDER BY 1 

Which hour has the highest average transaction amount?
SELECT EXTRACT('HOUR' FROM DATE) AS HOUR , 
ROUND(AVG(AMOUNT::NUMERIC),2) AS AVG_AMOUNT 
FROM TRANSACTION 
GROUP BY 1 ORDER BY 2 DESC LIMIT 1

How does transaction activity vary between daytime and nighttime?
SELECT 
CASE WHEN EXTRACT('HOUR' FROM DATE)>=5 
AND  EXTRACT('HOUR' FROM DATE)<=18 
THEN 'DAY_TIME'
ELSE 'NIGHT_TIME' 
END AS TIME_PERIOD, 
COUNT(ID) FROM TRANSACTION
 GROUP BY 1 
 
Which transactions occurred during unusual late-night hours?
SELECT * FROM TRANSACTION 
WHERE EXTRACT('HOUR' FROM DATE)>=0 AND EXTRACT('HOUR' FROM DATE)<=5 
ORDER BY 
EXTRACT('HOUR' FROM DATE) ASC

C. Cardholder & Merchant Analysis

Which cardholders have transactions across the highest number of merchants?
Select ch.name as card_holder_name, 
count(distinct m.name) as no_of_merchant 
from card_holder as ch
 inner join credit_card as cc
 on ch.id=cc.id_cardholder
 inner join transaction as t 
on t.card=cc.card
inner join merchant as m 
on t.id_merchant=m.id
group by 1 order by 2 desc  limit 1

Which cardholders have transactions across the highest number of merchant categories?
select ch.name as card_holder_name, 
count(distinct mc.name) as no_of_merchant_categories
 from card_holder as ch
  inner join credit_card as cc 
on ch.id=cc.id_cardholder
inner join transaction as t 
on cc.card=t.card 
inner join merchant as m
 on t.id_merchant=m.id 
inner join merchant_category as mc 
on m.id_merchant_category=mc.id 
group by 1 order by 2 desc limit 1

Which merchants have the highest average transaction amount?
SELECT M.NAME as merchant_name, 
ROUND(AVG(T.AMOUNT::NUMERIC),2) as avg_transaction_amount 
FROM MERCHANT AS M
 INNER JOIN TRANSACTION AS T 
ON M.ID=T.ID_MERCHANT
 GROUP BY 1
ORDER BY 2 DESC LIMIT 1


Which merchant categories have the highest average spending per cardholder?
SELECT
    mc.name AS merchant_category,
    SUM(t.amount) AS total_spending,
    COUNT(DISTINCT cc.id_cardholder) AS total_cardholders,
    ROUND(
        (SUM(t.amount) / COUNT(DISTINCT cc.id_cardholder))::numeric,
        2
    ) AS avg_spending_per_cardholder

FROM transaction t

JOIN merchant m
    ON t.id_merchant = m.id

JOIN merchant_category mc
    ON m.id_merchant_category = mc.id

JOIN credit_card cc
    ON t.card = cc.card

GROUP BY mc.name

ORDER BY avg_spending_per_cardholder DESC;

Which cardholders have unusually high average transaction amounts?
select ch.name as card_holder_name,
 round(avg(t.amount::numeric),2) as avg_amount 
from card_holder as ch 
inner join credit_card as cc 
on cc.id_cardholder=ch.id
 inner join transaction as t 
on t.card=cc.card 
group by 1 
having avg(t.amount)>(select avg(amount) from transaction)

Which cardholders have the highest number of small-value transactions?
select ch.name, 
count(*) as no_of_transaction,
 t.amount from card_holder as ch 
inner join credit_card as cc
 on cc.id_cardholder =ch.id
inner join transaction as t 
on t.card=cc.card 
where t.amount < 5 
group by 1 ,3 order by 2 desc limit 5

Which cards are used at the highest number of different merchants?
select t.card,  
count(distinct m.name) from transaction as t 
inner join merchant as m 
on t.id_merchant=m.id
group by 1 order by 2 desc limit 1

Which merchants are used by the highest number of different cardholders?
select m.name as merchant_name ,
count(distinct ch.id) as no_of_card_holder
from card_holder as ch
 inner join credit_card as cc on 
ch.id=cc.id_cardholder 
inner join transaction as t 
on cc.card=t.card 
inner join merchant as m
 on t.id_merchant=m.id
group by 1  order by 2 desc 

D. Fraud Detection

Which transactions have unusually high amounts compared with the overall average?
select * from 
(select *, avg(amount) over ()  as avg_transaction_amount from transaction)
 where amount>avg_transaction_amount

Which transactions have amounts significantly higher than the average transaction amount for their card?
select * from (
SELECT *, 
 AVG(AMOUNT) over (partition by card) as card_avg_transaction 
from transaction ) as x
where amount>card_avg_transaction

Which cardholders have unusually high-value transactions?
select card_holder_name, 
transaction_amount, 
overall_avg_transaction 
from(select ch.name as card_holder_name,
 t.amount as transaction_amount, 
avg(t.amount) over() as overall_avg_transaction
from card_holder as ch 
inner join credit_card as cc 
on ch.id=cc.id_cardholder
 inner join transaction as t 
on cc.card=t.card) as x
where transaction_amount>overall_avg_transaction  order by 2

Which cards have unusually high average transaction amounts?
select card, card_avg_amount, overall_avg from (
select card, round(avg(amount::numeric),2) as card_avg_amount ,
(select round(avg(amount::numeric),2) from transaction) as overall_avg
from transaction group by 1)
where card_avg_amount>overall_avg

Which cards have unusually high transaction frequency within a short period?
select card, date , previous_date , count(*) over(partition by card ) as transaction_frequency from
(select card as card,  date as date , 
lag(date) over(partition by card order by date) as previous_date
from transaction)   where date-previous_date<= interval '10 minutes' order by 4 desc

Are there multiple transactions from the same card within a few seconds or minutes?
select card, 
 date, previous_transaction_date from (
select card,  date, lag(date) over (partition by card order by date) as
previous_transaction_date from transaction  ) as x
 where date-previous_transaction_date<= interval '5 minutes'

Which cards have multiple transactions at the same merchant within a very short time?
SELECT card, merchant_name,
 previous_merchant_name, date, 
previous_transaction_date 
FROM ( SELECT t.card AS card, m.name AS merchant_name,
 LAG(m.name) OVER ( PARTITION BY t.card ORDER BY t.date ) AS previous_merchant_name, 
date, LAG(date) OVER ( PARTITION BY t.card ORDER BY t.date ) AS previous_transaction_date FROM transaction AS t
 INNER JOIN merchant AS m 
ON t.id_merchant = m.id  ) AS x 
WHERE date - previous_transaction_date <= INTERVAL '5 minutes' AND 
merchant_name = previous_merchant_name;

Are there duplicate transactions with the same card, merchant, amount, and timestamp?
select count(id), card, id_merchant, date, amount  from transaction 
group by 2,3,4,5
having count(id)>1

Which cardholders have multiple transactions at different merchants within a very short time?
SELECT 
    card_holder_name,
    transaction_frequency,
    merchant_name,
    previous_merchant_name,
    current_date,
    previous_transaction_date
FROM (
    SELECT 
        ch.name AS card_holder_name,
        COUNT(t.id) OVER (
            PARTITION BY ch.name
        ) AS transaction_frequency,
        
        m.name AS merchant_name,
        
        LAG(m.name) OVER (
            PARTITION BY ch.name 
            ORDER BY t.date
        ) AS previous_merchant_name,
        
        t.date AS current_date,
        
        LAG(t.date) OVER (
            PARTITION BY ch.name 
            ORDER BY t.date
        ) AS previous_transaction_date
        
    FROM card_holder AS ch
    INNER JOIN credit_card AS cc 
        ON ch.id = cc.id_cardholder
    INNER JOIN transaction AS t 
        ON cc.card = t.card
    INNER JOIN merchant AS m 
        ON t.id_merchant = m.id
) AS x

WHERE current_date - previous_transaction_date <= INTERVAL '2 minutes'
  AND merchant_name <> previous_merchant_name
  AND transaction_frequency > 1;

Are there transactions occurring at unusual late-night hours?
SELECT * FROM TRANSACTION 
WHERE EXTRACT('HOUR' FROM DATE)>=0 AND
 EXTRACT('HOUR' FROM DATE)<=5 
ORDER BY EXTRACT('HOUR' FROM DATE) ASC

Which cards have the highest number of late-night transactions?
select card, 
count(*) as transaction_frequency 
from transaction 
where extract('hour' from date)>=0 and extract('hour' from date)<=5 
group by card order by 2 desc

Which cardholders have unusually high spending during late-night hours?
WITH CARD_HOLDER_INFO AS(
SELECT CH.NAME AS CARD_HOLDER,
 SUM(T.AMOUNT) AS TOTAL_SPEND 
FROM CARD_HOLDER AS CH
 INNER JOIN CREDIT_CARD AS CC 
ON CH.ID=CC.ID_CARDHOLDER
INNER JOIN TRANSACTION AS T
 ON CC.CARD=T.CARD 
WHERE extract('hour' from date)>=0 and extract('hour' from date) <=5 GROUP BY 1 ) 
SELECT CARD_HOLDER, 
TOTAL_SPEND 
FROM CARD_HOLDER_INFO 
WHERE TOTAL_SPEND>(SELECT AVG(TOTAL_SPEND)FROM CARD_HOLDER_INFO) 

Are there cards showing sudden spikes in transaction amounts?
select card, 
amount, 
next_transaction from (
select card, 
amount, 
date , 
lead(amount) over (partition by card order by date) as next_transaction, 
lead(date) over (partition by card order by date) as next_transaction_date
from transaction ) 
where 
next_transaction>amount*2 and next_transaction_date-date<= interval '5 minutes'

Which cards have transactions far above their normal spending pattern?
SELECT CARD, 
AMOUNT, 
CARD_AVG FROM (
SELECT CARD,
 AMOUNT, 
AVG(AMOUNT) OVER(PARTITION BY CARD ) AS CARD_AVG 
FROM TRANSACTION) AS X
WHERE AMOUNT>CARD_AVG*10

Which cardholders have transactions far above their normal spending pattern?
select card_holder_name,
 transaction_amount,
 avg_transaction from 
(select ch.name as card_holder_name,
 t.amount as transaction_amount,
 avg(t.amount) over (partition by ch.name) as avg_transaction
from card_holder as ch
 inner join credit_card as cc
 on ch.id=cc.id_cardholder
 inner join transaction as t
 on cc.card=t.card ) as x
where transaction_amount>avg_transaction*10

Are there merchants associated with unusually large transactions?
select merchant_name, 
amount, 
avg_transaction from (
select m.name as merchant_name, 
t.amount as amount, 
avg(t.amount) over (partition by m.name) as avg_transaction
 from merchant as m
 inner join transaction as t
on m.id=t.id_merchant) as x 
where amount>avg_transaction*10

Which merchant categories have the highest concentration of suspicious transactions?
select merchant_category, 
total_transaction,
 suspicious_transactions, 
round(suspicious_transactions::numeric/total_transaction::numeric
*100,2) as concentration
from (
select count(transaction_id) as total_transaction, 
merchant_category, 
COUNT(*) FILTER (WHERE fraud_score>=2 ) AS suspicious_transactions from (
select transaction_id, 
merchant_category,
 high_amount+high_frequency+late_hour  as fraud_score from (
select transaction_id,
 merchant_category,
case when amount>card_avg then 1 else 0 end as high_amount,
case when date-previous_transaction<=interval '1 hour' then 1 else 0 end as high_frequency,
case when hour>=0 and hour<=5 then 1 else 0 end as late_hour from (
select t.id as transaction_id,
 t.card as card, 
t.amount as amount,
 t.date as date, 
mc.name as merchant_category, 
avg(t.amount) over (partition by t.card) as card_avg,
lag(t.date) over (partition by t.card order by t.date) as previous_transaction, 
extract('hour' from date) as hour
from merchant_category as mc
 inner join merchant as m
 on mc.id=m.id_merchant_category
 inner join transaction as t 
on m.id=t.id_merchant) as x ) as y ) as z 
  group by 2) as c order by 4 desc
  
Which transactions fall into the top 1% of transaction amounts?
select id,
 date, 
amount, 
card, 
rank from (
select id,
 date, 
amount, 
card , 
percent_rank() over (order by amount) as rank 
from transaction) as x 
where rank>=0.99 order by amount desc

Which cards have the highest percentage of high-value transactions?
select card,
 round(high_value_transaction::numeric/total_transactions::numeric*100,2) as percentage
 from (select card,
 count(*) as total_transactions, 
count(*) filter (where amount>card_avg ) as high_value_transaction 
from (select card,
 amount, 
card_avg from (
select card, 
amount,
 avg(amount) over (partition by card) as card_avg 
from transaction) as x  ) 
as y group by 1) as z
order by 2 desc

Which cards show both high transaction frequency and high transaction amounts?
with card_info as (
select card, 
count(*) as transaction_frequency ,
 avg(amount) as card_avg_amount 
 from transaction group by card )
select card, 
transaction_frequency, 
card_avg_amount from card_info 
where transaction_frequency>
(select avg(transaction_frequency)
from card_info) and card_avg_amount>
(select avg(amount) from transaction)

Which cardholders show unusual changes in their spending behavior?
SELECT cardholder_name,
 transaction_amount,
previous_transaction_amount
FROM  (SELECT ch.name AS cardholder_name,
t.amount AS transaction_amount,
LAG(t.amount) OVER (
PARTITION BY ch.name
ORDER BY t.date) AS previous_transaction_amount
FROM card_holder AS ch
INNER JOIN credit_card AS cc 
ON ch.id = cc.id_cardholder
INNER JOIN transaction AS t
ON cc.card = t.card
) AS x
WHERE transaction_amount > previous_transaction_amount * 2
ORDER BY transaction_amount DESC;

Which transactions should be flagged as potentially fraudulent based on multiple fraud indicators?
select * from(
select *, 
avg(amount) over(partition by card) as card_avg,
lag(date) over (partition by card order by date) as previous_transaction
from transaction 
where extract('hour' from date)>=0 
and extract('hour' from date)<=5) as x
 where amount>card_avg 
and date-Previous_transaction<= interval '2 hour'

E. Advanced Fraud Investigation

Which cards have multiple transactions within 1 minute?
select card, 
date, 
previous_transaction from(
select card,  
date,
 lag(date) over(partition by card order by date) as previous_transaction
from transaction ) as x 
where  date-previous_transaction<= interval '1 minute'

Which cards have multiple transactions within 5 minutes?
select card, 
date, 
previous_transaction from(
select card,  
date,
 lag(date) over(partition by card order by date) as previous_transaction
from transaction ) as x 
where  date-previous_transaction<= interval '5 minute'

Which cards have transactions at different merchants within 5 minutes?
select card,
current_merchant, 
previous_merchant , 
current_date, 
previous_date,
 count(*) over (partition by card) as transaction_frequency from 
(select t.card as card , m.name as current_merchant , 
lag(m.name) over (partition by card order by date) as previous_merchant,
t.date as current_date, 
lag(t.date) over (partition by t.card order by date) as previous_date 
from transaction as t
inner join merchant as m 
on t.id_merchant=m.id) as x 
where current_date-previous_date<= interval ' 5 minutes' and
current_merchant<>previous_merchant

Which cards have transactions at different merchants within 10 minutes?
select card,
current_merchant, 
previous_merchant , 
current_date, 
previous_date,
 count(*) over (partition by card) as transaction_frequency from 
(select t.card as card , m.name as current_merchant , 
lag(m.name) over (partition by card order by date) as previous_merchant,
t.date as current_date, 
lag(t.date) over (partition by t.card order by date) as previous_date 
from transaction as t
inner join merchant as m 
on t.id_merchant=m.id) as x 
where current_date-previous_date<= interval ' 10 minutes' and
current_merchant<>previous_merchant


Which cards have a large transaction immediately followed by another transaction?
select card, 
amount, 
card_avg, 
date,
 next_transaction_date, 
next_transaction from (
select card, 
amount, 
avg(amount) over (partition by card ) as card_avg, 
date, 
lead(date) over(partition by card order by date) as next_transaction_date, 
lead(amount) over (partition by card order by date) as next_transaction
from transaction ) as x 
where amount>card_avg 
and next_transaction_date-date <= interval ' 2 minutes'

Which cardholders have unusually frequent transactions compared with other cardholders?
with card_holder_info 
as ( select ch.name as card_holder_name,
 count(T.*) as transaction_frequency
 from card_holder as ch 
inner join credit_card as cc 
on ch.id=cc.id_cardholder 
inner join transaction as t 
on cc.card=t.card group by 1)
select card_holder_name,
 transaction_frequency from card_holder_info
 where transaction_frequency>
(select avg(transaction_frequency) 
from card_holder_info)

Which cards have the highest transaction amount immediately after a previous transaction?
select card, amount, date, previous_transaction, previous_transaction_date from (
select card,
 amount, 
date, 
lag(amount) over(partition by card order by date) as previous_transaction ,
 lag(date) over (partition by card order by date) as previous_transaction_date 
from transaction) as x
where  date-previous_transaction_date<= interval '5 minutes' 
order by 2 desc

Which transactions are statistical outliers using the average and standard deviation?
select * from transaction 
where amount> (select avg(amount) +3 * stddev (amount) from transaction) or
amount<(select avg(amount) -3 * stddev(amount) from transaction)
order by amount desc

Which cards have the highest number of statistical outlier transactions?
SELECT card,
 COUNT(*) AS outlier_transactions
FROM transaction
WHERE amount > (  SELECT AVG(amount) + 3 * STDDEV(amount)
  FROM transaction)
OR amount < ( SELECT AVG(amount) - 3 * STDDEV(amount)
FROM transaction)
GROUP BY card
ORDER BY outlier_transactions DESC

Which cardholders have the highest number of suspicious transactions?
select card_holder, 
count(*) as number_of_suspicious_transaction from (
select card_holder,
 high_amount, 
rapid_transaction, 
high_amount+rapid_transaction+late_night_hour as fraud_score from 
(select card_holder, 
case when amount>avg_card_holder then 1 else 0 end as high_amount,
case when current_date-previous_transaction<= interval '4 hours' then 1 else 0 end as rapid_transaction,
case when hour>=0 and hour<=5 then 1 else 0 end as late_night_hour
from (
select ch.name as card_holder,
 t.amount as amount,
 t.card as card,
 t.date as current_date,
lag(t.date) 
over (partition by ch.id order by t.date) as previous_transaction, 
avg(t.amount) over(partition by T.CARD) as avg_card_holder,
extract('hour' from date) as hour
from transaction as t
 inner join credit_card as cc 
on t.card=cc.card
 inner join card_holder as ch 
on ch.id=cc.id_cardholder ) as x)
 as y)
 as z where fraud_score>=1 group by 1 order by 2 desc
 
Which merchant locations/categories appear most frequently among suspicious transactions?
select name, 
count(*) as times_appeared from (
select name, 
amount, 
date, 
card, 
card_avg,
previous_transaction, 
hour from (
select mc.name as name,
 t.amount as amount,
 t.date as date, 
t.card as card,
 avg(t.amount) over (partition by t.card) as card_avg, 
lag(t.date) over (partition by mc.name order by t.date) as previous_transaction, 
extract('hour' from t.date) as hour
from merchant_category as mc 
inner join merchant as m 
on mc.id=m.id_merchant_category
inner join transaction as t 
on m.id=t.id_merchant) as x 
where date-previous_transaction<= interval '1 hour' and
hour>=0 and hour<=5
 and amount>card_avg)
 as y group by 1 order by 2 desc
 
Can we create a fraud score for each transaction based on amount, transaction time, frequency, and unusual card behavior?
select card,
high_amount, 
transaction_frequency,
 late_hour, 
fraud_score from (
select card, 
amount, 
date, 
card_avg,
hour, 
previous_transaction, 
high_amount,
 transaction_frequency,
 late_hour ,
high_amount+transaction_frequency+late_hour as fraud_score from (
select card, 
amount, 
date,
 card_avg,hour,
 previous_transaction ,
case when amount>card_avg then 1 else 0 end as high_amount,
case when date-previous_transaction<= interval '10 minutes' then 1 else 0 end as transaction_frequency,
case when hour>=0 and hour<=5 then 1 else 0 end as late_hour from(
select card, 
amount,
 date, 
avg(amount) over (partition by card) as card_avg, 
extract('hour' from date) as hour ,
 lag(date) over(partition by card order by date) as previous_transaction
 from transaction) as x)
 as y) as z  order by fraud_score desc
 
Which 20 transactions have the highest fraud score?
select id,
 card, 
fraud_score from (
select id,
 card, 
high_amount, 
transaction_frequency,
 late_hour , 
high_amount+transaction_frequency+late_hour as fraud_score from (
select id, 
card,
 amount,
 date ,
avg_transaction, 
hour,
previous_transaction , 
case when amount>avg_transaction then 1 else 0 end as high_amount,
case when date-previous_transaction<=interval '10 minutes' then 1 else 0 end as transaction_frequency,
case when hour>=0 and hour<=5 then 1 else 0 end as late_hour
from (
select id, 
card, 
amount, 
date, 
avg(amount) over (partition by card) as avg_transaction , 
extract('hour' from date) as hour,
 lag(date) over (partition by card order by date) as previous_transaction 
from transaction) as x) as y) as z
 order by 3 desc limit 20
 
Which 10 credit cards have the highest overall fraud risk?
SELECT
    card,
    SUM(fraud_score) AS total_fraud_score,
    COUNT(*) AS suspicious_transactions
FROM
(
    SELECT
        card,
        high_amount + rapid_transaction + late_night_hour AS fraud_score
    FROM
    (
        SELECT
            card,

            CASE
                WHEN amount > avg_card_amount THEN 1
                ELSE 0
            END AS high_amount,

            CASE
                WHEN current_date - previous_transaction <= INTERVAL '4 hours'
                THEN 1
                ELSE 0
            END AS rapid_transaction,

            CASE
                WHEN hour BETWEEN 0 AND 5 THEN 1
                ELSE 0
            END AS late_night_hour

        FROM
        (
            SELECT
                t.card,
                t.amount,
                t.date AS current_date,

                LAG(t.date) OVER (
                    PARTITION BY t.card
                    ORDER BY t.date
                ) AS previous_transaction,

                AVG(t.amount) OVER (
                    PARTITION BY t.card
                ) AS avg_card_amount,

                EXTRACT(HOUR FROM t.date) AS hour

            FROM transaction t
        ) AS x
    ) AS y
) AS z

WHERE fraud_score >= 1

GROUP BY card

ORDER BY total_fraud_score DESC

LIMIT 10;

Which cardholders have the highest overall fraud risk?
select card_holder,
sum(fraud_score) as total_fraud_score, 
count(*) as no_of_suspicious_transaction from (
select card_holder, 
high_amount, 
rapid_transaction,
 high_amount+rapid_transaction+late_night_hour as fraud_score from 
(select card_holder, 
case when amount>avg_card_holder then 1 else 0 end as high_amount,
case when current_date-previous_transaction<= interval '4 hours' then 1 else 0 end as rapid_transaction,
case when hour>=0 and hour<=5 then 1 else 0 end as late_night_hour
from (
select ch.name as card_holder,
 t.amount as amount, 
t.card as card, 
t.date as current_date,
lag(t.date) over (partition by ch.id order by t.date) as previous_transaction,
 avg(t.amount) over(partition by T.CARD) as avg_card_holder,
extract('hour' from date) as hour
from transaction as t
 inner join credit_card as cc
 on t.card=cc.card 
inner join card_holder as ch 
on ch.id=cc.id_cardholder ) as 
x) as y ) as z where fraud_score>=1 group by 1  order by 3 desc

What percentage of total transactions could potentially be classified as fraudulent?
select total_transaction,
 fraud_transactions, 
round(fraud_transactions::numeric/total_transaction::numeric*100,2) as percent_of_fraud_transactions from (
select  count(*) as total_transaction, 
count(*) filter (where amount>card_avg and date-previous_transaction<=interval '10 minutes'
and hour>=0 and hour<=5 )
 as fraud_transactions from (
(select  card, 
amount, 
date, 
avg(amount) over (partition by card) as card_avg, 
lag(date) over (partition by card order by date) 
as previous_transaction, 
extract('hour' from date) as hour
 from transaction) ) as x ) as y
 
What percentage of total transaction value comes from potentially fraudulent transactions?
select total_transaction, 
fraud_transactions,
 round(fraud_transactions::numeric/total_transaction::numeric*100,2) as percent_of_fraud_transactions from (
select  count(*) as total_transaction,
 count(*) filter (where amount>card_avg and date-previous_transaction<=interval '10 mins' and
hour>=0 and hour<=5) as fraud_transactions from
(select  card,
 amount, 
date, 
avg(amount) over (partition by card) as card_avg,
 lag(date) over (partition by card order by date) 
as previous_transaction, 
extract('hour' from date) as hour from transaction)  as x ) as y

Which fraud indicator identifies the highest number of suspicious transactions?
select sum(high_amount)  as transaction_with_high_amount,
sum(transaction_frequency)  as transaction_with_frequency, 
sum(late_hour)  as transaction_with_late_hour from (
select card,
 amount, 
date, 
card_avg,hour, 
previous_transaction, 
high_amount, 
transaction_frequency, 
late_hour ,
high_amount+transaction_frequency+late_hour as fraud_score from (
select card,
 amount, 
date, 
card_avg,hour,
 previous_transaction ,
case when amount>card_avg then 1 else 0 end as high_amount,
case when date-previous_transaction<= interval '10 minutes' then 1 else 0 end as transaction_frequency,
case when hour>=0 and hour<=5 then 1 else 0 end as late_hour from(
select card,
 amount, 
date,
 avg(amount) over (partition by card) as card_avg, 
extract('hour' from date) as hour , 
lag(date) over(partition by card order by date) as previous_transaction 
from transaction) as x) as y) as z  

Which cards trigger multiple fraud indicators simultaneously?
select card,
high_amount, 
transaction_frequency,
 late_hour,
 fraud_score from (
select card, 
amount, 
date, 
card_avg,
hour, 
previous_transaction,
 high_amount, 
transaction_frequency, 
late_hour ,
high_amount+transaction_frequency+late_hour as fraud_score from (
select card,
 amount,
 date, 
card_avg,
hour, 
previous_transaction ,
case when amount>card_avg then 1 else 0 end as high_amount,
case when date-previous_transaction<= interval '10 minutes' then 1 else 0 end as transaction_frequency,
case when hour>=0 and hour<=5 then 1 else 0 end as late_hour from(
select card,
 amount, 
date, 
avg(amount) over (partition by card) as card_avg, 
extract('hour' from date) as hour , 
lag(date) over (partition by card order by date) as previous_transaction from transaction) 
as x) as y) as z 
where fraud_score>=2 order by fraud_score desc

What are the top 10 most suspicious transactions and why are they suspicious?
select transaction_id,
 card, 
high_amount,
high_frequency, 
late_hours, 
fraud_score from(
select transaction_id, 
card,
 high_amount,
high_frequency, 
late_hours, 
high_amount+high_frequency+ late_hours as fraud_score from (
select transaction_id,
 card,
 date, 
previous_transaction, 
amount, 
card_avg, 
hour ,
case when  amount>card_avg then 1 else 0 end as high_amount,
case when date-previous_transaction<=interval '10 minutes' then 1 else 0 end as high_frequency,
case when hour>=0 and hour<=5 then 1 else 0 end as late_hours 
from (
select id as transaction_id, 
card, 
date,
 amount,
 avg(amount) over (partition by card) as card_avg,
 lag(date) over (partition by card order by date) as previous_transaction, 
extract('hour' from date) as hour from transaction ) as x ) as y ) as z 
where fraud_score>=2 order by 6 desc
limit 10



