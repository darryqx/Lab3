-- 1. Удаляем внешний ключ (узнайте его точное имя в свойствах таблицы или ERD-схеме)
ALTER TABLE correspondence DROP CONSTRAINT fk_correspondence_sender;

-- 2. Добавляем запись с несуществующим sender_id (например, 9999)
INSERT INTO correspondence (correspondence_id, sender_id, tracking_number) 
VALUES (100, 9999, 'RU123456789');



SELECT
    tc.table_name AS таблица,
    kcu.column_name AS столбец,
    tc.constraint_name AS имя_ключа,
    ccu.table_name AS главная_таблица,
    ccu.column_name AS главный_столбец
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY';


ALTER TABLE correspondence DROP CONSTRAINT fk_sender;


INSERT INTO correspondence (
    track_number, 
    mail_type_id, 
    weight, 
    length, 
    width, 
    height, 
    sender_id, 
    stamp_amount
)
VALUES (
    'RA999999999RU', 
    1, 
    0.5, 
    20, 
    15, 
    5, 
    9999, 
    150
);


SELECT *
FROM senders s
RIGHT JOIN correspondence c ON s.sender_id = c.sender_id;

SELECT *
FROM senders s
LEFT JOIN correspondence c ON s.sender_id = c.sender_id;
  
-- 1. Удаляем ошибочную запись с несуществующим отправителем
DELETE FROM correspondence WHERE sender_id = 9999;

-- 2. Возвращаем внешний ключ на место
ALTER TABLE correspondence 
ADD CONSTRAINT fk_sender 
