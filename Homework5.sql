USE lesson_4;
DROP TABLE IF EXISTS cars;
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE OR REPLACE VIEW min_price_cars
AS SELECT 
	`name`,
    cost
FROM cars;

SELECT * FROM min_price_cars
WHERE cost < 25000;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор OR REPLACE)

SELECT * FROM min_price_cars
WHERE cost < 30000;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE OR REPLACE VIEW skoda_audi_cars
AS SELECT 
	`name`,
    cost
FROM cars
WHERE `name` = "Skoda" OR `name` = "Audi";

SELECT * FROM skoda_audi_cars;



DROP TABLE IF EXISTS trains;
CREATE TABLE trains
(
	train_id INT,
    station VARCHAR(20),
    station_time TIME
);

INSERT trains
VALUES
	(110, "San Francisco", "10:00:00"),
    (110, "Redwood City", "10:54:00"),
    (110, "Palo Alto", "11:02:00"),
    (110, "San Jose", "12:35:00"),
	(120, "San Francisco", "11:00:00"),
    (120, "Palo Alto", "12:49:00"), 
    (120, "San Jose", "13:30:00");
    
    
SELECT *
FROM trains;

-- Добавьте новый столбец под названием «время до следующей станции». 

SELECT *,
    TIMEDIFF(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY station_time), station_time) AS time_to_next_station
FROM trains;

-- ДОПЫ

DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;

-- пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

INSERT INTO users (id, firstname, lastname, email) VALUES 
(1, 'Reuben', 'Nienow', 'arlo50@example.org'),
(2, 'Frederik', 'Upton', 'terrence.cartwright@example.org'),
(3, 'Unique', 'Windler', 'rupert55@example.org'),
(4, 'Norene', 'West', 'rebekah29@example.net'),
(5, 'Frederick', 'Effertz', 'von.bridget@example.net'),
(6, 'Victoria', 'Medhurst', 'sstehr@example.net'),
(7, 'Austyn', 'Braun', 'itzel.beahan@example.com'),
(8, 'Jaida', 'Kilback', 'johnathan.wisozk@example.com'),
(9, 'Mireya', 'Orn', 'missouri87@example.org'),
(10, 'Jordyn', 'Jerde', 'edach@example.com');

