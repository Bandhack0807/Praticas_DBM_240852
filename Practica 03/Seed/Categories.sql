LOAD DATA LOCAL INFILE 'ruta'
INTO TABLE tb_categories
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    ID,
    name,
    description,
    @sup_id_category,
    @st,
    creation_date,
    last_update
)
SET
    sup_id_category = NULLIF(@sup_id_category, ''),
    status = IF(@st = '1', b'1', b'0');