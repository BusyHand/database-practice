-- Представление с информацией о ниндзя и их кланах
CREATE VIEW view_ninjas_clans AS
SELECT ninjas.name AS ninja_name, clans.name AS clan_name
FROM ninjas
         JOIN clans ON ninjas.clan_id = clans.id;

-- Представление с информацией о миссиях и их статусе
CREATE VIEW view_missions_status AS
SELECT missions.status, places.name AS place_name
FROM missions
         JOIN places ON missions.place_id = places.id;

-- Представление с информацией о командах и их участниках
CREATE VIEW view_teams_participants AS
SELECT teams.name AS team_name, ninjas.name AS leader_name
FROM teams
         JOIN ninjas ON teams.leader_id = ninjas.id;

-- Представление с информацией о дуэлях и их результатах
CREATE VIEW view_duels_results AS
SELECT duels.date_start, duels.result, places.name AS place_name
FROM duels
         JOIN places ON duels.place_id = places.id;

-- Представление с информацией о артефактах и их архах
CREATE VIEW view_artifacts_archs AS
SELECT artifact.name AS artifact_name, arch.description AS arch_description
FROM artifact
         JOIN arch ON artifact.arch_id = arch.id;