CREATE DATABASE employment_analysis;

USE employment_analysis;

CREATE TABLE unemployment_rates (
    geo VARCHAR(50),
    time YEAR,
    age_group VARCHAR(10),
    gender VARCHAR(10),
    unemployment_rate FLOAT,
    PRIMARY KEY (geo, time, age_group, gender)
);

CREATE TABLE gdp_growth_data (
    geo VARCHAR(50),
    time YEAR,
    gdp_total_growth FLOAT,
    gdp_per_capita_growth FLOAT,
    PRIMARY KEY (geo, time)
);

CREATE TABLE population_data (
    geo VARCHAR(50),
    time YEAR,
    urban_population BIGINT,
    PRIMARY KEY (geo, time)
);


SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--females_aged_15plus_unemployment_rate_percent--by--geo--time.csv'
INTO TABLE unemployment_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, unemployment_rate)
SET age_group = '15plus', gender = 'female';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--males_aged_15plus_unemployment_rate_percent--by--geo--time.csv'
INTO TABLE unemployment_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, unemployment_rate)
SET age_group = '15plus', gender = 'male';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--females_aged_25_54_unemployment_rate_percent--by--geo--time.csv'
INTO TABLE unemployment_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, unemployment_rate)
SET age_group = '25_54', gender = 'female';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--males_aged_25_54_unemployment_rate_percent--by--geo--time.csv'
INTO TABLE unemployment_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, unemployment_rate)
SET age_group = '25_54', gender = 'male';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--females_aged_55_64_unemployment_rate_percent--by--geo--time.csv'
INTO TABLE unemployment_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, unemployment_rate)
SET age_group = '55_64', gender = 'female';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--males_aged_55_64_unemployment_rate_percent--by--geo--time.csv'
INTO TABLE unemployment_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, unemployment_rate)
SET age_group = '55_64', gender = 'male';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--gdp_total_yearly_growth--by--geo--time.csv'
INTO TABLE gdp_growth_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, gdp_total_growth);

CREATE TEMPORARY TABLE temp_gdp_growth (
    geo VARCHAR(50),
    time YEAR,
    gdp_per_capita_growth FLOAT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--gdp_per_capita_yearly_growth--by--geo--time.csv'
INTO TABLE temp_gdp_growth
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, gdp_per_capita_growth);

INSERT INTO gdp_growth_data (geo, time, gdp_per_capita_growth)
SELECT geo, time, gdp_per_capita_growth FROM temp_gdp_growth
ON DUPLICATE KEY UPDATE gdp_per_capita_growth = VALUES(gdp_per_capita_growth);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--urban_population--by--geo--time.csv'
INTO TABLE population_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, urban_population);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ddf--datapoints--urban_population--by--geo--time.csv'
INTO TABLE population_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES (geo, time, urban_population);

SELECT * FROM unemployment_rates;
