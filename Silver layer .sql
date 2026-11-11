use RetailBank;
GO

-- ==================================== 1. table silver customer ==================================== --
select 

	TRY_CAST(customer_id as bigint) as Customer_id ,
	cc_num as Card_number ,
	isnull(ltrim(rtrim( first_name)),'unknown' ) as First_name ,
	isnull(ltrim(rtrim( last_name)),'unknown' ) as Last_name ,
	isnull(ltrim(rtrim( gender)),'unknown' ) as Gender ,
	street as Street,
	city as City,
	[state] as [State] ,
	zip as Zip ,
	TRY_CAST(lat as decimal(9,4) )as Latitude ,
	TRY_CAST(long as decimal(9,4)) as longitude ,
	TRY_CAST(city_pop as int ) as City_population ,
	job as Job,
	TRY_CAST(dob as Date ) as Date_of_birth ,
	ISNULL(NULLIF(LTRIM(RTRIM(loyalty_tier)), ''),'Unknown') AS Loyalty_tier ,
	email_domain ,
	TRY_CAST(signup_date as Date ) as Signup_date

into [Silver].[customers]
from [Bronze].[customers] ;

Alter Table [Silver].[customers] alter column Customer_id bigint not null ;
Alter Table [Silver].[customers] add constraint PK_silver_customer Primary key (Customer_id) ;

select top 5 *
from [Silver].[customers] ;

-- ==================================== 2. table silver merchants ==================================== --
select 

	TRY_CAST(merchant_id as bigint ) as Merchant_id ,
	isnull(NULLIF(ltrim(rtrim( merchant_name)),''),'unknown') as Merchant_name ,
	isnull(NULLIF(ltrim(rtrim( dominant_category)),''),'unknown' ) as Dominant_category ,
	isnull(NULLIF(ltrim(rtrim( merchant_city)),''),'unknown' ) as Merchant_city ,
	isnull(NULLIF(ltrim(rtrim( merchant_state)),''),'unknown' ) as Merchant_state ,
	TRY_CAST(merchant_lat as decimal(9,4) )as merchant_Latitude ,
	TRY_CAST(merchant_long as decimal(9,4) )as merchant_longitude ,
	TRY_CAST(merchant_since as Date ) as merchant_since ,
	is_active as IS_active 

into [Silver].[Merchants]
from [Bronze].[Merchants] ;

Alter Table [Silver].[Merchants] alter column Merchant_id bigint not null ;
Alter Table [Silver].[Merchants] add constraint PK_silver_merchant Primary key (Merchant_id) ;


select top 5 *
from [Silver].[Merchants] ;


-- ==================================== 3. table silver transactions ==================================== --
select 

	TRY_CAST(transaction_id as bigint ) as Transaction_id ,
	CAST(TRY_CAST(trans_date_trans_time AS DATETIME) AS DATE) AS Transaction_date,
	TRY_CAST(trans_date_trans_time AS DATETIME) AS Trans_date_time,
	TRY_CAST(customer_id as bigint) as Customer_id ,
	TRY_CAST(merchant_id as bigint ) as Merchant_id ,
	isnull(NULLIF(ltrim(rtrim( category)),''),'unknown') as Category ,
	TRY_CAST(amt as decimal(10,2) )as Amount ,
	TRY_CAST(tax_amt as decimal(10,2) )as Taxis_amount ,
	isnull(NULLIF(ltrim(rtrim( currency)),''),'unknown' ) as Currency ,
	isnull(NULLIF(ltrim(rtrim( payment_method)),''),'unknown' ) as Payment_method ,
	isnull(NULLIF(ltrim(rtrim( channel)),''),'unknown') as Channel ,
	isnull(NULLIF(ltrim(rtrim( entry_mode)),''),'unknown' ) as Entry_mode ,
	isnull(NULLIF(ltrim(rtrim( device_type)),''),'unknown' ) as Device_type ,
	isnull(NULLIF(ltrim(rtrim( transaction_status)),''),'unknown' ) as transaction_status ,
	isnull(NULLIF(ltrim(rtrim(trans_num)),''),'unknown' ) as transaction_number ,
	isnull(NULLIF(ltrim(rtrim(session_id)),''),'unknown' ) as Session_id ,
	TRY_CAST(unix_time as bigint ) as unix_time ,
	is_fraud as IS_fraud

into [Silver].[Transactions]
from [Bronze].[Transactions] ;

Alter Table [Silver].[Transactions] alter column Transaction_id bigint not null ;
Alter Table [Silver].[Transactions] add constraint PK_silver_transaction Primary key (Transaction_id) ;


select top 5 *
from [Silver].[Transactions] ;
