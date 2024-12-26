-- Village Table
INSERT INTO village (name, kage_id, country, residents_count, ninja_count, jinchuriki)
VALUES ('Hidden Leaf', 1, 'Fire', 10000, 500, TRUE),
       ('Hidden Sand', 2, 'Wind', 8000, 300, FALSE),
       ('Hidden Mist', 3, 'Water', 6000, 400, TRUE),
       ('Hidden Cloud', 4, 'Lightning', 7000, 350, FALSE);

-- Arch Table
INSERT INTO arch (description, episodes_count, first_episode, last_episode)
VALUES ('Chunin Exams', 20, 21, 40),
       ('Sasuke Retrieval', 15, 41, 55),
       ('Kazekage Rescue', 18, 56, 73);

-- Clans Table
INSERT INTO clans (name, village_id, participants_count, secret_jutsu_id, kekkei_genkai)
VALUES ('Uchiha', 1, 200, 1, 'Sharingan'),
       ('Hyuga', 1, 300, 2, 'Byakugan'),
       ('Aburame', 1, 150, 3, 'Insect Control');

-- Teams Table
INSERT INTO teams (name, leader_id, participants_count)
VALUES ('Team 7', 1, 4),
       ('Team 10', 2, 4);

-- Organisations Table
INSERT INTO organisations (name, goal, participants_count)
VALUES ('Akatsuki', 'Capture Tailed Beasts', 10),
       ('Root', 'Anbu Black Ops', 15);

-- Ninjas Table
INSERT INTO ninjas (name, clan_id, age, rank, team_id, organisation_id, arch_id)
VALUES ('Naruto Uzumaki', 1, 17, 'Genin', 1, NULL, 1),
       ('Sasuke Uchiha', 1, 17, 'Genin', 1, NULL, 1),
       ('Kakashi Hatake', 2, 30, 'Jonin', 1, NULL, 1); -- Заменено NULL на 2


-- Places Table
INSERT INTO places (name, nearest_village_id, coordinates)
VALUES ('Valley of the End', 1, '35.6895,139.6917'),
       ('Forest of Death', 2, '36.2048,138.2529'); -- Изменен ID деревни

-- Jutsu List Table
INSERT INTO jutsu_list (name, type, chakra_nature, owner_id, power, chakra_consumption)
VALUES ('Rasengan', 'Ninjutsu', 'Wind', 1, 90, 20),
       ('Chidori', 'Ninjutsu', 'Lightning', 2, 95, 25);

-- Missions Table
INSERT INTO missions (status, leader_id, date, place_id)
VALUES ('Completed', 1, '2023-01-10', 1),
       ('Failed', 2, '2023-02-15', 2);

-- Tailed Beast Table
INSERT INTO tailed_beast (bigio, power)
VALUES ('Kurama', 1000),
       ('Shukaku', 800);

-- Weapon Table
INSERT INTO weapon (name, type, properties)
VALUES ('Kunai', 'Throwing', 'Sharp, Lightweight'),
       ('Shuriken', 'Throwing', 'Sharp, Multi-Blade');

-- Artifact Table
INSERT INTO artifact (name, properties, count, arch_id)
VALUES ('Moon Scroll', 'Sealing Power', 1, 1),
       ('Sand Gourd', 'Stores Sand', 1, 2);

-- Duels Table
INSERT INTO duels (duration_hours, date_start, date_end, opponent1_id, opponent2_id, result, place_id)
VALUES (1.5, '2023-03-01 10:00:00', '2023-03-01 11:30:00', 1, 2, 'Draw', 1);

-- Weapon Ninja Table
INSERT INTO weapon_ninja (id_w, id_n)
VALUES (1, 1),
       (2, 2);

-- Jinchuriki Table
INSERT INTO jinchuriki (id_ninja, id_beast)
VALUES (1, 1),
       (3, 2);
