LOAD DATA LOCAL INFILE ''
INTO TABLE tb_products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    ID,
    SKU,
    name,
    description,
    current_price,
    current_stock,
    @st,
    creation_date,
    last_update
)
SET
    status = IF(@st = '1', b'1', b'0');