-- сообщения
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO messages  (from_user_id, to_user_id, body, created_at) VALUES
(1, 2, 'Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.',  DATE_ADD(NOW(), INTERVAL 1 MINUTE)),
(2, 1, 'Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.',  DATE_ADD(NOW(), INTERVAL 3 MINUTE)),
(3, 1, 'Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.',  DATE_ADD(NOW(), INTERVAL 5 MINUTE)),
(4, 1, 'Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.',  DATE_ADD(NOW(), INTERVAL 11 MINUTE)),
(1, 5, 'Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.',  DATE_ADD(NOW(), INTERVAL 12 MINUTE)),
(1, 6, 'Rerum labore culpa et laboriosam eum totam. Quidem pariatur sit alias. Atque doloribus ratione eum rem dolor vitae saepe.',  DATE_ADD(NOW(), INTERVAL 14 MINUTE)),
(1, 7, 'Perspiciatis temporibus doloribus debitis. Et inventore labore eos modi. Quo temporibus corporis minus. Accusamus aspernatur nihil nobis placeat molestiae et commodi eaque.',  DATE_ADD(NOW(), INTERVAL 15 MINUTE)),
(8, 1, 'Suscipit dolore voluptas et sit vero et sint. Rem ut ratione voluptatum assumenda nesciunt ea. Quas qui qui atque ut. Similique et praesentium non voluptate iure. Eum aperiam officia quia dolorem.',  DATE_ADD(NOW(), INTERVAL 21 MINUTE)),
(9, 3, 'Et quia libero aut vitae minus. Rerum a blanditiis debitis sit nam. Veniam quasi aut autem ratione dolorem. Sunt quo similique dolorem odit totam sint sed.',  DATE_ADD(NOW(), INTERVAL 22 MINUTE)),
(10, 2, 'Praesentium molestias quia aut odio. Est quis eius ut animi optio molestiae. Amet tempore sequi blanditiis in est.',  DATE_ADD(NOW(), INTERVAL 25 MINUTE)),
(8, 3, 'Molestiae laudantium quibusdam porro est alias placeat assumenda. Ut consequatur rerum officiis exercitationem eveniet. Qui eum maxime sed in.',  DATE_ADD(NOW(), INTERVAL 27 MINUTE)),
(8, 1, 'Quo asperiores et id veritatis placeat. Aperiam ut sit exercitationem iste vel nisi fugit quia. Suscipit labore error ducimus quaerat distinctio quae quasi.',  DATE_ADD(NOW(), INTERVAL 28 MINUTE)),
(8, 1, 'Earum sunt quia sed harum modi accusamus. Quia dolor laboriosam asperiores aliquam quia. Sint id quasi et cumque qui minima ut quo. Autem sed laudantium officiis sit sit.',  DATE_ADD(NOW(), INTERVAL 33 MINUTE)),
(4, 1, 'Aut enim sint voluptas saepe. Ut tenetur quos rem earum sint inventore fugiat. Eaque recusandae similique earum laborum.',  DATE_ADD(NOW(), INTERVAL 35 MINUTE)),
(4, 1, 'Nisi rerum officiis officiis aut ad voluptates autem. Dolor nesciunt eum qui eos dignissimos culpa iste. Atque qui vitae quos odit inventore eum. Quam et voluptas quia amet.',  DATE_ADD(NOW(), INTERVAL 35 MINUTE)),
(4, 1, 'Consequatur ut et repellat non voluptatem nihil veritatis. Vel deleniti omnis et consequuntur. Et doloribus reprehenderit sed earum quas velit labore.',  DATE_ADD(NOW(), INTERVAL 37 MINUTE)),
(2, 1, 'Iste deserunt in et et. Corrupti rerum a veritatis harum. Ratione consequatur est ut deserunt dolores.',  DATE_ADD(NOW(), INTERVAL 37 MINUTE)),
(8, 1, 'Dicta non inventore autem incidunt accusamus amet distinctio. Aut laborum nam ab maxime. Maxime minima blanditiis et neque. Et laboriosam qui at deserunt magnam.',  DATE_ADD(NOW(), INTERVAL 41 MINUTE)),
(8, 1, 'Amet ad dolorum distinctio excepturi possimus quia. Adipisci veniam porro ipsum ipsum tempora est blanditiis. Magni ut quia eius qui.',  DATE_ADD(NOW(), INTERVAL 42 MINUTE)),
(8, 1, 'Porro aperiam voluptate quo eos nobis. Qui blanditiis cum id eos. Est sit reprehenderit consequatur eum corporis. Molestias quia quo sit architecto aut.',  DATE_ADD(NOW(), INTERVAL 50 MINUTE));

-- заявки на дружбу
DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME,
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO friend_requests (initiator_user_id, target_user_id, `status`, requested_at, updated_at) 
VALUES 
(1, 10, 'approved', '2023-01-05 06:40:37', '2023-01-05 16:28:19'),
(1, 2, 'requested', '2023-01-06 07:33:23', NULL),
(1, 3, 'approved', '2023-01-07 01:53:07', '2023-01-18 16:22:56'),
(4, 1, 'approved', '2023-01-08 15:57:26', '2023-01-15 18:12:00'),
(5, 2, 'approved', '2023-01-08 18:22:00', '2023-01-14 08:25:00'),
(6, 3, 'unfriended', '2023-01-09 17:07:59', '2023-01-09 17:12:45'),
(7, 1, 'requested', '2023-01-09 06:20:23', NULL),
(8, 6, 'unfriended', '2023-01-10 01:50:03', '2023-01-10 06:50:59'),
(9, 7, 'approved', '2023-01-11 22:52:09', NULL),
(10, 6, 'approved', '2023-01-12 00:32:15', '2023-01-12 10:22:15');

