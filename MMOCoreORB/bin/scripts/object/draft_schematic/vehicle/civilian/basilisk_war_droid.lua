object_draft_schematic_vehicle_civilian_basilisk_war_droid = object_draft_schematic_vehicle_civilian_shared_basilisk_war_droid:new {

	templateType = DRAFTSCHEMATIC,

	customObjectName = "Basilisk War Droid",

	craftingToolTab = 16, -- (See DraftSchematicObjectTemplate.h)
	complexity = 1,
	size = 1,
	factoryCrateSize = 0,

	xpType = "crafting_general",
	xp = 1600,

	assemblySkill = "general_assembly",
	experimentingSkill = "general_experimentation",
	customizationSkill = "clothing_customization",

	customizationOptions = {},
	customizationStringNames = {},
	customizationDefaults = {},

	ingredientTemplateNames = {"craft_vehicle_ingredients_n", "craft_vehicle_ingredients_n", "craft_vehicle_ingredients_n", "craft_vehicle_ingredients_n", "craft_vehicle_ingredients_n", "craft_vehicle_ingredients_n"},
	ingredientTitleNames = {"vehicle_body", "structural_frame", "stabilizor_subframe", "avionic_subassembly", "repulsor_assembly", "cockpit_fitout"},
	ingredientSlotType = {0, 0, 0, 0, 0, 0},
	resourceTypes = {"aluminum", "metal_ferrous", "steel", "aluminum", "fiberplast", "steel_carbonite"},
	resourceQuantities = {2500, 3000, 1000, 900, 700, 1200},
	contribution = {100, 100, 100, 100, 100, 100},

	targetTemplate = "object/tangible/deed/vehicle_deed/basilisk_war_droid.iff",

	additionalTemplates = {}
}
ObjectTemplates:addTemplate(object_draft_schematic_vehicle_civilian_basilisk_war_droid, "object/draft_schematic/vehicle/civilian/basilisk_war_droid.iff")
