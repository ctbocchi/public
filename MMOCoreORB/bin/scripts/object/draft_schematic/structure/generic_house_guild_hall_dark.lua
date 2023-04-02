
object_draft_schematic_structure_generic_house_guild_hall_dark = object_draft_schematic_structure_shared_generic_house_guild_hall_dark:new {

	templateType = DRAFTSCHEMATIC,

	customObjectName = "Deed for: Generic Planet Guild Hall [Dark]",

	craftingToolTab = 1024, -- (See DraftSchematicObjectTemplate.h)
	complexity = 1,
	size = 14,
	factoryCrateSize = 5000,

	xpType = "crafting_structure_general",
	xp = 7800,

	assemblySkill = "structure_assembly",
	experimentingSkill = "structure_experimentation",
	customizationSkill = "structure_customization",

	customizationOptions = {},
	customizationStringNames = {},
	customizationDefaults = {},

	ingredientTemplateNames = {"craft_structure_ingredients_n", "craft_structure_ingredients_n", "craft_structure_ingredients_n", "craft_structure_ingredients_n", "craft_structure_ingredients_n", "craft_structure_ingredients_n"},
	ingredientTitleNames = {"load_bearing_structure_and_shell", "insulation_and_covering", "foundation", "wall_sections", "power_supply_unit", "storage_space"},
	ingredientSlotType = {0, 0, 0, 2, 1, 1},
	resourceTypes = {"metal", "ore", "ore", "object/tangible/component/structure/shared_wall_module.iff", "object/tangible/component/structure/shared_power_core_unit.iff", "object/tangible/component/structure/shared_structure_storage_section.iff"},
	resourceQuantities = {1250, 2250, 400, 17, 3, 8},
	contribution = {100, 100, 100, 100, 100, 100},

	targetTemplate = "object/tangible/deed/guild_deed/generic_guild_deed_dark.iff",

	additionalTemplates = {}
}
ObjectTemplates:addTemplate(object_draft_schematic_structure_generic_house_guild_hall_dark, "object/draft_schematic/structure/generic_house_guild_hall_dark.iff")