-- сообщества
DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
    INDEX communities_name_idx(name)
);

INSERT INTO `communities` (name) 
VALUES ('atque'), ('beatae'), ('est'), ('eum'), ('hic'), ('nemo'), ('quis'), ('rerum'), ('tempora'), ('voluptas');

-- пользователи сообщества
DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO users_communities (user_id, community_id) 
VALUES 
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 2), 
(3, 1), (3, 2), (3, 10), (3, 5), (3, 8),
(4, 1), (4, 2), (4, 3), (4, 8),
(5, 1), (5, 2), (5, 3), (5, 6), (5, 8), (5, 10),
(6, 1), (6, 2), (6, 3), (6, 6),
(7, 1), (7, 2), (7, 3), (7, 8), (7, 7), (7, 6),
(8, 1), (8, 2), (8, 3), (8, 5), (8, 7), (8, 9),
(9, 1), (9, 2),  
(10, 1), (10, 10);

-- типы медиа
DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name_type VARCHAR(255)
);

INSERT INTO media_types (name_type)
VALUES 	('Photo'), ('Music'), ('Video'), ('Post');


-- медиа
DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_type_id BIGINT UNSIGNED,
  	body text,
  	filename VARCHAR(255), 
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO media (media_type_id, user_id, filename, body) VALUES 
(3, 1, 'a.avi', 'Est aut aliquid est. Soluta eveniet doloribus ipsam ut id assumenda quam. Consequuntur et velit aperiam error corporis rem corporis. Est similique quisquam quia maxime eaque possimus facere officiis. Odio magni atque dicta voluptatibus hic iste delectus.'),
(2, 2, '1.mp3', 'Laborum dolorem magni unde vero sit hic. Pariatur quia voluptas magnam. Blanditiis dolorem et molestias veniam facere provident.'),
(1, 3, 'sapiente.png', 'A quam ea ullam reiciendis vel et reiciendis. Delectus iure mollitia est. Eum dolores dolores sed officia vitae qui. Sed repudiandae voluptatem voluptatibus libero culpa quo.'),
(3, 4, 'rerum.mp4', 'Velit commodi in veniam occaecati. Tenetur temporibus ullam enim officiis aut illum. In maiores velit nobis soluta molestias maiores tempora. Quisquam et ut et sequi.'),
(1, 5, 'user5-profile-image.bmp', 'Est eaque est qui et omnis rerum. Expedita porro nesciunt inventore consequatur quos. Inventore aut rerum voluptas. Dicta vel ut quibusdam cupiditate tempore.'),
(1, 6, 'quasi.jpg', 'Atque et nam nulla et aliquid. Vel repellendus aut natus odit quibusdam quis atque et. Laudantium minima velit dolores eos voluptate nostrum.'),
(3, 7, 'non.mp4', 'Nihil ut et reprehenderit et. Numquam veniam quis impedit. Voluptas saepe rerum illo vel omnis. Aliquam illum ut quo saepe ea unde est.'),
(4, 8, 'new_01012023.docx', 'Sint quod fugit molestiae dolore repellendus est. Quis corporis necessitatibus commodi placeat temporibus doloremque voluptatem. Nemo maxime sit dolorem perferendis repellat. Et impedit deleniti eaque pariatur ut quia voluptatibus.'),
(1, 9, 'ullam.jpg', 'Optio sed aperiam veniam eum. Rerum placeat soluta iusto perspiciatis quibusdam dolorem eos. Ea pariatur optio est ut.'),
(2, 10, '2.mp3', 'Facere nostrum facilis aperiam quisquam dolor. Minima omnis est nam.'),
(3, 1, 'non.mp4', 'A omnis ratione non. Et velit sed incidunt corporis ut rerum nemo. Ut pariatur tempora ea incidunt praesentium ut. Eligendi et et rerum sequi ut.'),
(4, 1, 'new_07012023.html', 'Quo minus harum debitis debitis quis sunt. Dolores suscipit placeat dolorum non voluptate et. Non eos odio esse tempore. Illum minus quidem temporibus porro.'),
(1, 1, '1.jpg', NULL),
(2, 1, 'godt.mp3', 'Nobis est sed blanditiis assumenda incidunt explicabo. Facere rem assumenda odio explicabo ad enim repellat quia. Dolor mollitia fugiat officia nihil animi.'),
(3, 1, 'path1.avi', 'Tempora ad et aspernatur laborum ut dolor et. Exercitationem quaerat corporis placeat et.'),
(4, 1, 'new_07012023.html', 'Accusantium est ea fuga omnis mollitia. Dolores officia et consequatur iste est quo. Ullam laborum qui ut quo delectus temporibus.'),
(1, 1, 'map.bmp', 'Quasi itaque atque ut aliquam debitis. Qui consequuntur maiores sit ad perspiciatis quaerat assumenda repudiandae. Necessitatibus placeat quaerat aut voluptatem ratione voluptate expedita. Nulla doloremque aut molestiae nam.'),
(2, 1, '7.acc', 'Deserunt voluptatem quia voluptatem sit. Qui omnis distinctio optio voluptatem veniam atque dolorem. Repellat laboriosam illo consequatur nesciunt voluptas magni rerum. Saepe quos qui doloremque.'),
(3, 1, 'path2.avi', 'Fugiat consequuntur voluptatem odit omnis. Quia aut voluptate officia rerum. Cumque voluptatem eaque dolorum voluptas sed. Et autem atque est minus veritatis explicabo eos.'),
(4, 2, 'new_10012023.html', 'Autem dolore beatae aut corporis fugit ratione. Ex beatae qui at. Est deleniti asperiores temporibus perferendis est.'),
(1, 8, 'poster.jpg', 'Provident eligendi animi quidem qui ipsum. Accusamus dolor sint est qui magnam. Omnis enim quis dolore magni facilis repudiandae deserunt. Consequatur eum at recusandae id tenetur voluptas amet.'),
(2, 10, 'music_all.mp3', 'Animi ut labore dolore atque consequuntur maxime fugit. Sunt et et facere sint. Recusandae numquam accusamus a. Non quia dolorem reiciendis earum et officiis iure.'),
(3, 3, 'kino.avi', 'Sint officiis a ipsa quaerat rerum ea totam. Aut perferendis deleniti error ipsa ducimus ipsam. Ipsum a sunt quis placeat.'),
(4, 9, 'new_117012023.doc', 'Et accusamus a et adipisci dolore. Blanditiis sit vitae dolorem voluptas temporibus numquam ab. Aut temporibus accusantium consectetur.'),
(1, 10, 'main_photo.jpg', 'Consequuntur animi sed ea perferendis ad magnam. Aut libero alias sequi iste qui est. Ut quo dignissimos quibusdam doloremque est est incidunt.'),
(2, 1, 'ariya.mp3', 'Accusantium sit praesentium voluptatem molestias architecto. Excepturi doloremque ab eligendi eum ullam voluptas qui. Inventore expedita distinctio omnis laborum laboriosam.'),
(3, 1, 'film.mp4', NULL),
(4, 1, 'news.html', 'A culpa nostrum et quis. Id ipsum ipsum deserunt earum eaque aut earum. Blanditiis et commodi voluptas.'),
(1, 3, 'non.jpg', 'Cumque quod provident provident fugit cumque numquam. Fuga totam delectus a aut quaerat nemo dignissimos eos. Ratione harum et laborum qui dolore aliquam facilis numquam. At quas nam sapiente porro nesciunt voluptatum.'),
(1, 8, 'et.jpg', 'Provident quia fuga et consequatur reprehenderit repellat. Et aut cum nostrum ut beatae animi aut alias.');

