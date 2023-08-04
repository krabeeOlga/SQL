-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS tt;
DELIMITER //
CREATE FUNCTION tt (val int)
RETURNS TEXT DETERMINISTIC
BEGIN
	declare res varchar(255);
	select concat(cast(floor(val/60/60/24) as char(15)),' days ',
	cast(floor(mod(val/60/60/24, 1)*24) as char(2)),' hours',
	cast(floor(mod(mod(val/60/60/24, 1)*24, 1)*60) as char(2)),' minutes ',
	cast(round(mod(mod(mod(val/60/60/24, 1)*24, 1)*60, 1)*60) as char(2)), ' seconds') into res;
    return res;
END//
SELECT tt(123456);


-- Выведите только четные числа от 1 до 10 (Через цикл).
-- Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER //
CREATE PROCEDURE even_numbers (IN you_number INT)
BEGIN
	DECLARE n INT;
	DECLARE result VARCHAR(255) DEFAULT "";
    set n = 1;
	 WHILE n <= you_number DO
		if n % 2 = 0 then 
			SET result = CONCAT(result, n, ','); 
		end if;
		SET n = n + 1;
	END WHILE;
		SELECT substring(result, 1, CHAR_LENGTH(result) -1); -- убираем последнюю запятую
END //
CALL even_numbers(19);



