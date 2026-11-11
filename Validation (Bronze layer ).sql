use RetailBank;
Go


-- === Table Customer ===== 

select * 
from [Bronze].[customers] ;

-- ================ 1-Nulls -- ========================

select 

	sum (case when customer_id is null or customer_id ='' then 1 else 0 end) as blank_id ,
	sum (case when first_name is null or first_name ='' then 1 else 0 end) as blank_first_name ,
	sum (case when last_name is null or last_name ='' then 1 else 0 end) as blank_last_name ,
	sum (case when gender is null or gender ='' then 1 else 0 end) as blank_gender ,
	sum (case when city_pop is null or job ='' then 1 else 0 end) as blank_city_pop ,
	sum (case when job is null or job ='' then 1 else 0 end) as blank_job ,
	sum (case when email_domain is null or email_domain ='' then 1 else 0 end) as blank_email ,
	sum (case when loyalty_tier is null or loyalty_tier ='' then 1 else 0 end) as blank_loyalty_tier

from [Bronze].[customers] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[customers]
where TRY_CAST([customer_id] as int ) is null ;

select * 
from [Bronze].[customers]
where TRY_CAST(city_pop as int ) is null ;

select * 
from [Bronze].[customers]
where TRY_CAST(dob as Date ) is null ;

select * 
from [Bronze].[customers]
where TRY_CAST(signup_date as Date ) is null ;

-- ================ 3-check range  -- ========================

select min(dob) as min_date_of_birth , max(dob) as max_date_of_birth
from [Bronze].[customers]

select min(signup_date) as min_signup_date , max(signup_date) as max_signup_date
from [Bronze].[customers]

-- ================ 4-inconsistent category values -- ========================

select distinct gender 
from [Bronze].[customers] ;

select distinct gender ,count(*) as CNT	 
from [Bronze].[customers] 
group by gender ;

select distinct job ,count(*) as CNT	 
from [Bronze].[customers] 
group by job ;

select distinct loyalty_tier ,count(*) as CNT	 
from [Bronze].[customers] 
group by loyalty_tier ;

-- ================ 5- Duplicates IDs -- ========================

select customer_id, count(*) as CNT
from [Bronze].[customers]
group by customer_id
having count(*) >1 ;

-- ================ 6- Total rows count -- ========================

select count(*) as CNT
from [Bronze].[customers] ;

----------------------------------------------------------
----------------------------------------------------------

-- === Table Merchants ===== 

select * 
from [Bronze].[Merchants] ;

-- ================ 1-Nulls -- ========================

select 

	sum (case when merchant_id is null or merchant_id ='' then 1 else 0 end) as blank_merchant_id,
	sum (case when merchant_name is null or merchant_name ='' then 1 else 0 end) as blank_merchant_name ,
	sum (case when dominant_category is null or dominant_category ='' then 1 else 0 end) as blank_dominant_category ,
	sum (case when is_active is null or is_active ='' then 1 else 0 end) as blank_is_active ,
	sum (case when merchant_since is null or merchant_since ='' then 1 else 0 end) as blank_merchant_since

from [Bronze].[Merchants] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[Merchants]
where TRY_CAST([merchant_id] as int ) is null ;

select * 
from [Bronze].[Merchants]
where TRY_CAST(merchant_since as Date ) is null ;

-- ================ 3-check range  -- ========================

select min(merchant_since) as min_merchant_since , max(merchant_since) as max_merchant_since
from [Bronze].[Merchants]

-- ================ 4-inconsistent category values -- ========================

select distinct is_active 
from [Bronze].[Merchants] ;

select distinct is_active ,count(*) as is_active_count	 
from [Bronze].[Merchants]
group by is_active ;

select distinct dominant_category ,count(*) as dominant_category_count 
from [Bronze].[Merchants]
group by dominant_category ;

-- ================ 5- Duplicates IDs -- ========================

select merchant_id, count(*) as CNT
from [Bronze].[Merchants]
group by merchant_id
having count(*) >1 ;

-- ================ 6 - Total rows count -- ========================

select count(*) as CNT
from [Bronze].[Merchants] ;

----------------------------------------------------------
----------------------------------------------------------

-- === Table Transactions ===== 

select * 
from [Bronze].[Transactions];

-- ================ 1-Nulls ========================

select 

	sum (case when transaction_id is null or transaction_id ='' then 1 else 0 end) as blank_transaction_id ,
	sum (case when customer_id is null or customer_id ='' then 1 else 0 end) as blank_customer_id ,
	sum (case when merchant_id is null or merchant_id ='' then 1 else 0 end) as blank_merchant_id,
	sum (case when category is null or category ='' then 1 else 0 end) as blank_category ,
	sum (case when amt is null or amt ='' then 1 else 0 end) as blank_Amount ,
	sum (case when channel is null or channel ='' then 1 else 0 end) as blank_channel ,
	sum (case when entry_mode is null or entry_mode ='' then 1 else 0 end) as blank_entry_mode ,
	sum (case when is_fraud is null or is_fraud ='' then 1 else 0 end) as blank_is_fraud

from [Bronze].[Transactions] ;

-- ================ 2-datatype -- ========================

select * 
from [Bronze].[Transactions]
where TRY_CAST(transaction_id as int ) is null ;

select * 
from [Bronze].[Transactions]
where TRY_CAST(trans_date_trans_time as datetime ) is null ;

select * 
from [Bronze].[Transactions]
where TRY_CAST(amt as decimal(18,2)) is null 
   or TRY_CAST(tax_amt as decimal(18,2)) is null
   or TRY_CAST(discount_amt as decimal(18,2)) is null;

-- ================ 3-check range  -- ========================

select min(trans_date_trans_time) as min_trans_date_trans_time , max(trans_date_trans_time) as max_trans_date_trans_time
from [Bronze].[Transactions]

-- ================ 4-inconsistent category values -- ========================

select distinct category 
from [Bronze].[Transactions] ;

select distinct category ,count(*) as category_count	 
from [Bronze].[Transactions]
group by category ;

select distinct payment_method ,count(*) as payment_method_count	 
from [Bronze].[Transactions]
group by payment_method ;

select distinct channel ,count(*) as channel_count	 
from [Bronze].[Transactions]
group by channel ;

select distinct entry_mode ,count(*) as entry_mode_count	 
from [Bronze].[Transactions]
group by entry_mode ;

select distinct device_type ,count(*) as device_type_count	 
from [Bronze].[Transactions]
group by device_type ;

select distinct transaction_status ,count(*) as transaction_status_count	 
from [Bronze].[Transactions]
group by transaction_status ;

select distinct is_fraud ,count(*) as is_fraud_count	 
from [Bronze].[Transactions]
group by is_fraud ;

-- ================ 5- Duplicates IDs -- ========================

select transaction_id, count(*) as CNT
from [Bronze].[Transactions]
group by transaction_id
having count(*) >1 ;

-- ================ 6 - Total rows count -- ========================

select count(*) as CNT
from [Bronze].[Transactions] ;

-- ================ 7 - validate orphan transactions -- ========================

-- transactions VS customers
select count(*) as orphan_customers 
from [Bronze].[Transactions] as T
left join [Bronze].[customers] As C
	on TRY_CAST(c.customer_id as int) = TRY_CAST(T.customer_id as int)
Where c.customer_id is null ;

-- transactions VS customers
select count(*) as orphan_merchants 
from [Bronze].[Transactions] as T
left join [Bronze].[Merchants] As M
	on TRY_CAST(M.merchant_id as int) = TRY_CAST(T.merchant_id as int)
Where M.merchant_id is null ;