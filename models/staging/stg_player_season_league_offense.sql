--stg_player_season_leage_offense

--TODO: cast data types

SELECT 
*
FROM {{ source('baseball', 'player_season_league_offense') }}