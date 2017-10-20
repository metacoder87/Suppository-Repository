-- tournament.sql 
-- Swiss-system tournament implemented through PostgreSQL
-- Udacity - Full Stack Web Developer - Relational Database - Final Project
-- Gary Miller - 10/20/2017
-- References for my work include GitHub users victron and ericadoyle

-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP VIEW standings;
DROP TABLE matches;
DROP TABLE players;
DROP DATABASE tournament;
CREATE DATABASE tournament;

\c tournament

CREATE TABLE players (name VARCHAR(40), player_id SERIAL UNIQUE PRIMARY KEY);

CREATE TABLE matches (match_id SERIAL UNIQUE PRIMARY KEY,
                      winner INTEGER REFERENCES players(player_id),
                      loser INTEGER REFERENCES players (player_id));

-- Create a view that tallies total matches per player
CREATE OR REPLACE VIEW games_view AS
SELECT players.player_id as id, COUNT(matches.*) AS games
FROM players LEFT JOIN matches
ON players.player_id = matches.winner OR players.player_id = matches.loser
GROUP BY players.player_id;