-- лайки медиа
DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)  ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id)  ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO likes (user_id, media_id) VALUES 
(1, 1), (2, 1), (3, 1), (4, 1), (5, 2), (6, 2), (7, 2), (8, 8), (1, 9), (10, 15), (7, 11), (5, 12), (6, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20); 

-- профиль пользователя
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED,
    hometown VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)  ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (photo_id) REFERENCES media(id)  ON UPDATE CASCADE ON DELETE SET NULL
);
INSERT INTO `profiles` (user_id, gender, birthday, photo_id, hometown) VALUES 
(1, 'f', '1976-11-08', 9, 'Adriannaport'),
(2, 'f', '2011-12-20', 13, 'North Nettieton'),
(3, 'm', '1994-06-15', 3, 'Padbergtown'),
(4, 'f', '1979-11-07', NULL, 'Port Rupertville'),
(5, 'f', '1976-04-19', 5, 'Spencerfort'),
(6, 'f', '1983-09-07', 6, 'South Woodrowmouth'),
(7, 'm', '2014-07-31', NULL, 'South Jeffereyshire'),
(8, 'f', '1975-03-26', 17, 'Howeside'),
(9, 'f', '1982-11-01', 9, 'Loweborough'),
(10, 'm', '1977-05-14', NULL, 'New Nellaside');

