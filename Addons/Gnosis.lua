local E, L, V, P, G = unpack(ElvUI);
local SousUI = E:GetModule('Souschef');

function SousUI:LoadGnosisProfile(layout)
	local font, fontsize
	font = "Expressway"
	fontsize = 12
	
	GnosisDB = nil
	GnosisConfigs = {
	["Souschef's UI"] = {
		["channeledspells"] = {
			["Fists of Fury"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = true,
				["bars"] = 4,
				["bicon"] = true,
				["ticks"] = 5,
				["ctstring"] = "col<physical>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = true,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 1,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Tranquility"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = true,
				["bars"] = 15,
				["bicon"] = true,
				["ticks"] = 4,
				["ctstring"] = "col<0,1,0>(spellname) [tickscrits] +eh <oh> col<pre>dps HPShittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = true,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 3,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Arcane Missiles"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = false,
				["bars"] = 6,
				["bicon"] = true,
				["ticks"] = 5,
				["ctstring"] = "col<arcane>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 2,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Mind Flay"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = false,
				["bars"] = 5,
				["bicon"] = true,
				["ticks"] = 4,
				["ctstring"] = "col<shadow>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 3,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Health Funnel"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = false,
				["bars"] = 6,
				["bicon"] = true,
				["ticks"] = 6,
				["ctstring"] = "col<shadow>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 3,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Penance"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = false,
				["bars"] = 2,
				["bicon"] = true,
				["ticks"] = 3,
				["ctstring"] = "col<0,1,0>(spellname - col<1,1,1>col<class>targetcol<cpre>col<pre>col<0,1,0>) [tickscrits] +eh <oh> col<pre>dps HPShittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = true,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 1,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Divine Hymn"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = true,
				["bars"] = 15,
				["bicon"] = true,
				["ticks"] = 4,
				["ctstring"] = "col<0,1,0>(spellname) [tickscrits] +eh <oh> col<pre>dps HPShittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 4,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Mind Sear"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = true,
				["bars"] = 7,
				["bicon"] = true,
				["ticks"] = 6,
				["ctstring"] = "col<shadow>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = true,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 3,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Evocation"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = false,
				["bars"] = 3,
				["bicon"] = true,
				["ticks"] = 4,
				["ctstring"] = "col<arcane>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = true,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 2,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Soothing Mist"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = false,
				["bars"] = 11,
				["bicon"] = true,
				["ticks"] = 8,
				["ctstring"] = "col<0,1,0>(spellname - col<1,1,1>col<class>targetcol<cpre>col<pre>col<0,1,0>) [tickscrits] +eh <oh> col<pre>dps HPShittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 3,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
			["Rain of Fire"] = {
				["bcombattext"] = false,
				["bticksound"] = false,
				["baoe"] = true,
				["bars"] = 15,
				["bicon"] = true,
				["ticks"] = 6,
				["ctstring"] = "col<fire>dmg col<pre>col<1,1,0>(spellname) [tickscrits]col<pre>clipped dps DPScliptext<(Clipped) >hittext< Hits>crittext< Crits>ticktext< Ticks>",
				["bhidenonplayer"] = false,
				["baddticks"] = false,
				["binit"] = false,
				["ben"] = true,
				["bcliptest"] = false,
				["bsticky"] = true,
				["iupdate"] = 3,
				["fontsizeclip"] = 0,
				["fontsizenclip"] = 0,
			},
		},
		["cbconf"] = {
			["Target"] = {
				["fSparkHeightMulti"] = 1.2,
				["strGap"] = 16,
				["bShowShield"] = false,
				["bMergeTrade"] = true,
				["fadeout"] = 0.4,
				["colBarBg"] = {
					0.423529411764706, -- [1]
					0.423529411764706, -- [2]
					0.423529411764706, -- [3]
					1, -- [4]
				},
				["colSuccess"] = {
					0.15, -- [1]
					0.25, -- [2]
					0.1, -- [3]
					0.7, -- [4]
				},
				["incombatsel"] = 1,
				["alignname"] = "LEFT",
				["bordertexture"] = "None",
				["bnwtypesel"] = 1,
				["colBarNI"] = {
					0.67, -- [1]
					0.14, -- [2]
					0.2, -- [3]
					0.87, -- [4]
				},
				["font"] = "Expressway",
				["colFailed"] = {
					0.13, -- [1]
					0.13, -- [2]
					0.13, -- [3]
					0.75, -- [4]
				},
				["colTextLag"] = {
					1, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["anchortype"] = 1,
				["bShowTicks"] = false,
				["rotatectext"] = 0,
				["strNameFormat"] = "namecol<1,0,0>txm< (>misctxm<)>col<pre>txts< (>tscurtxts</>tstottxts<)>",
				["scale"] = 1,
				["anchor_y"] = 0,
				["rotatelattext"] = 0,
				["unit"] = "target",
				["scaleicon"] = 1.8,
				["fontsize"] = 12,
				["bordericon"] = 0.6,
				["instancetype"] = 1,
				["bnwlistnew"] = "",
				["anchorto"] = 5,
				["bartexture"] = "Flatt",
				["bColSuc"] = false,
				["colBorderNI"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["alpha"] = 1,
				["fSparkWidthMulti"] = 0.8,
				["bShowAsMinutes"] = true,
				["colBar"] = {
					0.13, -- [1]
					0.13, -- [2]
					0.13, -- [3]
					0.87, -- [4]
				},
				["latbarsize"] = 0.15,
				["bShowLat"] = false,
				["anchor"] = {
					["px"] = 0.615104103088379,
					["py"] = 0.521205424127132,
				},
				["bEnShadowCol"] = true,
				["colLagBar"] = {
					0.9, -- [1]
					0.06, -- [2]
					0.06, -- [3]
					0.49, -- [4]
				},
				["orient"] = 1,
				["spectab"] = {
					true, -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
				},
				["bEnShadowOffset"] = false,
				["colSpark"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["anchorfrom"] = 5,
				["coord"] = {
					["casttime"] = {
						["y"] = 0.25,
						["x"] = -2,
					},
					["shadow"] = {
						["y"] = 0,
						["x"] = 0,
					},
					["latency"] = {
						["y"] = 2.5,
						["x"] = 5,
					},
					["casticon"] = {
						["y"] = -3.5,
						["x"] = 1,
					},
					["castname"] = {
						["y"] = 0.25,
						["x"] = 4,
					},
				},
				["cboptver"] = 4.62,
				["bIconUnlocked"] = false,
				["height"] = 16,
				["fontsize_lat"] = 12,
				["colBorder"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["colText"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["colShadow"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["strata"] = "MEDIUM",
				["bEn"] = false,
				["anchorframe"] = "",
				["colTextTime"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["bInvDir"] = false,
				["border"] = 1,
				["bShowPlayerLatency"] = false,
				["rotateicon"] = 0,
				["rotatertext"] = 0,
				["bartype"] = "cb",
				["iconside"] = "LEFT",
				["width"] = 131,
				["bExtChannels"] = true,
				["bResizeLongName"] = false,
				["alignlat"] = "LEFT",
				["ingroupsel"] = 1,
				["bShowWNC"] = false,
				["relationsel"] = 1,
				["fontoutline"] = "NONE",
				["bUnlocked"] = false,
				["anchor_x"] = 0,
				["strTimeFormat"] = "r<1a>",
				["forcefreealign"] = false,
				["latbarfixed"] = 0.03,
				["bShowCBS"] = false,
				["alignment"] = "NAMETIME",
				["bFillup"] = false,
				["aligntime"] = "RIGHT",
				["colInterrupted"] = {
					0.13, -- [1]
					0.13, -- [2]
					0.13, -- [3]
					0.7, -- [4]
				},
				["bnwlist"] = {
				},
				["fontsize_timer"] = 12,
			},
			["Player"] = {
				["fSparkHeightMulti"] = 1.1,
				["strGap"] = 15,
				["bShowShield"] = false,
				["bMergeTrade"] = true,
				["fadeout"] = 0.3,
				["colBarBg"] = {
					0.423529411764706, -- [1]
					0.423529411764706, -- [2]
					0.423529411764706, -- [3]
					1, -- [4]
				},
				["colSuccess"] = {
					0.15, -- [1]
					0.25, -- [2]
					0.1, -- [3]
					0.7, -- [4]
				},
				["incombatsel"] = 1,
				["alignname"] = "LEFT",
				["bordertexture"] = "None",
				["bnwtypesel"] = 1,
				["colBarNI"] = {
					0.125490196078431, -- [1]
					0.125490196078431, -- [2]
					0.125490196078431, -- [3]
					0.870000004768372, -- [4]
				},
				["font"] = "Expressway",
				["colFailed"] = {
					0.7, -- [1]
					0.3, -- [2]
					0.2, -- [3]
					0.75, -- [4]
				},
				["colTextLag"] = {
					1, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["anchortype"] = 1,
				["bShowTicks"] = true,
				["rotatectext"] = 0,
				["strNameFormat"] = "namecol<1,0,0>txm< (>misctxm<)>col<pre>txts< (>tscurtxts</>tstottxts<)>",
				["scale"] = 1,
				["anchor_y"] = 0,
				["rotatelattext"] = 0,
				["unit"] = "player",
				["scaleicon"] = 1,
				["fontsize"] = 12,
				["bordericon"] = 2,
				["instancetype"] = 1,
				["bnwlistnew"] = "",
				["anchorto"] = 5,
				["bartexture"] = "ElvUI Norm",
				["bColSuc"] = false,
				["colBorderNI"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["alpha"] = 1,
				["fSparkWidthMulti"] = 1.5,
				["bShowAsMinutes"] = true,
				["colBar"] = {
					0.125490196078431, -- [1]
					0.125490196078431, -- [2]
					0.125490196078431, -- [3]
					0.870000004768372, -- [4]
				},
				["latbarsize"] = 0.33,
				["bShowLat"] = true,
				["anchor"] = {
					["px"] = 0.500000222524007,
					["py"] = 0.38120923995511,
				},
				["bEnShadowCol"] = true,
				["colLagBar"] = {
					0.901960784313726, -- [1]
					0.0627450980392157, -- [2]
					0.0627450980392157, -- [3]
					0.490000009536743, -- [4]
				},
				["orient"] = 1,
				["spectab"] = {
					true, -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
				},
				["bEnShadowOffset"] = false,
				["colSpark"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["anchorfrom"] = 5,
				["coord"] = {
					["casttime"] = {
						["y"] = 1,
						["x"] = -9,
					},
					["shadow"] = {
						["y"] = -3,
						["x"] = 3,
					},
					["latency"] = {
						["y"] = 1,
						["x"] = -1,
					},
					["casticon"] = {
						["y"] = 0,
						["x"] = -3,
					},
					["castname"] = {
						["y"] = 1,
						["x"] = 5,
					},
				},
				["cboptver"] = 4.62,
				["bIconUnlocked"] = false,
				["height"] = 20,
				["fontsize_lat"] = 12,
				["colBorder"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["colText"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["colShadow"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					0.7, -- [4]
				},
				["strata"] = "MEDIUM",
				["bEn"] = true,
				["anchorframe"] = "",
				["colTextTime"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["bInvDir"] = false,
				["border"] = 1,
				["bShowPlayerLatency"] = false,
				["rotateicon"] = 0,
				["rotatertext"] = 0,
				["bartype"] = "cb",
				["iconside"] = "LEFT",
				["width"] = 152,
				["bExtChannels"] = true,
				["bResizeLongName"] = false,
				["alignlat"] = "ADAPT",
				["ingroupsel"] = 1,
				["bShowWNC"] = false,
				["relationsel"] = 1,
				["fontoutline"] = "NONE",
				["bUnlocked"] = false,
				["anchor_x"] = 0,
				["strTimeFormat"] = "col<1,0,0>p<2s>col<pre> r<1m>",
				["forcefreealign"] = false,
				["latbarfixed"] = 0.01,
				["bShowCBS"] = true,
				["alignment"] = "NAMETIME",
				["bFillup"] = false,
				["aligntime"] = "RIGHT",
				["colInterrupted"] = {
					0.125490196078431, -- [1]
					0.125490196078431, -- [2]
					0.125490196078431, -- [3]
					0.700000017881393, -- [4]
				},
				["bnwlist"] = {
				},
				["fontsize_timer"] = 12,
			},
			["Boss"] = {
				["fSparkHeightMulti"] = 1.2,
				["strGap"] = 15,
				["bShowShield"] = false,
				["bMergeTrade"] = true,
				["fadeout"] = 0.1,
				["colBarBg"] = {
					0.423529411764706, -- [1]
					0.423529411764706, -- [2]
					0.423529411764706, -- [3]
					1, -- [4]
				},
				["colSuccess"] = {
					0.15, -- [1]
					0.25, -- [2]
					0.1, -- [3]
					0.7, -- [4]
				},
				["incombatsel"] = 1,
				["alignname"] = "LEFT",
				["bordertexture"] = "None",
				["bnwtypesel"] = 1,
				["colBarNI"] = {
					0.670588235294118, -- [1]
					0.141176470588235, -- [2]
					0.203921568627451, -- [3]
					0.870000004768372, -- [4]
				},
				["font"] = "Expressway",
				["colFailed"] = {
					0.125490196078431, -- [1]
					0.125490196078431, -- [2]
					0.125490196078431, -- [3]
					0.75, -- [4]
				},
				["colTextLag"] = {
					1, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["anchortype"] = 1,
				["bShowTicks"] = true,
				["rotatectext"] = 0,
				["strNameFormat"] = "namecol<1,0,0>txm< (>misctxm<)>col<pre>txts< (>tscurtxts</>tstottxts<)>",
				["colShadow"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["anchor_y"] = 0,
				["rotatelattext"] = 0,
				["unit"] = "boss1",
				["aligntime"] = "LEFT",
				["fontsize"] = 15,
				["colInterrupted"] = {
					0.125490196078431, -- [1]
					0.125490196078431, -- [2]
					0.125490196078431, -- [3]
					0.700000017881393, -- [4]
				},
				["instancetype"] = 1,
				["bnwlistnew"] = "",
				["anchorto"] = 5,
				["bartexture"] = "ElvUI Norm",
				["fontsize_timer"] = 15,
				["colBorderNI"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["alpha"] = 1,
				["fSparkWidthMulti"] = 0.8,
				["bShowAsMinutes"] = true,
				["colBar"] = {
					0.125490196078431, -- [1]
					0.125490196078431, -- [2]
					0.125490196078431, -- [3]
					0.870000004768372, -- [4]
				},
				["rotateicon"] = 0,
				["bShowLat"] = false,
				["bWordWrapNfs"] = false,
				["anchor"] = {
					["px"] = 0.501562436421712,
					["py"] = 0.592592659572196,
				},
				["bEnShadowCol"] = true,
				["colLagBar"] = {
					0.901960784313726, -- [1]
					0.0627450980392157, -- [2]
					0.0627450980392157, -- [3]
					0.490000009536743, -- [4]
				},
				["anchorframe"] = "",
				["spectab"] = {
					true, -- [1]
					true, -- [2]
					true, -- [3]
					true, -- [4]
				},
				["bEnShadowOffset"] = true,
				["colSpark"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["anchorfrom"] = 5,
				["coord"] = {
					["casttime"] = {
						["y"] = 0,
						["x"] = -7,
					},
					["shadow"] = {
						["y"] = -1,
						["x"] = 1,
					},
					["castname"] = {
						["y"] = 0,
						["x"] = 4.5,
					},
					["casticon"] = {
						["y"] = 0,
						["x"] = -3,
					},
					["latency"] = {
						["y"] = 1,
						["x"] = -1,
					},
				},
				["cboptver"] = 4.62,
				["colText"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["bordericon"] = 1,
				["height"] = 22,
				["fontsize_lat"] = 15,
				["colBorder"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["bColSuc"] = false,
				["scaleicon"] = 1,
				["strata"] = "HIGH",
				["bEn"] = true,
				["bInvDir"] = false,
				["colTextTime"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["bShowPlayerLatency"] = false,
				["border"] = 1.4,
				["rotatertext"] = 0,
				["bShowCBS"] = true,
				["forcefreealign"] = false,
				["bartype"] = "cb",
				["iconside"] = "LEFT",
				["bChanAsNorm"] = false,
				["bExtChannels"] = true,
				["strTimeFormat"] = "col<1,0,0>p<2s>col<pre> r<1m>",
				["alignlat"] = "ADAPT",
				["bUnlocked"] = false,
				["bShowWNC"] = false,
				["fontoutline"] = "NONE",
				["relationsel"] = 1,
				["ingroupsel"] = 1,
				["anchor_x"] = 0,
				["bResizeLongName"] = false,
				["width"] = 170,
				["latbarfixed"] = 0.03,
				["latbarsize"] = 0.15,
				["alignment"] = "NAMETIME",
				["bFillup"] = false,
				["orient"] = 1,
				["scale"] = 1,
				["bnwlist"] = {
				},
				["bIconUnlocked"] = false,
			},
		},
		["ct"] = {
			["bfile"] = false,
			["addon"] = "Blizz",
			["bsound"] = true,
			["bmusic"] = false,
			["ctt"] = 300,
			["wfcl"] = 1000,
			["sound"] = "MONEYFRAMEOPEN",
			["channel"] = 1,
		},
		["maintab"] = {
			["bHideAddonMsgs"] = false,
			["bAutoCreateOptions"] = true,
			["bHideMirror"] = false,
			["bResizeOptions"] = true,
			["bHideBlizz"] = false,
			["bHidePetVeh"] = false,
			["strLocale"] = "default",
			["iTimerScanEvery"] = 150,
			["bAddonEn"] = true,
		},
	},
}

end
