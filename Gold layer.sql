use RetailBank;
GO

-- ==================================== Gold Dimension Date  ==================================== --
create table [Gold].[DimDate] 
(
	Date_key int not null primary key ,
	Full_date Date not null ,
	[Year] int not null ,
	[Quarter] int not null ,
	[Month] int not null ,
	Month_name varchar(20) not null ,
	[Day] int not null ,
	Day_name varchar(20) not null ,
	Is_weekend bit not null 
);

Declare @Start_Date Date, 
		@End_Date Date, 
		@Current_Date Date ; 

SELECT 
    @Start_Date = MIN(CAST(Transaction_date AS DATE)),
    @End_Date = MAX(CAST(Transaction_date AS DATE))
FROM Silver.Transactions;


SET @Current_Date = @Start_Date;

WHILE @Current_Date <= @End_Date
BEGIN
    INSERT INTO [Gold].[DimDate] (
        Date_key,
        Full_date,
        [Year],
        [Quarter],
        [Month],
        Month_name,
        [Day],
        Day_name,
        Is_weekend
    )
    VALUES (
        CAST(FORMAT(@Current_Date, 'yyyyMMdd') AS INT),
        @Current_Date,
        YEAR(@Current_Date),
        DATEPART(QUARTER, @Current_Date),
        MONTH(@Current_Date),
        DATENAME(MONTH, @Current_Date),
        DAY(@Current_Date),
        DATENAME(WEEKDAY, @Current_Date),
        CASE WHEN DATENAME(WEEKDAY, @Current_Date) IN ('Friday', 'Saturday') THEN 1 ELSE 0 END
    );

    SET @Current_Date = DATEADD(DAY, 1, @Current_Date);
END


select *
from Gold.DimDate


-- ==================================== Gold DimCustomer  ==================================== --

select * 
into [Gold].[DimCustomer]
from [Silver].[customers] ;

Alter Table [Gold].[DimCustomer] alter column Customer_id bigint not null ;
Alter Table [Gold].[DimCustomer] add constraint PK_Gold_DimCustomer Primary key (Customer_id) ;

select top 5 *
from [Gold].[DimCustomer] ;


-- ==================================== Gold DimMerchant  ==================================== --

select * 
into [Gold].[DimMerchant]
from [Silver].[Merchants] ;

Alter Table [Gold].[DimMerchant] alter column Merchant_id bigint not null ;
Alter Table [Gold].[DimMerchant] add constraint PK_Gold_DimMerchant Primary key (Merchant_id) ;


select top 5 *
from [Gold].[DimMerchant] ;

-- ==================================== Gold DimTransaction  ==================================== --

select 
	Transaction_id ,
	CAST(FORMAT(Transaction_date, 'yyyyMMdd') AS INT) AS Date_key,    
    Trans_date_time,
    Customer_id,
    Merchant_id,
    Category,
    Amount,
    Taxis_amount,
    Currency,
    Payment_method,
    Channel,
    Entry_mode,
    Device_type,
    transaction_status,
    transaction_number,
    Session_id,
    unix_time,
    IS_fraud

into [Gold].[DimTransaction]
from [Silver].[Transactions] ;

Alter Table [Gold].[DimTransaction] alter column Transaction_id bigint not null ;
Alter Table [Gold].[DimTransaction] add constraint PK_Gold_transaction Primary key (Transaction_id) ;

ALTER TABLE [Gold].[DimTransaction] ADD CONSTRAINT FK_Transaction_DimDate FOREIGN KEY (Date_key) REFERENCES [Gold].[DimDate](Date_key);

Alter Table [Silver].[customers] alter column Customer_id bigint not null ;
ALTER TABLE [Gold].[DimTransaction] ADD CONSTRAINT FK_Transaction_Customer FOREIGN KEY (Customer_id) REFERENCES [Silver].[customers](Customer_id);

Alter Table [Silver].[Merchants] alter column Merchant_id bigint not null ;
ALTER TABLE [Gold].[DimTransaction] ADD CONSTRAINT FK_Transaction_Merchant FOREIGN KEY (Merchant_id) REFERENCES [Silver].[Merchants](Merchant_id);



select top 5 *
from [Gold].[DimTransaction] ;


-- ==================================== Indexes  ==================================== --

CREATE INDEX IX_DimTransaction_DateKey                  ON [Gold].[DimTransaction] (Date_key);

CREATE INDEX IX_DimTransaction_CustomerKey				ON [Gold].[DimTransaction] (Customer_id);

CREATE INDEX IX_DimTransaction_MerchantKey				ON [Gold].[DimTransaction] (Merchant_id);