SELECT * FROM users;
SELECT * FROM profiles;
SELECT * FROM likes;
SELECT * FROM messages;
SELECT * FROM friend_requests;
SELECT * FROM users_communities;

-- Получите друзей пользователя с id=1
-- (решение задачи с помощью представления “друзья”)


CREATE OR REPLACE VIEW approved_friends
AS SELECT 
	initiator_user_id,
    status
FROM friend_requests
WHERE target_user_id = 1 AND `status` = "approved";

SELECT * FROM approved_friends;

-- Создайте представление, в котором будут выводится все сообщения, в которых принимал
-- участие пользователь с id = 1.

CREATE OR REPLACE VIEW messages_from_id_1
AS SELECT 
	from_user_id,
    body,
    created_at
FROM messages
WHERE from_user_id = 1;

SELECT * FROM messages_from_id_1;

-- Получите список медиафайлов пользователя с количеством лайков(media m, likes l ,users u)

CREATE OR REPLACE VIEW media_list
AS SELECT
    u.id, m.body, m.filename, m.created_at, COUNT(l.media_id) AS "Кол-во лайков"
FROM media m 
LEFT JOIN likes l ON l.media_id = m.id
JOIN users u ON u.id = m.user_id
WHERE u.id = 1
GROUP BY m.id;

SELECT * FROM media_list;

-- Получите количество групп у пользователей

CREATE OR REPLACE VIEW list_communities
AS SELECT
    user_id, COUNT(community_id) AS "Кол-во сообществ"
FROM users_communities
GROUP BY user_id;

SELECT * FROM list_communities;

-- Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет

CREATE OR REPLACE VIEW users_yonger_20_years
AS SELECT
    u.firstname, u.lastname, p.hometown, p.gender
FROM users u
JOIN `profiles` p ON p.user_id = u.id
WHERE (2023 - YEAR(DATE(birthday))) <= 20;

SELECT * FROM users_yonger_20_years;

-- Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, указав имя и фамилию
-- пользователя, количество отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным количеством сообщений).
-- (используйте DENSE_RANK)

SELECT
    u.id,
	u.firstname,
    u.lastname,
    COUNT(m.from_user_id) AS "Кол-во сообщений",
    DENSE_RANK() OVER(ORDER BY COUNT(m.from_user_id) DESC) AS "Рейтинг"
FROM users u
JOIN messages m ON u.id = m.from_user_id
GROUP BY u.id;

-- Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу дат отправления 
-- между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)

SELECT * ,
    TIMEDIFF(LEAD(created_at) OVER (ORDER BY created_at), created_at) AS time_diff
FROM messages;








