-- 1. Получить информацию о ниндзя и их кланах
SELECT ninjas.name AS ninja_name, clans.name AS clan_name
FROM ninjas
         JOIN clans ON ninjas.clan_id = clans.id;

-- 2. Получить информацию о миссиях и местах их выполнения
SELECT missions.status, places.name AS place_name
FROM missions
         JOIN places ON missions.place_id = places.id;

-- 3. Получить список команд и их лидеров
SELECT teams.name AS team_name, ninjas.name AS leader_name
FROM teams
         LEFT JOIN ninjas ON teams.leader_id = ninjas.id;

-- 4. Получить количество участников в каждом клане
SELECT clans.name AS clan_name, clans.participants_count
FROM clans;

-- 5. Получить информацию о таинственных артефактах и арках
SELECT artifact.name AS artifact_name, arch.description AS arch_description
FROM artifact
         JOIN arch ON artifact.arch_id = arch.id;

-- 7. Получить информацию о ниндзя и их миссиях
SELECT ninjas.name AS ninja_name, missions.status AS mission_status
FROM ninjas
         JOIN missions ON ninjas.id = missions.leader_id;

-- 8. Получить информацию о местах и ближайших деревнях
SELECT places.name AS place_name, village.name AS village_name
FROM places
         JOIN village ON places.nearest_village_id = village.id;

-- 9. Получить список всех ниндзя, их организации и команды
SELECT ninjas.name AS ninja_name, organisations.name AS organisation_name, teams.name AS team_name
FROM ninjas
         LEFT JOIN organisations ON ninjas.organisation_id = organisations.id
         LEFT JOIN teams ON ninjas.team_id = teams.id;

-- 10. Получить список дуэлей с участниками и результатами
SELECT ninjas.name AS ninja_name, duels.result, places.name AS place_name
FROM duels
         JOIN ninjas ON duels.opponent1_id = ninjas.id OR duels.opponent2_id = ninjas.id
         JOIN places ON duels.place_id = places.id;
