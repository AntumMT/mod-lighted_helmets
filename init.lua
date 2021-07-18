
if core.global_exists("armor") then
	local helmets = {
		["3d_armor"] = {
			"bronze",
			"cactus",
			"crystal",
			"diamond",
			"gold",
			"mithril",
			"steel",
			"wood",
		},
	}

	for modname, materials in pairs(helmets) do
		for _, material in ipairs(materials) do
			local lvalue
			if type(material) == "table" then
				lvalue = material[2]
				material = material[1]
			end

			local orig_name = modname .. ":helmet_" .. material
			local orig_def = core.registered_items[orig_name]
			if orig_def then
				local def = table.copy(orig_def)

				def.description = def.description .. " with light"
				def.inventory_image = "lighted_helmets_inv_underlay.png^" .. orig_def.inventory_image
				if not def.texture then
					def.texture = "3d_armor_helmet_" .. material .. ".png"
				end
				if not def.wield_image then
					def.wield_image = orig_def.inventory_image
				end
				def.preview = modname .. "_helmet_" .. material .. "_preview.png"

				local helmet_name = "lighted_helmets:" .. material
				armor:register_armor(":" .. helmet_name, def)
				armor_light.register(helmet_name, lvalue)

				if core.registered_items["default:mese_crystal"] and core.registered_items["default:torch"] then
					core.register_craft({
						output = helmet_name,
						recipe = {
							{"default:torch"},
							{"default:mese_crystal"},
							{orig_name},
						},
					})
				end
			end
		end
	end
end
