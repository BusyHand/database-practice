CREATE INDEX idx_village_name ON village(name);

CREATE INDEX idx_arch_description ON arch(description);

CREATE INDEX idx_clans_name ON clans(name);

CREATE INDEX idx_teams_name ON teams(name);

CREATE INDEX idx_organisations_name ON organisations(name);

CREATE INDEX idx_ninjas_name ON ninjas(name);

CREATE INDEX idx_places_name ON places(name);

CREATE INDEX idx_jutsu_list_name ON jutsu_list(name);

CREATE INDEX idx_missions_status ON missions(status);

CREATE INDEX idx_tailed_beast_bigio ON tailed_beast(bigio);

CREATE INDEX idx_weapon_name ON weapon(name);

CREATE INDEX idx_artifact_name ON artifact(name);

CREATE INDEX idx_duels_date_start ON duels(date_start);

CREATE INDEX idx_weapon_ninja_id_w ON weapon_ninja(id_w);

CREATE INDEX idx_jinchuriki_id_ninja ON jinchuriki(id_ninja);