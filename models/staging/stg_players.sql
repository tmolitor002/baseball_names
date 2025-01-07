--stg_players

--TODO: cast data types

SELECT *
FROM {{ source('baseball', 'players') }}