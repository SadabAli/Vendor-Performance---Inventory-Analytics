use vendor;


/*
LOAD DATA LOCAL INFILE will currently fail due to  "local_infile = OFF"
*/
SHOW VARIABLES LIKE 'local_infile'; -- check whether local_infile = OFF/ON

-- We need to Enable it
SET GLOBAL local_infile = 1;