CREATE TABLE village
(
    id              SERIAL PRIMARY KEY,
    name            VARCHAR UNIQUE NOT NULL,
    kage_id         INTEGER        NOT NULL,
    country         VARCHAR        NOT NULL,
    residents_count INTEGER        NOT NULL,
    ninja_count     INTEGER        NOT NULL,
    jinchuriki      BOOLEAN        NOT NULL
);

CREATE TABLE arch
(
    id             SERIAL PRIMARY KEY,
    description    VARCHAR UNIQUE NOT NULL,
    episodes_count INTEGER        NOT NULL,
    first_episode  INTEGER UNIQUE NOT NULL,
    last_episode   INTEGER UNIQUE NOT NULL
);

CREATE TABLE clans
(
    id                 SERIAL PRIMARY KEY,
    name               VARCHAR UNIQUE NOT NULL,
    village_id         INTEGER        NOT NULL REFERENCES village (id),
    participants_count INTEGER        NOT NULL,
    secret_jutsu_id    INTEGER        NOT NULL,
    kekkei_genkai      VARCHAR        NOT NULL
);

CREATE TABLE teams
(
    id                 SERIAL PRIMARY KEY,
    name               VARCHAR NOT NULL,
    leader_id          INTEGER,
    participants_count INTEGER NOT NULL
);

CREATE TABLE organisations
(
    id                 SERIAL PRIMARY KEY,
    name               VARCHAR UNIQUE NOT NULL,
    goal               VARCHAR        NOT NULL,
    participants_count INTEGER        NOT NULL
);

CREATE TABLE ninjas
(
    id              SERIAL PRIMARY KEY,
    name            VARCHAR UNIQUE NOT NULL,
    clan_id         INTEGER        NOT NULL REFERENCES clans (id),
    age             INTEGER        NOT NULL,
    rank            VARCHAR,
    team_id         INTEGER REFERENCES teams (id),
    organisation_id INTEGER REFERENCES organisations (id),
    arch_id         INTEGER        NOT NULL REFERENCES arch (id)
);

CREATE TABLE places
(
    id                 SERIAL PRIMARY KEY,
    name               VARCHAR UNIQUE NOT NULL,
    nearest_village_id INTEGER UNIQUE NOT NULL REFERENCES village (id),
    coordinates        VARCHAR UNIQUE NOT NULL
);

CREATE TABLE jutsu_list
(
    id                 SERIAL PRIMARY KEY,
    name               VARCHAR UNIQUE NOT NULL,
    type               VARCHAR        NOT NULL,
    chakra_nature      VARCHAR        NOT NULL,
    owner_id           INTEGER        NOT NULL REFERENCES ninjas (id),
    power              INTEGER        NOT NULL,
    chakra_consumption INTEGER        NOT NULL
);

CREATE TABLE missions
(
    id        SERIAL PRIMARY KEY,
    status    VARCHAR NOT NULL,
    leader_id INTEGER NOT NULL REFERENCES ninjas (id),
    date      DATE    NOT NULL,
    place_id  INTEGER NOT NULL REFERENCES places (id)
);

CREATE TABLE tailed_beast
(
    id    SERIAL PRIMARY KEY,
    bigio VARCHAR UNIQUE NOT NULL,
    power INTEGER        NOT NULL
);

CREATE TABLE weapon
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR UNIQUE NOT NULL,
    type       VARCHAR        NOT NULL,
    properties VARCHAR        NOT NULL
);

CREATE TABLE artifact
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR UNIQUE NOT NULL,
    properties VARCHAR        NOT NULL,
    count      INTEGER        NOT NULL,
    arch_id    INTEGER        NOT NULL REFERENCES arch (id)
);

CREATE TABLE duels
(
    id             SERIAL PRIMARY KEY,
    duration_hours FLOAT          NOT NULL,
    date_start     TIMESTAMP      NOT NULL,
    date_end       TIMESTAMP      NOT NULL,
    opponent1_id   INTEGER        NOT NULL REFERENCES ninjas (id),
    opponent2_id   INTEGER        NOT NULL REFERENCES ninjas (id),
    result         VARCHAR        NOT NULL,
    place_id       INTEGER UNIQUE NOT NULL REFERENCES places (id)
);

CREATE TABLE weapon_ninja
(
    id_w INTEGER NOT NULL REFERENCES weapon (id),
    id_n INTEGER NOT NULL REFERENCES ninjas (id)
);

CREATE TABLE jinchuriki
(
    id_ninja INTEGER NOT NULL REFERENCES ninjas (id),
    id_beast INTEGER NOT NULL REFERENCES tailed_beast (id)
);
