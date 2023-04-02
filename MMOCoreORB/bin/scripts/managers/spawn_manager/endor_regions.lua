-- Planet Region Definitions
--
-- {"regionName", x, y, shape and size, tier, {"spawnGroup1", ...}, maxSpawnLimit}
-- For circle and ring, x and y are the center point
-- For rectangles, x and y are the bottom left corner. x2 and y2 (see below) are the upper right corner
-- Shape and size is a table with the following format depending on the shape of the area:
--   - Circle: {CIRCLE, radius}
--   - Rectangle: {RECTANGLE, x2, y2}
--   - Ring: {RING, inner radius, outer radius}
-- Tier is a bit mask with the following possible values where each hexadecimal position is one possible configuration.
-- That means that it is not possible to have both a spawn area and a no spawn area in the same region, but
-- a spawn area that is also a no build zone is possible.

require("scripts.managers.spawn_manager.regions")

endor_regions = {
	{"an_outpost", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"awning_with_pillars", 278, 3829, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"battle_of_endor", 753, 883, {CIRCLE, 192}, NOSPAWNAREA + NOBUILDZONEAREA}, 
	{"central_desert", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"central_forest", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"central_peak", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"coa_imperial_outpost", -1953, 1052, {CIRCLE, 60}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"coa_rebel_outpost", 4008, 2985, {CIRCLE, 60}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"death_watch_bunker", -4655, 4330, {CIRCLE, 256}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"desert_one", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"desert_two", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"dulok_village_1", 6066, -2472, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"dulok_village_2", -1206, 2963, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"eastern_desert", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"eastern_mountains", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"elevated_hut", -1770, -4090, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"endor_neutral_outpost", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"endor_smuggler_outpost", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"ewok_hut", 3879, 4211, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"ewok_lake_village_1", 1453, -3256, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"ewok_lake_village_2", -590, -5054, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"ewok_village_tree_1", 83, 42, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"ewok_village_tree_2", 4540, -2420, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"fersal_hills", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"forest_five", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"forest_four", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"forest_one", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"forest_six", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"forest_three", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"forest_two", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_bordok_nw", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_bordok_sw", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_desert_marauder_ne", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_gorax_sw", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_mantigrue_nw", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_mantigrue_se", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_remmer_nw", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hard_remmer_se", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"hot_springs", 2372, 2182, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"hut", -1800, 6023, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"huts_and_campfire", -1538, -6013, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"imperial_ruins", 2318, 5860, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"jiberah_plains_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"jiberah_plains_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"jiberah_plains_3", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"jiberah_plains_4", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"jiberah_plains_5", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"jinda_ritualists_cave", -1727, 121, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"korga_cave", 2163, 3617, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"life_day_home", -1088, -996, {CIRCLE, 100}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"marauder_mountain_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"marauder_mountain_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"marauder_mountain_3", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"marauders_stronghold", -4648, -2273, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"medium_blurrg_sw", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"medium_bolma_ne", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"medium_bolma_se", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"medium_lantern_bird_ne", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mertune_forest_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mertune_forest_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mon_teithtim_forest_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mon_teithtim_forest_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mountain_four", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mountain_one", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mountain_three", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"mountain_two", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"noragg_place_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"northeast_plains", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"northern_mountains", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"northern_peak", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"northwest_plains", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"nub_shanda", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"oniantae_hills_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"oniantae_hills_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"oniantae_hills_3", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"orphaned_marauder_cave", -7021, 653, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"peak_four", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"peak_one", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"peak_three", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"peak_two", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"plains_four", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"plains_one", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"plains_three", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"plains_two", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"pole_with_boxes", -3653, 6125, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"salma_desert_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"salma_desert_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"salma_desert_3", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"salma_desert_4", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"salma_desert_5", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"skeleton_hut", 267, -1444, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"southeast_forest", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"southeast_peak", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"southwest_peak", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"stone_village", 3924, 5787, {CIRCLE, 75}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"three_huts", 2047, 4316, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"tree_stand", -1876, -1474, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"western_mountains", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"world_spawner", 0, 0, {CIRCLE, -1}, SPAWNAREA + WORLDSPAWNAREA, {"endor_world", "global_hard"}, 2048},
	{"yawari_cliffs_1", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_10", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_11", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_12", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_13", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_14", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_15", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_16", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_17", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_18", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_2", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_3", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_4", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_5", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_6", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_7", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_8", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	{"yawari_cliffs_9", 0, 0, {CIRCLE, 0}, UNDEFINEDAREA},
	-- custom
	{"rikers_island", -7038, -7038, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
}
