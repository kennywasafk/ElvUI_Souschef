local E, L, V, P, G = unpack(ElvUI);
local SousUI = E:GetModule('Souschef');

function SousUI:LoadParrot2Profile(layout)
	local font, fontsize
	font = "Expressway"
	fontsize = 14
	
	ParrotDB = {
	["namespaces"] = {
		["CombatEvents"] = {
			["profiles"] = {
			    ["Souschef'sUI"] = {
					["throttles"] = {
						["Reputation gains"] = 1,
					},
					["Incoming"] = {
						["Pet skill parries"] = {
							["disabled"] = true,
						},
						["Skill immunes"] = {
							["disabled"] = true,
						},
						["Heals over time"] = {
							["disabled"] = true,
						},
						["Skill misses"] = {
							["disabled"] = true,
						},
						["Melee dodges"] = {
							["disabled"] = true,
						},
						["Melee damage"] = {
							["tag"] = "[Amount]",
							["disabled"] = true,
							["scrollArea"] = "Damages",
						},
						["Skill parries"] = {
							["disabled"] = true,
						},
						["Skill deflects"] = {
							["disabled"] = true,
						},
						["Melee evades"] = {
							["disabled"] = true,
						},
						["Melee reflects"] = {
							["disabled"] = true,
						},
						["Pet skill deflects"] = {
							["disabled"] = true,
						},
						["Self heals"] = {
							["disabled"] = true,
						},
						["Skill damage"] = {
							["tag"] = "[Amount]",
							["disabled"] = true,
							["scrollArea"] = "Damages",
						},
						["Pet skill dodges"] = {
							["disabled"] = true,
						},
						["Skill DoTs"] = {
							["tag"] = "[Amount]",
							["disabled"] = true,
							["scrollArea"] = "Damages",
						},
						["Environmental damage"] = {
							["disabled"] = true,
						},
						["Pet melee deflects"] = {
							["disabled"] = true,
						},
						["Pet skill reflects"] = {
							["disabled"] = true,
						},
						["Melee misses"] = {
							["disabled"] = true,
						},
						["Reactive skills"] = {
							["tag"] = "[Amount]",
							["disabled"] = true,
							["scrollArea"] = "Damages",
						},
						["Dispel fail"] = {
							["disabled"] = true,
						},
						["Melee absorbs"] = {
							["disabled"] = true,
						},
						["Skill blocks"] = {
							["disabled"] = true,
						},
						["Skill interrupts"] = {
							["scrollArea"] = "Character",
						},
						["Melee immunes"] = {
							["disabled"] = true,
						},
						["Skill resists"] = {
							["disabled"] = true,
						},
						["Pet skill immunes"] = {
							["disabled"] = true,
						},
						["Dispel"] = {
							["disabled"] = true,
						},
						["Pet skill evades"] = {
							["disabled"] = true,
						},
						["Pet melee blocks"] = {
							["disabled"] = true,
						},
						["Pet melee damage"] = {
							["disabled"] = true,
						},
						["Melee deflects"] = {
							["disabled"] = true,
						},
						["Skill absorbs"] = {
							["disabled"] = true,
						},
						["Pet melee parries"] = {
							["disabled"] = true,
						},
						["Spell steal"] = {
							["disabled"] = true,
						},
						["Pet skill DoTs"] = {
							["disabled"] = true,
						},
						["Pet skill blocks"] = {
							["disabled"] = true,
						},
						["Melee blocks"] = {
							["disabled"] = true,
						},
						["Pet heals over time"] = {
							["disabled"] = true,
						},
						["Pet melee evades"] = {
							["disabled"] = true,
						},
						["Skill evades"] = {
							["disabled"] = true,
						},
						["Pet Skill interrupts"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Heals"] = {
							["disabled"] = true,
						},
						["Self heals over time"] = {
							["disabled"] = true,
						},
						["Pet skill absorbs"] = {
							["disabled"] = true,
						},
						["Pet skill misses"] = {
							["disabled"] = true,
						},
						["Pet skill resists"] = {
							["disabled"] = true,
						},
						["Pet melee reflects"] = {
							["disabled"] = true,
						},
						["Pet heals"] = {
							["disabled"] = true,
						},
						["Pet melee immunes"] = {
							["disabled"] = true,
						},
						["Pet melee dodges"] = {
							["disabled"] = true,
						},
						["Skill reflects"] = {
							["disabled"] = true,
						},
						["Skill dodges"] = {
							["disabled"] = true,
						},
						["Melee resists"] = {
							["disabled"] = true,
						},
						["Pet melee misses"] = {
							["disabled"] = true,
						},
						["Pet melee resists"] = {
							["disabled"] = true,
						},
						["Melee parries"] = {
							["disabled"] = true,
						},
						["Pet skill damage"] = {
							["disabled"] = true,
						},
						["Pet melee absorbs"] = {
							["disabled"] = true,
						},
					},
					["dbver"] = 5,
					["Outgoing"] = {
						["Pet skill parries"] = {
							["disabled"] = true,
						},
						["Skill immunes"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Melee reflects"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Skill misses"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Melee dodges"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Melee damage"] = {
							["disabled"] = true,
						},
						["Skill parries"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Siege damage"] = {
							["disabled"] = true,
						},
						["Skill deflects"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Melee evades"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Pet siege damage"] = {
							["disabled"] = true,
						},
						["Pet spell interrupts"] = {
							["scrollArea"] = "Character",
						},
						["Melee parries"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Skill damage"] = {
							["disabled"] = true,
						},
						["Pet skill dodges"] = {
							["disabled"] = true,
						},
						["Self heals"] = {
							["disabled"] = true,
						},
						["Melee resists"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Pet melee deflects"] = {
							["disabled"] = true,
						},
						["Pet skill reflects"] = {
							["disabled"] = true,
						},
						["Melee misses"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Reactive skills"] = {
							["disabled"] = true,
						},
						["Dispel fail"] = {
							["disabled"] = false,
							["scrollArea"] = "Character",
						},
						["Melee absorbs"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Skill blocks"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Skill resists"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Melee immunes"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Pet skill immunes"] = {
							["disabled"] = true,
						},
						["Dispel"] = {
							["scrollArea"] = "Character",
							["sound"] = "Bite",
							["disabled"] = false,
							["tag"] = "[Skill] - [ExtraSkill]",
						},
						["Skill absorbs"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Pet skill evades"] = {
							["disabled"] = true,
						},
						["Pet melee blocks"] = {
							["disabled"] = true,
						},
						["Pet melee damage"] = {
							["disabled"] = true,
						},
						["Melee deflects"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Melee blocks"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Pet melee parries"] = {
							["disabled"] = true,
						},
						["Pet melee immunes"] = {
							["disabled"] = true,
						},
						["Pet skill DoTs"] = {
							["disabled"] = true,
						},
						["Pet skill blocks"] = {
							["disabled"] = true,
						},
						["Pet heals over time"] = {
							["disabled"] = true,
						},
						["Spell interrupts"] = {
							["color"] = "eeff83",
							["scrollArea"] = "Character",
							["sound"] = "Bite",
							["tag"] = "[ExtraSkill] - interrupted! ",
						},
						["Heals"] = {
							["disabled"] = true,
						},
						["Skill evades"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Pet melee misses"] = {
							["disabled"] = true,
						},
						["Spell steal"] = {
							["disabled"] = false,
							["scrollArea"] = "Character",
						},
						["Self heals over time"] = {
							["disabled"] = true,
						},
						["Pet skill absorbs"] = {
							["disabled"] = true,
						},
						["Pet skill misses"] = {
							["disabled"] = true,
						},
						["Pet skill resists"] = {
							["disabled"] = true,
						},
						["Pet melee reflects"] = {
							["disabled"] = true,
						},
						["Pet heals"] = {
							["disabled"] = true,
						},
						["Pet melee evades"] = {
							["disabled"] = true,
						},
						["Pet melee dodges"] = {
							["disabled"] = true,
						},
						["Skill dodges"] = {
							["color"] = "b9b7ff",
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Skill reflects"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Heals over time"] = {
							["disabled"] = true,
						},
						["Pet skill deflects"] = {
							["disabled"] = true,
						},
						["Pet melee resists"] = {
							["disabled"] = true,
						},
						["Skill DoTs"] = {
							["disabled"] = true,
						},
						["Pet skill damage"] = {
							["disabled"] = true,
						},
						["Pet melee absorbs"] = {
							["disabled"] = true,
						},
					},
					["breakUpAmount"] = true,
					["Notification"] = {
						["Currency gains"] = {
							["color"] = "ddcd69",
						},
						["Player killing blows"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Power gain"] = {
							["disabled"] = true,
						},
						["Pet debuff gains"] = {
							["disabled"] = true,
						},
						["Experience gains"] = {
							["scrollArea"] = "Character",
						},
						["Debuff fades"] = {
							["disabled"] = true,
						},
						["Pet buff gains"] = {
							["disabled"] = true,
						},
						["Reputation losses"] = {
							["color"] = "cf4f57",
							["scrollArea"] = "Character",
						},
						["Enemy buff gains"] = {
							["disabled"] = true,
						},
						["Combo points full"] = {
							["disabled"] = true,
						},
						["Debuff gains"] = {
							["disabled"] = true,
						},
						["Reputation gains"] = {
							["color"] = "80e183",
							["scrollArea"] = "Character",
						},
						["NPC killing blows"] = {
							["disabled"] = true,
							["scrollArea"] = "Character",
						},
						["Loot items"] = {
							["tag"] = "[Name] x[Amount]",
						},
						["Enter combat"] = {
							["color"] = "ff3b59",
							["scrollArea"] = "Character",
							["disabled"] = false,
							["tag"] = "Combat",
						},
						["Item buff fades"] = {
							["disabled"] = true,
						},
						["Item buff gains"] = {
							["disabled"] = true,
						},
						["Combo point gain"] = {
							["disabled"] = true,
						},
						["Pet debuff fades"] = {
							["disabled"] = true,
						},
						["Power loss"] = {
							["disabled"] = true,
						},
						["Pet buff fades"] = {
							["disabled"] = true,
						},
						["Loot money"] = {
							["disabled"] = true,
							["tag"] = "[Amount]",
						},
						["Target buff stack gains"] = {
							["disabled"] = true,
						},
						["Skill cooldown finish"] = {
							["disabled"] = true,
						},
						["Target buff gains"] = {
							["disabled"] = true,
						},
						["Buff fades"] = {
							["disabled"] = true,
						},
						["Leave combat"] = {
							["color"] = "75ff75",
							["tag"] = "Combat",
							["disabled"] = false,
							["scrollArea"] = "Character",
						},
						["Enemy debuff gains"] = {
							["disabled"] = true,
						},
						["Extra attacks"] = {
							["disabled"] = true,
						},
						["Enemy debuff fades"] = {
							["disabled"] = true,
						},
						["Buff gains"] = {
							["disabled"] = true,
						},
						["Buff stack gains"] = {
							["disabled"] = true,
						},
						["Enemy buff fades"] = {
							["disabled"] = true,
						},
						["Debuff stack gains"] = {
							["disabled"] = true,
						},
					},
				},
			},
		},
		["Cooldowns"] = {
		},
		["Suppressions"] = {
		},
		["LibDualSpec-1.0"] = {
		},
		["Display"] = {
			["profiles"] = {
				["Souschef'sUI"] = {
					["stickyFontOutline"] = "NONE",
					["font"] = "Expressway",
					["fontOutline"] = "NONE",
					["stickyFontSize"] = 18,
					["stickyFont"] = "Expressway",
				},
			},
		},
		["ScrollAreas"] = {
			["profiles"] = {
				["Souschef'sUI"] = {
					["areas"] = {
						["Damages"] = {
							["fontSize"] = 14,
							["stickySpeed"] = 12,
							["xOffset"] = -85.9989624023438,
							["yOffset"] = -233.000122070313,
							["stickyDirection"] = "UP;RIGHT",
							["size"] = 50,
							["stickyFontSize"] = 14,
							["speed"] = 12,
							["direction"] = "UP;RIGHT",
							["animationStyle"] = "Static2",
							["stickyAnimationStyle"] = "Static2",
						},
						["Notification"] = {
							["direction"] = "UP;LEFT",
							["stickySpeed"] = 5,
							["xOffset"] = -225.000061035156,
							["yOffset"] = -100.000061035156,
							["stickyDirection"] = "UP;LEFT",
							["stickyAnimationStyle"] = "Static2",
							["stickyFontSize"] = 14,
							["speed"] = 5,
							["fontSize"] = 14,
							["animationStyle"] = "Static2",
							["size"] = 50,
						},
						["Outgoing"] = {
							["xOffset"] = -525.999847412109,
							["yOffset"] = 308.999938964844,
						},
						["Character"] = {
							["direction"] = "UP;CENTER",
							["xOffset"] = 4.001220703125,
							["yOffset"] = 190.000183105469,
							["stickyDirection"] = "UP;CENTER",
							["stickyFontShadow"] = true,
							["size"] = 80,
							["stickyFontSize"] = 17,
							["fontSize"] = 14,
							["iconSide"] = "LEFT",
							["animationStyle"] = "Straight",
							["stickyAnimationStyle"] = "Straight",
						},
						["Incoming"] = {
							["xOffset"] = -525.999755859375,
							["yOffset"] = 309.999877929688,
						},
					},
				},
			},
		},
		["Triggers"] = {
			["profiles"] = {
				["Souschef'sUI"] = {
					["triggers2"] = {
						[1022] = {
							["disabled"] = true,
						},
						[1038] = {
							["disabled"] = true,
						},
						[1040] = {
							["disabled"] = true,
						},
						[1004] = {
							["disabled"] = true,
						},
					},
				},
			},
		},
	},
	["profiles"] = {
		["Souschef'sUI"] = {
	},
	},
}
	local db = LibStub("AceDB-3.0"):New(ParrotDB, nil, true)
    db:SetProfile("Souschef'sUI")
end