--stg_player_career_offense

--TODO: cast data types

SELECT *
FROM {{ source('baseball', 'player_career_offense') }}