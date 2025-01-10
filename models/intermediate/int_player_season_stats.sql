/*

Model:          int_player_season_stats
Author:         Tom Molitor
Created:        1/9/2025
Last Modified:  1/9/2025

Description: Staging table to create player stats by season


+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/9/2025  | Tom Molitor   | Initalized model to create basic stats for players by season                                  |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

TODO:
*/

-- Get applicable season stats for each player
SELECT

    player_id
    , season
    , plate_appearances
    , at_bats
    , singles
    , doubles
    , triples
    , home_runs
    , walks -- includes intentional
    , intentional_walks
    , walks - intentional_walks AS unintentional_walks
    , hit_by_pitches
    , sacrifice_flies


FROM {{ ref("stg_player_season_league_offense") }}
-- Can only calculate for seasons where constants are available