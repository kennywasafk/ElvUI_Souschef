local E, L, V, P, G = unpack(ElvUI);
local SousUI = E:GetModule('Souschef');

function SousUI:LoadDetailsProfile(layout)
	local font, fontsize
	font = "Expressway"
	fontsize = 11
	
	_detalhes_global["__profiles"]['Souschef'] = {
		["capture_real"] = {
			["heal"] = true,
			["spellcast"] = true,
			["miscdata"] = true,
			["aura"] = true,
			["energy"] = true,
			["damage"] = true,
		},
		["row_fade_in"] = {
			"in", -- [1]
			0.2, -- [2]
		},
		["player_details_window"] = {
			["scale"] = 1,
			["skin"] = "ElvUI",
			["bar_texture"] = "Skyline",
		},
		["all_players_are_group"] = false,
		["use_row_animations"] = true,
		["report_heal_links"] = false,
		["windows_fade_out"] = {
			"out", -- [1]
			0.2, -- [2]
		},
		["event_tracker"] = {
			["enabled"] = false,
			["font_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["line_height"] = 16,
			["line_color"] = {
				0.1, -- [1]
				0.1, -- [2]
				0.1, -- [3]
				0.3, -- [4]
			},
			["font_shadow"] = "NONE",
			["font_size"] = 10,
			["font_face"] = "Friz Quadrata TT",
			["frame"] = {
				["show_title"] = true,
				["strata"] = "LOW",
				["backdrop_color"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					0.2, -- [4]
				},
				["locked"] = false,
				["height"] = 300,
				["width"] = 250,
			},
			["line_texture"] = "Details Serenity",
			["options_frame"] = {
			},
		},
		["report_to_who"] = "",
		["class_specs_coords"] = {
			[62] = {
				0.251953125, -- [1]
				0.375, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[63] = {
				0.375, -- [1]
				0.5, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[250] = {
				0, -- [1]
				0.125, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[251] = {
				0.125, -- [1]
				0.25, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[252] = {
				0.25, -- [1]
				0.375, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[253] = {
				0.875, -- [1]
				1, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[254] = {
				0, -- [1]
				0.125, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[255] = {
				0.125, -- [1]
				0.25, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[66] = {
				0.125, -- [1]
				0.25, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[257] = {
				0.5, -- [1]
				0.625, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[258] = {
				0.6328125, -- [1]
				0.75, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[259] = {
				0.75, -- [1]
				0.875, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[260] = {
				0.875, -- [1]
				1, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[577] = {
				0.25, -- [1]
				0.375, -- [2]
				0.5, -- [3]
				0.625, -- [4]
			},
			[262] = {
				0.125, -- [1]
				0.25, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[581] = {
				0.375, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.625, -- [4]
			},
			[264] = {
				0.375, -- [1]
				0.5, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[265] = {
				0.5, -- [1]
				0.625, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[266] = {
				0.625, -- [1]
				0.75, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[267] = {
				0.75, -- [1]
				0.875, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[268] = {
				0.625, -- [1]
				0.75, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[269] = {
				0.875, -- [1]
				1, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[270] = {
				0.75, -- [1]
				0.875, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[70] = {
				0.251953125, -- [1]
				0.375, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[102] = {
				0.375, -- [1]
				0.5, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[71] = {
				0.875, -- [1]
				1, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[103] = {
				0.5, -- [1]
				0.625, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[72] = {
				0, -- [1]
				0.125, -- [2]
				0.5, -- [3]
				0.625, -- [4]
			},
			[104] = {
				0.625, -- [1]
				0.75, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[73] = {
				0.125, -- [1]
				0.25, -- [2]
				0.5, -- [3]
				0.625, -- [4]
			},
			[64] = {
				0.5, -- [1]
				0.625, -- [2]
				0.125, -- [3]
				0.25, -- [4]
			},
			[105] = {
				0.75, -- [1]
				0.875, -- [2]
				0, -- [3]
				0.125, -- [4]
			},
			[65] = {
				0, -- [1]
				0.125, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[256] = {
				0.375, -- [1]
				0.5, -- [2]
				0.25, -- [3]
				0.375, -- [4]
			},
			[261] = {
				0, -- [1]
				0.125, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
			[263] = {
				0.25, -- [1]
				0.375, -- [2]
				0.375, -- [3]
				0.5, -- [4]
			},
		},
		["profile_save_pos"] = true,
		["tooltip"] = {
			["header_statusbar"] = {
				0.3, -- [1]
				0.3, -- [2]
				0.3, -- [3]
				0.8, -- [4]
				false, -- [5]
				false, -- [6]
				"WorldState Score", -- [7]
			},
			["fontcolor_right"] = {
				1, -- [1]
				0.7, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["tooltip_max_targets"] = 2,
			["icon_size"] = {
				["W"] = 13,
				["H"] = 13,
			},
			["tooltip_max_pets"] = 2,
			["anchor_relative"] = "bottomleft",
			["abbreviation"] = 2,
			["anchored_to"] = 2,
			["show_amount"] = false,
			["header_text_color"] = {
				1, -- [1]
				0.9176, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fontsize"] = 12,
			["background"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.300000011920929, -- [4]
			},
			["submenu_wallpaper"] = false,
			["fontsize_title"] = 10,
			["fontcolor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["commands"] = {
			},
			["tooltip_max_abilities"] = 6,
			["fontface"] = "Expressway",
			["border_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["border_texture"] = "Blizzard Tooltip",
			["anchor_offset"] = {
				0, -- [1]
				-7, -- [2]
			},
			["menus_bg_texture"] = "Interface\\SPELLBOOK\\Spellbook-Page-1",
			["maximize_method"] = 1,
			["border_size"] = 16,
			["fontshadow"] = true,
			["anchor_screen_pos"] = {
				887.000122070313, -- [1]
				-419.00008392334, -- [2]
			},
			["anchor_point"] = "bottom",
			["menus_bg_coords"] = {
				0.31, -- [1]
				0.924000015258789, -- [2]
				0.213000011444092, -- [3]
				0.279000015258789, -- [4]
			},
			["icon_border_texcoord"] = {
				["R"] = 0.921875,
				["L"] = 0.078125,
				["T"] = 0.078125,
				["B"] = 0.921875,
			},
			["menus_bg_color"] = {
				0.799998223781586, -- [1]
				0.799998223781586, -- [2]
				0.799998223781586, -- [3]
				0.200000017881393, -- [4]
			},
		},
		["ps_abbreviation"] = 3,
		["world_combat_is_trash"] = true,
		["pvp_as_group"] = true,
		["animation_speed_mintravel"] = 0.45,
		["track_item_level"] = false,
		["windows_fade_in"] = {
			"in", -- [1]
			0.2, -- [2]
		},
		["instances_menu_click_to_open"] = true,
		["overall_clear_newchallenge"] = true,
		["current_dps_meter"] = {
			["enabled"] = false,
			["font_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["arena_enabled"] = true,
			["font_shadow"] = "NONE",
			["font_size"] = 18,
			["mythic_dungeon_enabled"] = true,
			["sample_size"] = 5,
			["font_face"] = "Friz Quadrata TT",
			["frame"] = {
				["show_title"] = false,
				["strata"] = "LOW",
				["backdrop_color"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					0.2, -- [4]
				},
				["locked"] = false,
				["height"] = 65,
				["width"] = 220,
			},
			["update_interval"] = 0.1,
			["options_frame"] = {
			},
		},
		["instances_disable_bar_highlight"] = true,
		["trash_concatenate"] = false,
		["animation_speed"] = 33,
		["disable_stretch_from_toolbar"] = false,
		["disable_lock_ungroup_buttons"] = false,
		["memory_ram"] = 64,
		["disable_window_groups"] = true,
		["instances_suppress_trash"] = 0,
		["animation_speed_maxtravel"] = 3,
		["streamer_config"] = {
			["faster_updates"] = false,
			["quick_detection"] = false,
			["reset_spec_cache"] = false,
			["no_alerts"] = false,
			["use_animation_accel"] = true,
			["disable_mythic_dungeon"] = false,
		},
		["font_faces"] = {
			["menus"] = "HaxrCorp12cyr",
		},
		["default_bg_alpha"] = 0.5,
		["memory_threshold"] = 3,
		["time_type"] = 2,
		["instances"] = {
			{
				["__pos"] = {
					["normal"] = {
						["y"] = -486.999938964844,
						["x"] = 863,
						["w"] = 192.000122070313,
						["h"] = 106,
					},
					["solo"] = {
						["y"] = 2,
						["x"] = 1,
						["w"] = 300,
						["h"] = 200,
					},
				},
				["show_statusbar"] = false,
				["backdrop_texture"] = "ElvUI Blank",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0, -- [4]
				},
				["menu_anchor"] = {
					16, -- [1]
					4, -- [2]
					["side"] = 2,
				},
				["__snapV"] = false,
				["__snapH"] = false,
				["bg_r"] = 0,
				["menu_anchor_down"] = {
					16, -- [1]
					-2, -- [2]
				},
				["row_show_animation"] = {
					["anim"] = "Fade",
					["options"] = {
					},
				},
				["hide_out_of_combat"] = false,
				["__was_opened"] = true,
				["following"] = {
					["enabled"] = true,
					["bar_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
				["color_buttons"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["switch_healer"] = false,
				["bars_sort_direction"] = 2,
				["bars_grow_direction"] = 2,
				["skin_custom"] = "",
				["stretch_button_side"] = 2,
				["switch_damager_in_combat"] = {
					1, -- [1]
					2, -- [2]
					2, -- [3]
				},
				["tooltip"] = {
					["n_abilities"] = 3,
					["n_enemies"] = 3,
				},
				["StatusBarSaved"] = {
					["center"] = "DETAILS_STATUSBAR_PLUGIN_CLOCK",
					["right"] = "DETAILS_STATUSBAR_PLUGIN_PDPS",
					["options"] = {
						["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
							["textColor"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["textXMod"] = 0,
							["textFace"] = "Accidental Presidency",
							["textStyle"] = 2,
							["textAlign"] = 0,
							["textSize"] = 10,
							["textYMod"] = 1,
						},
						["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
							["textColor"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["segmentType"] = 2,
							["textXMod"] = 0,
							["textFace"] = "Accidental Presidency",
							["textAlign"] = 0,
							["textStyle"] = 2,
							["textSize"] = 10,
							["textYMod"] = 1,
						},
						["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
							["textColor"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["timeType"] = 1,
							["textXMod"] = 6,
							["textAlign"] = 0,
							["textFace"] = "Accidental Presidency",
							["textStyle"] = 2,
							["textSize"] = 10,
							["textYMod"] = 1,
						},
					},
					["left"] = "DETAILS_STATUSBAR_PLUGIN_PSEGMENT",
				},
				["skin"] = "ElvUI Frame Style",
				["switch_all_roles_in_combat"] = false,
				["switch_tank_in_combat"] = false,
				["version"] = 3,
				["row_info"] = {
					["textR_outline"] = false,
					["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
					["textL_outline"] = false,
					["textR_outline_small"] = true,
					["textL_outline_small"] = true,
					["percent_type"] = 1,
					["fixed_text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["space"] = {
						["right"] = -2,
						["left"] = 1,
						["between"] = 1,
					},
					["texture_background_class_color"] = false,
					["textL_outline_small_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["font_face_file"] = "Interface\\AddOns\\ElvUI\\media\\fonts\\Expressway.ttf",
					["textL_custom_text"] = "{data1}. {data3}{data2}",
					["font_size"] = 12,
					["texture_custom_file"] = "Interface\\",
					["texture_file"] = "Interface\\AddOns\\DSM\\Media\\StatusBars\\Flatt",
					["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small_alpha",
					["use_spec_icons"] = true,
					["textR_bracket"] = "[",
					["texture_background_file"] = "Interface\\BUTTONS\\WHITE8X8.blp",
					["texture_custom"] = "",
					["models"] = {
						["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
						["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
						["upper_alpha"] = 0.5,
						["lower_enabled"] = false,
						["lower_alpha"] = 0.1,
						["upper_enabled"] = false,
					},
					["fixed_texture_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
					},
					["textL_show_number"] = true,
					["start_after_icon"] = true,
					["textR_enable_custom_text"] = false,
					["textR_custom_text"] = "{data1} ({data2}, {data3}%)",
					["texture"] = "Flatt",
					["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
					["textL_enable_custom_text"] = false,
					["textR_show_data"] = {
						true, -- [1]
						true, -- [2]
						false, -- [3]
					},
					["texture_background"] = "ElvUI Blank",
					["alpha"] = 0.8,
					["textR_class_colors"] = false,
					["textR_outline_small_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["no_icon"] = false,
					["textL_class_colors"] = false,
					["backdrop"] = {
						["enabled"] = true,
						["texture"] = "1 Pixel",
						["color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["size"] = 1,
					},
					["font_face"] = "Expressway",
					["texture_class_colors"] = true,
					["fixed_texture_background_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.389999985694885, -- [4]
					},
					["fast_ps_update"] = true,
					["textR_separator"] = "NONE",
					["height"] = 20,
				},
				["__locked"] = true,
				["menu_alpha"] = {
					["enabled"] = false,
					["onleave"] = 1,
					["ignorebars"] = false,
					["iconstoo"] = true,
					["onenter"] = 1,
				},
				["libwindow"] = {
					["y"] = 0,
					["x"] = -0.9998779296875,
					["point"] = "BOTTOMRIGHT",
				},
				["switch_healer_in_combat"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
				},
				["bg_alpha"] = 0,
				["strata"] = "BACKGROUND",
				["instance_button_anchor"] = {
					-27, -- [1]
					1, -- [2]
				},
				["__snap"] = {
				},
				["ignore_mass_showhide"] = false,
				["hide_in_combat_alpha"] = 0,
				["plugins_grow_direction"] = 1,
				["menu_icons"] = {
					true, -- [1]
					true, -- [2]
					false, -- [3]
					true, -- [4]
					true, -- [5]
					false, -- [6]
					["space"] = 3,
					["shadow"] = true,
				},
				["switch_damager"] = false,
				["show_sidebars"] = true,
				["statusbar_info"] = {
					["alpha"] = 0,
					["overlay"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
				["window_scale"] = 1,
				["micro_displays_side"] = 2,
				["attribute_text"] = {
					["enabled"] = false,
					["shadow"] = true,
					["side"] = 1,
					["text_size"] = 12,
					["custom_text"] = "{name}",
					["text_face"] = "FORCED SQUARE",
					["anchor"] = {
						-20, -- [1]
						5, -- [2]
					},
					["show_timer"] = {
						true, -- [1]
						true, -- [2]
						true, -- [3]
					},
					["enable_custom_text"] = false,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.7, -- [4]
					},
				},
				["switch_all_roles_after_wipe"] = false,
				["grab_on_top"] = false,
				["switch_tank"] = false,
				["micro_displays_locked"] = true,
				["auto_current"] = true,
				["toolbar_side"] = 1,
				["bg_g"] = 0,
				["auto_hide_menu"] = {
					["left"] = true,
					["right"] = false,
				},
				["hide_in_combat"] = false,
				["posicao"] = {
					["normal"] = {
						["y"] = -486.999938964844,
						["x"] = 863,
						["w"] = 192.000122070313,
						["h"] = 106,
					},
					["solo"] = {
						["y"] = 2,
						["x"] = 1,
						["w"] = 300,
						["h"] = 200,
					},
				},
				["hide_in_combat_type"] = 1,
				["menu_icons_size"] = 1,
				["wallpaper"] = {
					["enabled"] = false,
					["width"] = 266.000061035156,
					["texcoord"] = {
						0.0480000019073486, -- [1]
						0.298000011444092, -- [2]
						0.630999984741211, -- [3]
						0.755999984741211, -- [4]
					},
					["overlay"] = {
						0.999997794628143, -- [1]
						0.999997794628143, -- [2]
						0.999997794628143, -- [3]
						0.799998223781586, -- [4]
					},
					["anchor"] = "all",
					["height"] = 225.999984741211,
					["alpha"] = 0.800000071525574,
					["texture"] = "Interface\\AddOns\\Details\\images\\skins\\elvui",
				},
				["total_bar"] = {
					["enabled"] = false,
					["only_in_group"] = false,
					["icon"] = "INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK",
					["color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
				["desaturated_menu"] = true,
				["hide_icon"] = true,
				["bars_inverted"] = false,
				["bg_b"] = 0,
			}, -- [1]
			{
				["__pos"] = {
					["normal"] = {
						["y"] = -486.999938964844,
						["x"] = 666.999755859375,
						["w"] = 198.000183105469,
						["h"] = 106,
					},
					["solo"] = {
						["y"] = 2,
						["x"] = 1,
						["w"] = 300,
						["h"] = 200,
					},
				},
				["hide_in_combat_type"] = 5,
				["menu_icons_size"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0, -- [4]
				},
				["menu_anchor"] = {
					16, -- [1]
					4, -- [2]
					["side"] = 2,
				},
				["__snapV"] = false,
				["__snapH"] = false,
				["bg_r"] = 0,
				["row_show_animation"] = {
					["anim"] = "Fade",
					["options"] = {
					},
				},
				["show_sidebars"] = true,
				["hide_out_of_combat"] = false,
				["__was_opened"] = true,
				["following"] = {
					["bar_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["enabled"] = true,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
				["color_buttons"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["switch_healer"] = false,
				["micro_displays_locked"] = true,
				["bars_sort_direction"] = 2,
				["ignore_mass_showhide"] = false,
				["bars_grow_direction"] = 2,
				["menu_anchor_down"] = {
					16, -- [1]
					-2, -- [2]
				},
				["tooltip"] = {
					["n_abilities"] = 3,
					["n_enemies"] = 3,
				},
				["StatusBarSaved"] = {
					["center"] = "DETAILS_STATUSBAR_PLUGIN_CLOCK",
					["right"] = "DETAILS_STATUSBAR_PLUGIN_PDPS",
					["options"] = {
						["DETAILS_STATUSBAR_PLUGIN_PDPS"] = {
							["textColor"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["textXMod"] = 0,
							["textFace"] = "Accidental Presidency",
							["textStyle"] = 2,
							["textAlign"] = 0,
							["textSize"] = 10,
							["textYMod"] = 1,
						},
						["DETAILS_STATUSBAR_PLUGIN_PSEGMENT"] = {
							["textColor"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["segmentType"] = 2,
							["textXMod"] = 0,
							["textFace"] = "Accidental Presidency",
							["textAlign"] = 0,
							["textStyle"] = 2,
							["textSize"] = 10,
							["textYMod"] = 1,
						},
						["DETAILS_STATUSBAR_PLUGIN_CLOCK"] = {
							["textColor"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["textStyle"] = 2,
							["textFace"] = "Accidental Presidency",
							["textAlign"] = 0,
							["textXMod"] = 6,
							["timeType"] = 1,
							["textSize"] = 10,
							["textYMod"] = 1,
						},
					},
					["left"] = "DETAILS_STATUSBAR_PLUGIN_PSEGMENT",
				},
				["total_bar"] = {
					["enabled"] = false,
					["only_in_group"] = false,
					["icon"] = "INTERFACE\\ICONS\\INV_MISC_QUESTIONMARK",
					["color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
				["switch_all_roles_in_combat"] = false,
				["instance_button_anchor"] = {
					-27, -- [1]
					1, -- [2]
				},
				["version"] = 3,
				["row_info"] = {
					["textR_outline"] = false,
					["spec_file"] = "Interface\\AddOns\\Details\\images\\spec_icons_normal",
					["textL_outline"] = false,
					["texture_highlight"] = "Interface\\FriendsFrame\\UI-FriendsList-Highlight",
					["textR_show_data"] = {
						true, -- [1]
						true, -- [2]
						false, -- [3]
					},
					["percent_type"] = 1,
					["fixed_text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
					["space"] = {
						["right"] = -2,
						["left"] = 1,
						["between"] = 1,
					},
					["texture_background_class_color"] = false,
					["textL_outline_small_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["font_face_file"] = "Interface\\AddOns\\ElvUI\\media\\fonts\\Expressway.ttf",
					["textL_custom_text"] = "{data1}. {data3}{data2}",
					["models"] = {
						["upper_model"] = "Spells\\AcidBreath_SuperGreen.M2",
						["lower_model"] = "World\\EXPANSION02\\DOODADS\\Coldarra\\COLDARRALOCUS.m2",
						["upper_alpha"] = 0.5,
						["lower_enabled"] = false,
						["lower_alpha"] = 0.1,
						["upper_enabled"] = false,
					},
					["texture_custom_file"] = "Interface\\",
					["texture_file"] = "Interface\\AddOns\\DSM\\Media\\StatusBars\\Flatt",
					["icon_file"] = "Interface\\AddOns\\Details\\images\\classes_small_alpha",
					["height"] = 20,
					["texture_background_file"] = "Interface\\BUTTONS\\WHITE8X8.blp",
					["use_spec_icons"] = true,
					["texture_custom"] = "",
					["font_size"] = 12,
					["fixed_texture_color"] = {
						0.701960784313726, -- [1]
						0.701960784313726, -- [2]
						0.701960784313726, -- [3]
						1, -- [4]
					},
					["textL_show_number"] = true,
					["textL_outline_small"] = true,
					["textR_enable_custom_text"] = false,
					["textR_custom_text"] = "{data1} ({data2}, {data3}%)",
					["texture"] = "Flatt",
					["textR_outline_small"] = true,
					["start_after_icon"] = true,
					["textL_class_colors"] = true,
					["textR_class_colors"] = false,
					["textR_outline_small_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["texture_background"] = "ElvUI Blank",
					["alpha"] = 1,
					["no_icon"] = false,
					["backdrop"] = {
						["enabled"] = true,
						["size"] = 1,
						["color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["texture"] = "1 Pixel",
					},
					["textL_enable_custom_text"] = false,
					["font_face"] = "Expressway",
					["texture_class_colors"] = false,
					["fixed_texture_background_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.389999985694885, -- [4]
					},
					["fast_ps_update"] = true,
					["textR_separator"] = "NONE",
					["textR_bracket"] = "[",
				},
				["__locked"] = true,
				["menu_alpha"] = {
					["enabled"] = false,
					["onenter"] = 1,
					["iconstoo"] = true,
					["ignorebars"] = false,
					["onleave"] = 1,
				},
				["show_statusbar"] = false,
				["switch_tank_in_combat"] = false,
				["switch_damager_in_combat"] = false,
				["strata"] = "BACKGROUND",
				["grab_on_top"] = false,
				["__snap"] = {
				},
				["switch_tank"] = false,
				["hide_in_combat_alpha"] = 0,
				["switch_all_roles_after_wipe"] = {
					4, -- [1]
					5, -- [2]
					26, -- [3]
				},
				["menu_icons"] = {
					false, -- [1]
					false, -- [2]
					false, -- [3]
					false, -- [4]
					false, -- [5]
					false, -- [6]
					["space"] = 3,
					["shadow"] = true,
				},
				["desaturated_menu"] = true,
				["micro_displays_side"] = 2,
				["statusbar_info"] = {
					["alpha"] = 0,
					["overlay"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
					},
				},
				["window_scale"] = 1,
				["libwindow"] = {
					["y"] = 0,
					["x"] = -194,
					["point"] = "BOTTOMRIGHT",
				},
				["bars_inverted"] = false,
				["switch_healer_in_combat"] = {
					2, -- [1]
					1, -- [2]
					9, -- [3]
				},
				["hide_icon"] = true,
				["bg_alpha"] = 0,
				["skin"] = "ElvUI Frame Style",
				["auto_current"] = true,
				["toolbar_side"] = 1,
				["bg_g"] = 0,
				["backdrop_texture"] = "ElvUI Blank",
				["hide_in_combat"] = false,
				["posicao"] = {
					["normal"] = {
						["y"] = -486.999938964844,
						["x"] = 666.999755859375,
						["w"] = 198.000183105469,
						["h"] = 106,
					},
					["solo"] = {
						["y"] = 2,
						["x"] = 1,
						["w"] = 300,
						["h"] = 200,
					},
				},
				["plugins_grow_direction"] = 1,
				["auto_hide_menu"] = {
					["left"] = true,
					["right"] = false,
				},
				["wallpaper"] = {
					["overlay"] = {
						0.999997794628143, -- [1]
						0.999997794628143, -- [2]
						0.999997794628143, -- [3]
						0.799998223781586, -- [4]
					},
					["texture"] = "Interface\\AddOns\\Details\\images\\skins\\elvui",
					["texcoord"] = {
						0.0480000019073486, -- [1]
						0.298000011444092, -- [2]
						0.630999984741211, -- [3]
						0.755999984741211, -- [4]
					},
					["enabled"] = false,
					["anchor"] = "all",
					["height"] = 225.999984741211,
					["alpha"] = 0.800000071525574,
					["width"] = 266.000061035156,
				},
				["stretch_button_side"] = 2,
				["switch_damager"] = false,
				["skin_custom"] = "",
				["attribute_text"] = {
					["show_timer"] = {
						true, -- [1]
						true, -- [2]
						true, -- [3]
					},
					["shadow"] = true,
					["side"] = 1,
					["text_size"] = 12,
					["custom_text"] = "{name}",
					["text_face"] = "FORCED SQUARE",
					["anchor"] = {
						-20, -- [1]
						5, -- [2]
					},
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.7, -- [4]
					},
					["enable_custom_text"] = false,
					["enabled"] = false,
				},
				["bg_b"] = 0,
			}, -- [2]
		},
		["report_lines"] = 10,
		["animate_scroll"] = false,
		["update_speed"] = 0.0500000007450581,
		["skin"] = "WoW Interface",
		["override_spellids"] = true,
		["use_battleground_server_parser"] = true,
		["clear_ungrouped"] = true,
		["force_activity_time_pvp"] = true,
		["overall_clear_logout"] = false,
		["minimum_combat_time"] = 5,
		["overall_clear_newboss"] = true,
		["cloud_capture"] = true,
		["damage_taken_everything"] = false,
		["scroll_speed"] = 2,
		["font_sizes"] = {
			["menus"] = 16,
		},
		["chat_tab_embed"] = {
			["enabled"] = false,
			["tab_name"] = "",
			["single_window"] = false,
		},
		["deadlog_events"] = 32,
		["overall_flag"] = 13,
		["close_shields"] = false,
		["class_coords"] = {
			["HUNTER"] = {
				0, -- [1]
				0.25, -- [2]
				0.25, -- [3]
				0.5, -- [4]
			},
			["WARRIOR"] = {
				0, -- [1]
				0.25, -- [2]
				0, -- [3]
				0.25, -- [4]
			},
			["SHAMAN"] = {
				0.25, -- [1]
				0.49609375, -- [2]
				0.25, -- [3]
				0.5, -- [4]
			},
			["MAGE"] = {
				0.25, -- [1]
				0.49609375, -- [2]
				0, -- [3]
				0.25, -- [4]
			},
			["PET"] = {
				0.25, -- [1]
				0.49609375, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
			["DRUID"] = {
				0.7421875, -- [1]
				0.98828125, -- [2]
				0, -- [3]
				0.25, -- [4]
			},
			["MONK"] = {
				0.5, -- [1]
				0.73828125, -- [2]
				0.5, -- [3]
				0.75, -- [4]
			},
			["DEATHKNIGHT"] = {
				0.25, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.75, -- [4]
			},
			["ENEMY"] = {
				0, -- [1]
				0.25, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
			["UNKNOW"] = {
				0.5, -- [1]
				0.75, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
			["PRIEST"] = {
				0.49609375, -- [1]
				0.7421875, -- [2]
				0.25, -- [3]
				0.5, -- [4]
			},
			["UNGROUPPLAYER"] = {
				0.5, -- [1]
				0.75, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
			["Alliance"] = {
				0.49609375, -- [1]
				0.7421875, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
			["WARLOCK"] = {
				0.7421875, -- [1]
				0.98828125, -- [2]
				0.25, -- [3]
				0.5, -- [4]
			},
			["DEMONHUNTER"] = {
				0.73828126, -- [1]
				1, -- [2]
				0.5, -- [3]
				0.75, -- [4]
			},
			["Horde"] = {
				0.7421875, -- [1]
				0.98828125, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
			["PALADIN"] = {
				0, -- [1]
				0.25, -- [2]
				0.5, -- [3]
				0.75, -- [4]
			},
			["ROGUE"] = {
				0.49609375, -- [1]
				0.7421875, -- [2]
				0, -- [3]
				0.25, -- [4]
			},
			["MONSTER"] = {
				0, -- [1]
				0.25, -- [2]
				0.75, -- [3]
				1, -- [4]
			},
		},
		["trash_auto_remove"] = true,
		["disable_alldisplays_window"] = true,
		["remove_realm_from_name"] = true,
		["numerical_system"] = 1,
		["segments_auto_erase"] = 1,
		["time_type_original"] = 2,
		["clear_graphic"] = true,
		["hotcorner_topleft"] = {
			["hide"] = false,
		},
		["animation_speed_triggertravel"] = 5,
		["options_group_edit"] = false,
		["segments_amount_to_save"] = 5,
		["minimap"] = {
			["onclick_what_todo"] = 1,
			["radius"] = 160,
			["hide"] = true,
			["minimapPos"] = 220,
			["text_format"] = 3,
			["text_type"] = 1,
		},
		["instances_amount"] = 2,
		["max_window_size"] = {
			["height"] = 450,
			["width"] = 480,
		},
		["standard_skin"] = false,
		["only_pvp_frags"] = false,
		["disable_stretch_button"] = true,
		["default_bg_color"] = 0.0941,
		["numerical_system_symbols"] = "auto",
		["broadcaster_enabled"] = false,
		["segments_panic_mode"] = false,
		["class_colors"] = {
			["HUNTER"] = {
				0.67, -- [1]
				0.83, -- [2]
				0.45, -- [3]
			},
			["WARRIOR"] = {
				0.78, -- [1]
				0.61, -- [2]
				0.43, -- [3]
			},
			["SHAMAN"] = {
				0, -- [1]
				0.44, -- [2]
				0.87, -- [3]
			},
			["MAGE"] = {
				0.41, -- [1]
				0.8, -- [2]
				0.94, -- [3]
			},
			["ARENA_YELLOW"] = {
				0.9, -- [1]
				0.9, -- [2]
				0, -- [3]
			},
			["UNGROUPPLAYER"] = {
				0.4, -- [1]
				0.4, -- [2]
				0.4, -- [3]
			},
			["DRUID"] = {
				1, -- [1]
				0.49, -- [2]
				0.04, -- [3]
			},
			["MONK"] = {
				0, -- [1]
				1, -- [2]
				0.59, -- [3]
			},
			["DEATHKNIGHT"] = {
				0.77, -- [1]
				0.12, -- [2]
				0.23, -- [3]
			},
			["ENEMY"] = {
				0.94117, -- [1]
				0, -- [2]
				0.0196, -- [3]
				1, -- [4]
			},
			["UNKNOW"] = {
				0.2, -- [1]
				0.2, -- [2]
				0.2, -- [3]
			},
			["PRIEST"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["PALADIN"] = {
				0.96, -- [1]
				0.55, -- [2]
				0.73, -- [3]
			},
			["ARENA_GREEN"] = {
				0.1, -- [1]
				0.85, -- [2]
				0.1, -- [3]
			},
			["WARLOCK"] = {
				0.58, -- [1]
				0.51, -- [2]
				0.79, -- [3]
			},
			["DEMONHUNTER"] = {
				0.64, -- [1]
				0.19, -- [2]
				0.79, -- [3]
			},
			["version"] = 1,
			["NEUTRAL"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
			},
			["ROGUE"] = {
				1, -- [1]
				0.96, -- [2]
				0.41, -- [3]
			},
			["PET"] = {
				0.3, -- [1]
				0.4, -- [2]
				0.5, -- [3]
			},
		},
		["window_clamp"] = {
			-8, -- [1]
			0, -- [2]
			21, -- [3]
			-14, -- [4]
		},
		["row_fade_out"] = {
			"out", -- [1]
			0.2, -- [2]
		},
		["class_icons_small"] = "Interface\\AddOns\\Details\\images\\classes_small",
		["use_scroll"] = false,
		["death_tooltip_width"] = 300,
		["report_schema"] = 1,
		["new_window_size"] = {
			["height"] = 130,
			["width"] = 320,
		},
		["total_abbreviation"] = 2,
		["disable_reset_button"] = false,
		["data_broker_text"] = "",
		["instances_no_libwindow"] = false,
		["segments_amount"] = 10,
		["deadlog_limit"] = 16,
		["instances_segments_locked"] = false,
	}
	_detalhes:ApplyProfile('Souschef')
	
end