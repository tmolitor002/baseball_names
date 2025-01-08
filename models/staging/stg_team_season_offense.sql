/*

Model:          stg_team_season_offense
Author:         Tom Molitor
Created:        1/6/2025
Last Modified:  1/7/2025

Description: Staging table to bring in raw offense data by team and season for futher analysis

+---------------------------------------------------------------------------------------------------------------------------+
| Change History                                                                                                            |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| Date      | Author        | Description                                                                                   |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/6/2025  | Tom Molitor   | Initalized model                                                                              |
+-----------+---------------+-----------------------------------------------------------------------------------------------+
| 1/7/2025  | Tom Molitor   | Cast fields as appropriate data type. Reorganized some fields for better readability          |
+-----------+---------------+-----------------------------------------------------------------------------------------------+

*/


SELECT 

    team_id
    , CAST(season                                   		AS INT) AS season
    , CAST(plate_appearances                        		AS INT) AS plate_appearances
    , CAST(at_bats                                  		AS INT) AS at_bats
    , CAST(hits                                     		AS INT) AS hits
    , CAST(singles                                  		AS INT) AS singles
    , CAST(doubles                                  		AS INT) AS doubles
    , CAST(triples                                  		AS INT) AS triples
    , CAST(home_runs                                		AS INT) AS home_runs
    , CAST(total_bases                              		AS INT) AS total_bases
    , CAST(strikeouts                               		AS INT) AS strikeouts
    , CAST(walks                                    		AS INT) AS walks
    , CAST(intentional_walks                        		AS INT) AS walks_intentional
    , CAST(hit_by_pitches                           		AS INT) AS hit_by_pitches
    , CAST(sacrifice_hits                           		AS INT) AS sacrifice_hits
    , CAST(sacrifice_flies                          		AS INT) AS sacrifice_flies
    , CAST(reached_on_errors                        		AS INT) AS reached_on_errors
    , CAST(reached_on_interferences                 		AS INT) AS reached_on_interferences
    , CAST(inside_the_park_home_runs                		AS INT) AS inside_the_park_home_runs
    , CAST(ground_rule_doubles                      		AS INT) AS ground_rule_doubles
    , CAST(infield_hits                             		AS INT) AS infield_hits
    , CAST(on_base_opportunities                    		AS INT) AS on_base_opportunities
    , CAST(on_base_successes                        		AS INT) AS on_base_successes
    , CAST(runs_batted_in                           		AS INT) AS runs_batted_in
    , CAST(grounded_into_double_plays                  		AS INT) AS double_play_grounded_into
    , CAST(double_plays                             		AS INT) AS double_plays
    , CAST(triple_plays                             		AS INT) AS triple_plays
    , CAST(batting_outs                             		AS INT) AS batting_outs
    , CAST(balls_in_play                            		AS INT) AS balls_in_play
    , CAST(balls_batted                             		AS INT) AS balls_batted
    , CAST(balls_in_play_while_running              		AS INT) AS balls_in_play_while_running
    , CAST(balls_in_play_while_on_base               		AS INT) AS balls_in_play_while_on_base
    , CAST(trajectory_fly_ball                      		AS INT) AS trajectory_fly_ball
    , CAST(trajectory_ground_ball                   		AS INT) AS trajectory_ground_ball
    , CAST(trajectory_line_drive                    		AS INT) AS trajectory_line_drive
    , CAST(trajectory_pop_up                        		AS INT) AS trajectory_pop_up
    , CAST(trajectory_unknown                       		AS INT) AS trajectory_unknown
    , CAST(trajectory_known                       		    AS INT) AS trajectory_known
    , CAST(trajectory_broad_air_ball                		AS INT) AS trajectory_broad_air_ball
    , CAST(trajectory_broad_ground_ball             		AS INT) AS trajectory_broad_ground_ball
    , CAST(trajectory_broad_unknown                 		AS INT) AS trajectory_broad_unknown
    , CAST(trajectory_broad_known                   		AS INT) AS trajectory_broad_known
    , CAST(bunts                                    		AS INT) AS bunts
    , CAST(batted_distance_plate                    		AS INT) AS batted_distance_plate
    , CAST(batted_distance_infield                  		AS INT) AS batted_distance_infield
    , CAST(batted_distance_outfield                 		AS INT) AS batted_distance_outfield
    , CAST(batted_distance_unknown                  		AS INT) AS batted_distance_unknown
    , CAST(batted_distance_known                    		AS INT) AS batted_distance_known
    , CAST(fielded_by_battery                       		AS INT) AS fielded_by_battery -- Number of plate appearances in which the ball was fielded by the pitcher or catcher
    , CAST(fielded_by_infielder                     		AS INT) AS fielded_by_infielder
    , CAST(fielded_by_outfielder                    		AS INT) AS fielded_by_outfielder
    , CAST(fielded_by_known                         		AS INT) AS fielded_by_known
    , CAST(fielded_by_unknown                       		AS INT) AS fielded_by_unknown
    , CAST(batted_angle_left                        		AS INT) AS batted_angle_left
    , CAST(batted_angle_right                       		AS INT) AS batted_angle_right
    , CAST(batted_angle_middle                      		AS INT) AS batted_angle_middle
    , CAST(batted_angle_unknown                     		AS INT) AS batted_angle_unknown
    , CAST(batted_angle_known                       		AS INT) AS batted_angle_known
    , CAST(batted_location_plate                    		AS INT) AS batted_location_plate
    , CAST(batted_location_right_infield            		AS INT) AS batted_location_right_infield
    , CAST(batted_location_middle_infield           		AS INT) AS batted_loaction_middle_infield
    , CAST(batted_location_left_infield             		AS INT) AS batted_location_left_infield
    , CAST(batted_location_left_infield             		AS INT) AS batted_location_left_field
    , CAST(batted_location_center_field             		AS INT) AS batted_location_center_field
    , CAST(batted_location_right_field              		AS INT) AS batted_location_right_field
    , CAST(batted_location_unknown                  		AS INT) AS batted_location_unknown
    , CAST(batted_location_unknown                  		AS INT) AS batted_location_known
    , CAST(batted_balls_pulled                      		AS INT) AS batted_balls_pulled
    , CAST(batted_balls_opposite_field              		AS INT) AS batted_balls_opposite_field
    , CAST(runs                                     		AS INT) AS runs
    , CAST(times_reached_base                       		AS INT) AS times_reached_base
    , CAST(stolen_bases                             		AS INT) AS stolen_bases
    , CAST(stolen_bases_second                      		AS INT) AS stolen_bases_second
    , CAST(stolen_bases_third                       		AS INT) AS stolen_bases_third
    , CAST(stolen_bases_home                        		AS INT) AS stolen_bases_home
    , CAST(caught_stealing                          		AS INT) AS caught_stealing
    , CAST(caught_stealing_second                   		AS INT) AS caught_stealing_second
    , CAST(caught_stealing_third                    		AS INT) AS caught_stealing_third
    , CAST(caught_stealing_home                     		AS INT) AS caught_stealing_home
    , CAST(stolen_base_opportunities                        AS INT) AS stolen_base_opportunities
    , CAST(stolen_base_opportunities_second                 AS INT) AS stolen_base_opportunities_second
    , CAST(stolen_base_opportunities_third                  AS INT) AS stolen_base_opportunities_third
    , CAST(stolen_base_opportunities_home                   AS INT) AS stolen_base_opportunities_home
    , CAST(picked_off                                       AS INT) AS picked_off
    , CAST(picked_off_first                                 AS INT) AS picked_off_first
    , CAST(picked_off_second                                AS INT) AS picked_off_second
    , CAST(picked_off_third                                 AS INT) AS picked_off_third
    , CAST(picked_off_caught_stealing                       AS INT) AS picked_off_caught_stealing
    , CAST(outs_on_basepaths                                AS INT) AS outs_on_basepaths
    , CAST(unforced_outs_on_basepaths                       AS INT) AS unforced_outs_on_basepaths
    , CAST(outs_avoided_on_errors                           AS INT) AS outs_avoided_on_erros
    , CAST(advances_on_wild_pitches                         AS INT) AS advances_on_wild_pitches
    , CAST(advances_on_passed_balls                         AS INT) AS advances_on_passed_balls
    , CAST(advances_on_balks                                AS INT) AS advances_on_balks
    , CAST(advances_on_unspecified_plays                    AS INT) AS advances_on_unspecified_plays
    , CAST(advances_on_defensive_indifference               AS INT) AS advances_on_defensive_indifference
    , CAST(advances_on_errors                               AS INT) AS advances_on_errors
    , CAST(plate_appearances_while_on_base                  AS INT) AS plate_appearances_while_on_base
    , CAST(batter_total_bases_while_running                 AS INT) AS batter_total_bases_while_running
    , CAST(batter_total_bases_while_on_base                AS INT) AS batter_total_bases_while_on_base
    , CAST(extra_base_advance_attempts                      AS INT) AS extra_base_advance_attempts
    , CAST(bases_advanced                                   AS INT) AS bases_advanced
    , CAST(surplus_bases_advanced_on_balls_in_play          AS INT) AS surplus_bases_advanced_on_balls_in_play
    , CAST(outs_on_extra_base_advance_attempts              AS INT) AS outs_on_extra_base_advance_attempts
    , CAST(hit_by_pitches                                   AS INT) AS pitches
    , CAST(swings                                           AS INT) AS swings
    , CAST(swings_with_contact                              AS INT) AS swings_with_contact
    , CAST(strikes                                          AS INT) AS strikes
    , CAST(strikes_called                                   AS INT) AS strikes_called
    , CAST(strikes_swinging                                 AS INT) AS strikes_swinging
    , CAST(strikes_foul                                     AS INT) AS strikes_foul
    , CAST(strikes_foul_tip                                 AS INT) AS strikes_foul_tip
    , CAST(strikes_in_play                                  AS INT) AS strikes_in_play
    , CAST(strikes_unknown                                  AS INT) AS strikes_unknown
    , CAST(balls                                            AS INT) AS balls
    , CAST(balls_called                                     AS INT) AS balls_called
    , CAST(balls_intentional                                AS INT) AS balls_intentional
    , CAST(balls_automatic                                  AS INT) AS balls_automatic
    , CAST(unknown_pitches                                  AS INT) AS unknown_pitches
    , CAST(pitchouts                                        AS INT) AS pitchouts
    , CAST(pitcher_pickoff_attempts                         AS INT) AS pickoff_attempt_pitcher
    , CAST(catcher_pickoff_attempts                         AS INT) AS pickoff_attempts_catcher
    , CAST(pitches_blocked_by_catcher                       AS INT) AS pitches_blocked_by_catcher
    , CAST(pitches_with_runners_going                       AS INT) AS pitches_with_runners_going
    , CAST(passed_balls                                     AS INT) AS passed_balls
    , CAST(wild_pitches                                     AS INT) AS wild_pitches
    , CAST(balks                                            AS INT) AS balks
    , CAST(left_on_base                                     AS INT) AS left_on_base
    , CAST(left_on_base_with_two_outs                       AS INT) AS left_on_base_with_two_outs
    , CAST(times_force_on_runner                            AS INT) AS times_force_on_runner
    , CAST(times_lead_runner                                AS INT) AS times_lead_runner
    , CAST(times_next_base_empty                            AS INT) AS times_next_base_empty
    , CAST(extra_base_chances                               AS INT) AS extra_base_chances
    , CAST(extra_bases_taken                                AS INT) AS extra_bases_taken
    , CAST(batting_average                                  AS FLOAT) AS batting_average
    , CAST(on_base_percentage                               AS FLOAT) AS on_base_percentage
    , CAST(slugging_percentage                              AS FLOAT) AS slugging_percentage
    , CAST(on_base_plus_slugging                            AS FLOAT) AS on_base_plus_slugging
    , CAST(isolated_power                                   AS FLOAT) AS isolated_power
    , CAST(secondary_average                                AS FLOAT) AS secondary_average
    , CAST(batting_average_on_balls_in_play                 AS FLOAT) AS batting_average_on_balls_in_play
    , CAST(home_run_rate                                    AS FLOAT) AS home_run_rate
    , CAST(walk_rate                                        AS FLOAT) AS walk_rate
    , CAST(strikeout_rate                                   AS FLOAT) AS strikeout_rate
    , CAST(stolen_base_percentage                           AS FLOAT) AS stolen_base_percentage
    , CAST(event_coverage_rate                              AS FLOAT) AS event_coverage_rate -- no description on baseball.computer docs
    , CAST(known_trajectory_rate_outs                       AS FLOAT) AS known_trajectory_rate_outs
    , CAST(known_trajectory_rate_hits                       AS FLOAT) AS known_trajectory_rate_hits
    , CAST(known_trajectory_rate                            AS FLOAT) AS known_trajectory_rate
    , CAST(known_trajectory_broad_rate_outs                 AS FLOAT) AS known_trajectory_broad_rate_outs
    , CAST(known_trajectory_broad_rate_hits                 AS FLOAT) AS known_trajectory_broad_rate_hits
    , CAST(known_trajectory_broad_rate                      AS FLOAT) AS known_trajectory_broad_rate
    , CAST(known_trajectory_out_hit_ratio                   AS FLOAT) AS known_trajectory_out_hit_ratio
    , CAST(known_trajectory_broad_out_hit_ratio             AS FLOAT) AS known_trajectory_broad_out_hit_ratio
    , CAST(air_ball_rate_outs                               AS FLOAT) AS air_ball_rate_outs
    , CAST(ground_ball_rate_outs                            AS FLOAT) AS ground_ball_rate_outs
    , CAST(ground_air_out_ratio                             AS FLOAT) AS ground_air_out_ratio
    , CAST(air_ball_hit_rate                                AS FLOAT) AS air_ball_hit_rate
    , CAST(ground_ball_hit_rate                             AS FLOAT) AS ground_ball_hit_rate
    , CAST(ground_air_hit_ratio                             AS FLOAT) AS ground_air_hit_ratio
    , CAST(fly_ball_rate                                    AS FLOAT) AS fly_ball_rate
    , CAST(line_drive_rate                                  AS FLOAT) AS line_drive_rate
    , CAST(pop_up_rate                                      AS FLOAT) AS pop_up_rate
    , CAST(ground_ball_rate                                 AS FLOAT) AS ground_ball_rate
    , CAST(coverage_weighted_air_ball_batting_average       AS FLOAT) AS coverage_weighted_air_ball_batting_average
    , CAST(coverage_weighted_ground_ball_batting_average    AS FLOAT) AS coverage_weighted_ground_ball_batting_average
    , CAST(coverage_weighted_fly_ball_batting_average       AS FLOAT) AS coverage_weighted_fly_ball_batting_average
    , CAST(coverage_weighted_line_drive_batting_average     AS FLOAT) AS coverage_weighted_line_drive_batting_average
    , CAST(coverage_weighted_pop_up_batting_average         AS FLOAT) AS coverage_weighted_pop_up_batting_average
    , CAST(known_angle_rate_outs                            AS FLOAT) AS known_angle_rate_outs
    , CAST(known_angle_rate_hits                            AS FLOAT) AS known_angle_rate_hits
    , CAST(known_angle_rate                                 AS FLOAT) AS known_angle_rate
    , CAST(known_angle_out_hit_ratio                        AS FLOAT) AS known_angle_out_hit_ratio
    , CAST(angle_left_rate_outs                             AS FLOAT) AS angle_left_rate_outs
    , CAST(angle_left_rate_hits                             AS FLOAT) AS angle_left_rate_hits
    , CAST(angle_left_rate                                  AS FLOAT) AS angle_left_rate
    , CAST(coverage_weighted_angle_left_batting_average     AS FLOAT) AS coverage_weighted_angle_left_batting_average
    , CAST(angle_right_rate_outs                            AS FLOAT) AS angle_right_rate_outs
    , CAST(angle_right_rate_hits                            AS FLOAT) AS angle_right_rate_hits
    , CAST(angle_right_rate                                 AS FLOAT) AS angle_right_rate
    , CAST(coverage_weighted_angle_right_batting_average    AS FLOAT) AS coverage_weighted_angle_right_batting_average
    , CAST(angle_middle_rate_outs                           AS FLOAT) AS angle_middle_rate_outs
    , CAST(angle_middle_rate_hits                           AS FLOAT) AS angle_middle_rate_hits
    , CAST(angle_middle_rate                                AS FLOAT) AS angle_middle_rate
    , CAST(coverage_weighted_angle_middle_batting_average   AS FLOAT) AS coverage_weighted_angle_middle_batting_average
    , CAST(pulled_rate_outs                                 AS FLOAT) AS pulled_rate_outs
    , CAST(pulled_rate_hits                                 AS FLOAT) AS pulled_rate_hits
    , CAST(pulled_rate                                      AS FLOAT) AS pulled_rate
    , CAST(coverage_weighted_pulled_batting_average         AS FLOAT) AS coverage_weighted_pulled_batting_average
    , CAST(opposite_field_rate_outs                         AS FLOAT) AS opposite_field_rate_outs
    , CAST(opposite_field_rate_hits                         AS FLOAT) AS opposite_field_rate_hits
    , CAST(opposite_field_rate                              AS FLOAT) AS opposite_field_rate
    , CAST(coverage_weighted_opposite_field_batting_average AS FLOAT) AS coverage_weighted_opposite_field_batting_average
    , CAST(stolen_base_attempt_rate_second                  AS FLOAT) AS stolen_base_attempt_rate_second
    , CAST(stolen_base_attempt_rate_third                   AS FLOAT) AS stolen_base_attempt_rate_third
    , CAST(stolen_base_attempt_rate_home                    AS FLOAT) AS stolen_base_attempt_rate_home
    , CAST(unforced_out_rate                                AS FLOAT) AS unforced_out_rate
    , CAST(pitch_strike_rate                                AS FLOAT) AS pitch_strike_rate
    , CAST(pitch_contact_rate                               AS FLOAT) AS pitch_contact_rate
    , CAST(pitch_swing_rate                                 AS FLOAT) AS pitch_swing_rate
    , CAST(pitch_ball_rate                                  AS FLOAT) AS pitch_ball_rate
    , CAST(pitch_swing_and_miss_rate                        AS FLOAT) AS pitch_swing_and_miss_rate
    , CAST(pitch_foul_rate                                  AS FLOAT) AS pitch_foul_rate
    , CAST(pitched_called_strike_rate                       AS FLOAT) AS pitched_called_strike_rate
    , CAST(pitch_data_coverage_rate                         AS FLOAT) AS pitch_data_coverage_rate

FROM {{ source('baseball', 'team_season_offense') }}