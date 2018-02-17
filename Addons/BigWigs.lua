local E, L, V, P, G = unpack(ElvUI);
local SousUI = E:GetModule('Souschef');

function SousUI:LoadBigWigsProfile(layout)
	local font, fontsize
	font = "Expressway"
	fontsize = 11
	
	BigWigs3DB = {
		["namespaces"] = {
			["BigWigs_Plugins_Victory"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["soundName"] = "BigWigs: Victory Long",
					},
					["Souschef'sUI (Healer)"] = {
						["bigwigsMsg"] = true,
						["soundName"] = "BigWigs: Victory Long",
						["blizzMsg"] = false,
					},
				},
			},
			["BigWigs_Plugins_Alt Power"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["posx"] = 411.733213094867,
						["fontSize"] = 13,
						["fontOutline"] = "",
						["posy"] = 59.7332696755711,
						["font"] = font,
					},
					["Souschef'sUI (Healer)"] = {
						["posx"] = 583.821802331331,
						["fontSize"] = 13,
						["fontOutline"] = "",
						["posy"] = 198.399722686072,
						["font"] = font,
					},
					["Default"] = {
						["font"] = "Friz Quadrata TT",
						["fontSize"] = 12,
						["fontOutline"] = "",
					},
				},
			},
			["LibDualSpec-1.0"] = {
			},
			["BigWigs_Plugins_Sounds"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["media"] = {
							["Alarm"] = "BigWigs: Alert",
							["Warning"] = "ripthem",
							["Info"] = "None",
							["Alert"] = "BigWigs: Info",
						},
					},
					["Souschef'sUI (Healer)"] = {
						["Long"] = {
							["BigWigs_Bosses_Court of Stars Trash"] = {
								[211464] = "ripthem",
							},
							["BigWigs_Bosses_Cathedral of Eternal Night Trash"] = {
								[236737] = "ripthem",
							},
						},
						["Info"] = {
							["BigWigs_Bosses_Court of Stars Trash"] = {
								[211464] = "ripthem",
							},
							["BigWigs_Bosses_Cathedral of Eternal Night Trash"] = {
								[236737] = "ripthem",
							},
						},
						["media"] = {
							["Alarm"] = "BigWigs: Alert",
							["Warning"] = "ripthem",
							["Info"] = "None",
							["Alert"] = "BigWigs: Info",
						},
						["Alarm"] = {
							["BigWigs_Bosses_Kruul"] = {
								[234423] = "ripthem",
							},
							["BigWigs_Bosses_Court of Stars Trash"] = {
								[211464] = "ripthem",
							},
							["BigWigs_Bosses_The Coven of Shivarra"] = {
								[245586] = "ripthem",
							},
							["BigWigs_Bosses_The Arcway Trash"] = {
								[211217] = "ripthem",
							},
							["BigWigs_Bosses_Cathedral of Eternal Night Trash"] = {
								[236737] = "ripthem",
							},
						},
						["Alert"] = {
							["BigWigs_Bosses_Court of Stars Trash"] = {
								[211464] = "ripthem",
							},
							["BigWigs_Bosses_Kruul"] = {
								[234423] = "ripthem",
							},
							["BigWigs_Bosses_Cathedral of Eternal Night Trash"] = {
								[236737] = "ripthem",
							},
						},
					},
				},
			},
			["BigWigs_Plugins_Statistics"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["showBar"] = true,
					},
					["Souschef'sUI (Healer)"] = {
						["showBar"] = true,
					},
				},
			},
			["BigWigs_Bosses_The Coven of Shivarra"] = {
				["profiles"] = {
					["Souschef'sUI (Healer)"] = {
						[253650] = 0,
						[246329] = 0,
						["torment_of_the_titans"] = 98307,
					},
				},
			},
			["BigWigs_Bosses_Amalgam of Souls"] = {
				["profiles"] = {
				},
			},
			["BigWigs_Plugins_Colors"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["barBackground"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0.389999985694885, -- [4]
								},
							},
						},
						["Positive"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.63921568627451, -- [1]
									nil, -- [2]
									0.266666666666667, -- [3]
									1, -- [4]
								},
							},
						},
						["Personal"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.686274509803922, -- [1]
									0.764705882352941, -- [2]
									0.913725490196078, -- [3]
									1, -- [4]
								},
							},
						},
						["Important"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									nil, -- [1]
									0.501960784313726, -- [2]
									0.101960784313725, -- [3]
									1, -- [4]
								},
							},
						},
						["barColor"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.670588235294118, -- [1]
									0.141176470588235, -- [2]
									0.203921568627451, -- [3]
								},
							},
						},
						["flash"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									1, -- [1]
									0.611764705882353, -- [2]
									0.188235294117647, -- [3]
									1, -- [4]
								},
							},
						},
						["Urgent"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									nil, -- [1]
									0.0666666666666667, -- [2]
									0.00392156862745098, -- [3]
									1, -- [4]
								},
							},
						},
						["barEmphasized"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.701960784313726, -- [1]
									[3] = 0.698039215686275,
								},
							},
						},
						["Neutral"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.913725490196078, -- [1]
									0.909803921568627, -- [2]
									0.909803921568627, -- [3]
									1, -- [4]
								},
							},
						},
					},
					["Souschef'sUI (Healer)"] = {
						["barBackground"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									0.389999985694885, -- [4]
								},
							},
						},
						["Positive"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.63921568627451, -- [1]
									nil, -- [2]
									0.266666666666667, -- [3]
									1, -- [4]
								},
							},
						},
						["Personal"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.913725490196078, -- [1]
									0.909803921568627, -- [2]
									0.909803921568627, -- [3]
									1, -- [4]
								},
							},
						},
						["Important"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									nil, -- [1]
									0.772549019607843, -- [2]
									0.486274509803922, -- [3]
									1, -- [4]
								},
							},
						},
						["barColor"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.670588235294118, -- [1]
									0.141176470588235, -- [2]
									0.203921568627451, -- [3]
								},
							},
						},
						["flash"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.552941176470588, -- [1]
									0.0901960784313726, -- [2]
									0.105882352941176, -- [3]
									1, -- [4]
								},
							},
						},
						["Urgent"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									nil, -- [1]
									0.494117647058824, -- [2]
									0.494117647058824, -- [3]
									1, -- [4]
								},
							},
						},
						["barEmphasized"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.701960784313726, -- [1]
									[3] = 0.698039215686275,
								},
							},
						},
						["Attention"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.913725490196078, -- [1]
									0.909803921568627, -- [2]
									0.909803921568627, -- [3]
									1, -- [4]
								},
							},
						},
						["Neutral"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.913725490196078, -- [1]
									0.909803921568627, -- [2]
									0.909803921568627, -- [3]
									1, -- [4]
								},
							},
						},
					},
				},
			},
			["BigWigs_Bosses_The Arcway Trash"] = {
				["profiles"] = {
				},
			},
			["BigWigs_Plugins_InfoBox"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["posx"] = 300.800115790635,
						["posy"] = 73.9551775720292,
					},
					["Souschef'sUI (Healer)"] = {
						["posx"] = 427.378178751478,
						["posy"] = 537.599622392645,
					},
				},
			},
			["BigWigs_Plugins_Bars"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["BigWigsEmphasizeAnchor_y"] = 729.599844055701,
						["emphasize"] = false,
						["texture"] = "ElvUI Blank",
						["emphasizeTime"] = 8,
						["BigWigsAnchor_width"] = 204.999893188477,
						["BigWigsAnchor_y"] = 338.489070696305,
						["BigWigsEmphasizeAnchor_x"] = 238.221902469786,
						["barStyle"] = "ElvUI",
						["emphasizeRestart"] = false,
						["font"] = font,
						["BigWigsAnchor_x"] = 403.911381308244,
						["BigWigsEmphasizeAnchor_width"] = 175,
						["fontSize"] = 13,
						["monochrome"] = false,
						["emphasizeScale"] = 1,
						["fill"] = false,
					},
					["Souschef'sUI (Healer)"] = {
						["BigWigsEmphasizeAnchor_y"] = 729.599844055701,
						["emphasize"] = false,
						["emphasizeTime"] = 8,
						["fill"] = false,
						["BigWigsAnchor_width"] = 204.999893188477,
						["BigWigsAnchor_y"] = 338.489070696305,
						["BigWigsEmphasizeAnchor_x"] = 238.221902469786,
						["barStyle"] = "ElvUI",
						["emphasizeRestart"] = false,
						["font"] = font,
						["BigWigsAnchor_x"] = 403.911381308244,
						["BigWigsEmphasizeAnchor_width"] = 175,
						["fontSize"] = 13,
						["monochrome"] = false,
						["emphasizeScale"] = 1,
						["texture"] = "ElvUI Blank",
					},
					["Default"] = {
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_Super Emphasize"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["outline"] = "OUTLINE",
						["fontSize"] = 22,
						["fontColor"] = {
							["g"] = 0.882352941176471,
						},
						["monochrome"] = false,
						["voice"] = "English: Jim",
						["font"] = font,
					},
					["Souschef'sUI (Healer)"] = {
						["outline"] = "OUTLINE",
						["fontSize"] = 22,
						["fontColor"] = {
							["g"] = 0.882352941176471,
						},
						["monochrome"] = false,
						["voice"] = "English: Jim",
						["font"] = font,
					},
					["Default"] = {
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_BossBlock"] = {
			},
			["BigWigs_Plugins_Common Auras"] = {
			},
			["BigWigs_Plugins_Raid Icons"] = {
			},
			["BigWigs_Plugins_Proximity"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["posx"] = 650.666291797152,
						["fontSize"] = 14,
						["soundName"] = "BigWigs: Info",
						["width"] = 139.999984741211,
						["objects"] = {
							["title"] = false,
							["close"] = false,
							["ability"] = false,
							["tooltip"] = false,
							["sound"] = false,
						},
						["posy"] = 230.399897072048,
						["height"] = 120.000007629395,
						["sound"] = true,
						["font"] = font,
					},
					["Souschef'sUI (Healer)"] = {
						["posx"] = 754.488473130587,
						["fontSize"] = 14,
						["soundName"] = "BigWigs: Info",
						["width"] = 100.000091552734,
						["objects"] = {
							["ability"] = false,
							["tooltip"] = false,
							["title"] = false,
							["close"] = false,
						},
						["posy"] = 225.4219889654,
						["height"] = 69.9999313354492,
						["sound"] = true,
						["font"] = font,
					},
					["Default"] = {
						["fontSize"] = 20,
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_Messages"] = {
				["profiles"] = {
					["Souschef'sUI (DPS)"] = {
						["outline"] = "NONE",
						["fontSize"] = 16,
						["BWEmphasizeCountdownMessageAnchor_x"] = 663.466639329327,
						["fadetime"] = 1,
						["BWEmphasizeMessageAnchor_y"] = 436.622319600319,
						["BWMessageAnchor_y"] = 475.732997630694,
						["sink20OutputSink"] = "Parrot",
						["align"] = "LEFT",
						["monochrome"] = false,
						["displaytime"] = 5,
						["BWEmphasizeCountdownMessageAnchor_y"] = 476.444325772918,
						["font"] = font,
						["sink20Sticky"] = true,
						["growUpwards"] = false,
						["BWEmphasizeMessageAnchor_x"] = 608.710995642341,
						["BWMessageAnchor_x"] = 829.866860372495,
						["sink20ScrollArea"] = "Character",
					},
					["Souschef'sUI (Healer)"] = {
						["outline"] = "OUTLINE",
						["fontSize"] = 16,
						["BWEmphasizeCountdownMessageAnchor_x"] = 670.577794015408,
						["sink20OutputSink"] = "Parrot",
						["growUpwards"] = false,
						["BWMessageAnchor_x"] = 612.978573870678,
						["BWMessageAnchor_y"] = 496.355046741155,
						["fadetime"] = 1,
						["BWEmphasizeCountdownMessageAnchor_y"] = 465.066504316856,
						["font"] = font,
						["BWEmphasizeMessageAnchor_y"] = 441.600010693073,
						["sink20Sticky"] = true,
						["BWEmphasizeMessageAnchor_x"] = 612.977662412322,
						["displaytime"] = 5,
						["monochrome"] = false,
						["sink20ScrollArea"] = "Character",
					},
					["Default"] = {
						["fontSize"] = 20,
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_Respawn"] = {
			},
			["BigWigs_Plugins_Pull"] = {
			},
			["BigWigs_Bosses_Kruul"] = {
				["profiles"] = {
					["Souschef'sUI (Healer)"] = {
						["nether_aberration"] = 0,
						[240790] = 0,
						[234428] = 0,
						[234422] = 0,
						["smoldering_infernal"] = 0,
						[233473] = 0,
					},
				},
			},
		},
		["discord"] = 15,
		["profiles"] = {
			["Souschef'sUI (DPS)"] = {
			},
			["Souschef'sUI (Healer)"] = {
				["showZoneMessages"] = false,
			},
		},
	}

	local db = LibStub("AceDB-3.0"):New(BigWigs3DB, nil, true)
	if layout == "healer" then
		db:SetProfile("Souschef'sUI (Healer)")
	else
		db:SetProfile("Souschef'sUI (DPS)")
	end
end