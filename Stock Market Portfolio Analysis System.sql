CREATE TABLE investors (
    investor_id INT PRIMARY KEY,
    investor_name VARCHAR(50),
    city VARCHAR(30),
    risk_profile VARCHAR(20)
);


CREATE TABLE stocks (
    stock_id INT PRIMARY KEY,
    stock_name VARCHAR(50),
    sector VARCHAR(30),
    current_price DECIMAL(10,2)
);

CREATE TABLE portfolio (
    portfolio_id INT PRIMARY KEY,
    investor_id INT,
    stock_id INT,
    quantity INT,
    buy_price DECIMAL(10,2),
    buy_date DATE,
    
    FOREIGN KEY (investor_id) REFERENCES investors(investor_id),
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

---------------------------------
INSERT INTO investors VALUES
(1,'Neha Sharma','Mumbai','High'),
(2,'Rahul Verma','Delhi','Medium'),
(3,'Priya Singh','Pune','Low'),
(4,'Aman Jain','Bangalore','High'),
(5,'Sneha Patel','Ahmedabad','Medium'),
(6,'Rohit Gupta','Indore','High'),
(7,'Karan Mehta','Jaipur','Low'),
(8,'Pooja Yadav','Lucknow','Medium'),
(9,'Vikas Shah','Surat','High'),
(10,'Anjali Rao','Hyderabad','Medium');

--------------------------------------------

INSERT INTO stocks VALUES
(101,'TCS','IT',3520.50),
(102,'Infosys','IT',1450.75),
(103,'HDFC Bank','Banking',1680.20),
(104,'ICICI Bank','Banking',1225.40),
(105,'Reliance','Energy',2950.10),
(106,'Adani Ports','Logistics',1455.60),
(107,'Bharti Airtel','Telecom',1650.80),
(108,'Asian Paints','Paint',2890.00),
(109,'ITC','FMCG',455.75),
(110,'Larsen & Toubro','Infrastructure',3720.50);

---------------------------------------------------
INSERT INTO portfolio VALUES
(1,1,101,10,3200,'2024-01-10'),
(2,1,103,15,1500,'2024-02-15'),
(3,2,105,8,2600,'2024-01-20'),
(4,2,109,30,390,'2024-03-01'),
(5,3,102,20,1300,'2024-02-10'),
(6,3,108,5,2500,'2024-02-25'),
(7,4,104,25,1000,'2024-01-12'),
(8,4,110,6,3400,'2024-03-15'),
(9,5,107,12,1400,'2024-01-30'),
(10,5,101,4,3300,'2024-04-10'),
(11,6,105,7,2500,'2024-02-18'),
(12,6,103,10,1450,'2024-02-20'),
(13,7,109,40,380,'2024-01-05'),
(14,7,102,15,1250,'2024-03-22'),
(15,8,108,3,2400,'2024-02-28'),
(16,8,110,2,3500,'2024-04-02'),
(17,9,106,18,1200,'2024-01-17'),
(18,9,107,10,1500,'2024-03-10'),
(19,10,104,20,980,'2024-01-25'),
(20,10,105,5,2550,'2024-04-05');

--------------------------------------

-- REAL PROJECT QUESTIONS FOR PRACTICE

-- 1. Show all investors

select investor_name from investors ;

-- 2. Show IT sector stocks

select sector from stocks 

-- 3. Total quantity bought by each investor

select i.investor_id , 
       i.investor_name ,
	   sum(p.quantity )as new_qty
	   from investors as i 
	   inner join portfolio  as p
	   on i.investor_id =p.investor_id 
	   group by i.investor_name,
	   i.investor_id 
	   order by i. investor_id asc;

-- 4. Show investor name with stock names

select i.investor_name ,
        s.stock_name , p.quantity from stocks  as s
		inner join portfolio as p
		on p.stock_id =s.stock_id 
		inner join investors as i
		on i.investor_id =p.investor_id  ;
		
-- 5. Calculate current investment value

select i.investor_id,
        i.investor_name ,
		sum(quantity * buy_price) as new_investment from portfolio as p
		inner join investors  as i
		on i.investor_id =p.investor_id 
		group by i.investor_id,
        i.investor_name 
		order by investor_id asc;
		
-- 6. Calculate Profit/Loss

select i.investor_id ,i.investor_name,
       sum((s.current_price - p.buy_price )*p.quantity) as cal_pnl from investors as i
	   inner join portfolio as p
	   on i.investor_id = p.investor_id 
	   inner join stocks as s
	   on s.stock_id =p.stock_id 
	   group by i.investor_id ,
	   i.investor_name
	   order by investor_id asc;
	   
-- 7. Top 3 investors by portfolio value

select i.investor_id ,
        i.investor_name ,
		sum ((s.current_price * p.quantity)as portfolio_value from investors as i
		inner join portfolio as p
		on i.investor_id =p.investor_id 
		inner join stocks as s
		on s.stock_id =p.stock_id 
		group by i.investor_id 
        i.investor_name  
		order by portfolio_value desc
		limit 3;

		
-- 8. Sector-wise investment analysis

select i.investor_id ,
        i.investor_name ,
		s.sector,
		sum(p.quantity * p.buy_price) as investment_analysis from investors as  i
		inner join portfolio as p
		on i.investor_id = p.investor_id 
		inner join stocks as s
		on s.stock_id =p.stock_id 
		group by i.investor_id ,
        i.investor_name ,
		s.sector;

-- 9. Investor with highest profit

select i.investor_id ,
i.investor_name ,
sum((s.current_price-p.buy_price)*p.quantity) as highest_profit from investors as i
inner join portfolio as p
on i.investor_id =p.investor_id 
inner join stocks as s 
on s.stock_id = p.stock_id 
group by i.investor_id ,
i.investor_name 
order by i.investor_id asc;
		

LIMIT 1;



