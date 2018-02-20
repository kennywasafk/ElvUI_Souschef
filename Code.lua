--Don't worry about this
local addon, ns = ...
local Version = GetAddOnMetadata(addon, "Version")

--Cache Lua / WoW API
local format = string.format
local GetCVarBool = GetCVarBool
local ReloadUI = ReloadUI
local StopMusic = StopMusic
local match = string.match
local gsub = string.gsub

local FCF_ResetChatWindows = FCF_ResetChatWindows
local FCF_SetLocked = FCF_SetLocked
local FCF_DockFrame = FCF_DockFrame
local FCF_OpenNewWindow = FCF_OpenNewWindow
local FCF_GetChatWindowInfo = FCF_GetChatWindowInfo
local FCF_SavePositionAndDimensions = FCF_SavePositionAndDimensions
local FCF_StopDragging = FCF_StopDragging
local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
local FCF_SetWindowName = FCF_SetWindowName
local ChatFrame_RemoveMessageGroup = ChatFrame_RemoveMessageGroup
local ChatFrame_RemoveAllMessageGroups = ChatFrame_RemoveAllMessageGroups
local ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
local ToggleChatColorNamesByClassGroup = ToggleChatColorNamesByClassGroup


-- These are things we do not cache
-- GLOBALS: PluginInstallStepComplete, PluginInstallFrame

--Change this line and use a unique name for your plugin.
--local MyPluginName = "Souschef"

--Create references to ElvUI internals
local E, L, V, P, G = unpack(ElvUI)

--Create reference to LibElvUIPlugin
local EP = LibStub("LibElvUIPlugin-1.0")

--Create a new ElvUI module so ElvUI can handle initialization when ready
--local mod = E:NewModule(MyPluginName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");
local modName = "Souschef"
local mod = E:GetModule(modName);

local NP = E:GetModule("NamePlates")

local selectedLayout = "Healer"

local function SetupChat()
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_OpenNewWindow(LOOT)
	FCF_DockFrame(ChatFrame3)
	FCF_SetLocked(ChatFrame3, 1)

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		local chatFrameId = frame:GetID()
		local chatName = FCF_GetChatWindowInfo(chatFrameId)

		-- move general bottom left
		if i == 1 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", LeftChatToggleButton, "TOPLEFT", 1, 3)
		end

		FCF_SavePositionAndDimensions(frame)
		FCF_StopDragging(frame)

		-- set default Elvui font size
		FCF_SetChatWindowFontSize(nil, frame, 13)

		-- rename chat windows
		if i == 1 then
			FCF_SetWindowName(frame, "All")
		elseif i == 2 then
			FCF_SetWindowName(frame, GUILD_EVENT_LOG)
		end
	end

	-- Set up the "All" chat frame to filter out stuff shown in the Loot chat frame
	ChatFrame_RemoveMessageGroup(ChatFrame1, "COMBAT_XP_GAIN")
	ChatFrame_RemoveMessageGroup(ChatFrame1, "COMBAT_HONOR_GAIN")
	ChatFrame_RemoveMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")
	ChatFrame_RemoveMessageGroup(ChatFrame1, "LOOT")
	ChatFrame_RemoveMessageGroup(ChatFrame1, "MONEY")

	-- Set up the Loot chat frame
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")

	-- Enable classcolor automatically on login and on each character without doing /configure each time.
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL11")

	if E.Chat then
		E.Chat:PositionChat(true)
		if E.db['RightChatPanelFaded'] then
			RightChatToggleButton:Click()
		end

		if E.db['LeftChatPanelFaded'] then
			LeftChatToggleButton:Click()
		end
	end

	PluginInstallStepComplete.message = L["Chat Set"]
	PluginInstallStepComplete:Show()
end

--This function will hold your layout settings
local function SetupLayout(layout)
	selectedLayout = layout

	--Set up various settings shared across all layouts

	--[[----------------------------------
	--	PrivateDB - General
	--]]----------------------------------
	E.private["bags"]["enable"] = true
	E.private["theme"] = "default"
	E.private["general"]["glossTex"] = "Flatt"
	E.private["general"]["normTex"] = "Flatt"
	E.private["general"]["namefont"] = "Expressway"
	E.private["general"]["dmgfont"] = "Expressway"
	if IsAddOnLoaded("ElvUI_SLE") then
		E.private["sle"]["module"]["screensaver"] = true
		E.private["sle"]["minimap"]["mapicons"]["enable"] = true
		E.private["sle"]["minimap"]["mapicons"]["barenable"] = true
		E.private["sle"]["minimap"]["mapicons"]["template"] = "NoBackdrop"
		E.private["sle"]["skins"]["merchant"]["enable"] = true
		E.private["sle"]["skins"]["merchant"]["style"] = "List"
		E.private["sle"]["install_complete"] = "3.34"
		E.private["sle"]["actionbars"]["transparentBackdrop"] = true
	end

	--[[----------------------------------
	--	GlobalDB - General
	--]]----------------------------------
	E.global["uiScale"] = "1.0"
	E.global["userInformedNewChanges1"] = true
	E.global["general"]["eyefinity"] = true
	E.global["general"]["animateConfig"] = false
	E.global["general"]["fadeMapWhenMoving"] = false
	E.global["general"]["commandBarSetting"] = "DISABLED"
	E.global["general"]["WorldMapCoordinates"]["yOffset"] = -22
	E.global["general"]["WorldMapCoordinates"]["position"] = "TOPLEFT"
	if IsAddOnLoaded("ElvUI_SLE") then
		E.global["sle"]["advanced"]["gameMenu"]["enable"] = false
		E.global["sle"]["advanced"]["optionsLimits"] = true
		E.global["sle"]["advanced"]["cyrillics"]["commands"] = true
		E.global["sle"]["advanced"]["general"] = true
		E.global["sle"]["advanced"]["confirmed"] = true
	end

	--The next section is for all the layout stuff
	--[[----------------------------------
	--	Set Up the Layout
	--]]--

	--Misc
	E.db["currentTutorial"] = 3
	E.db["hideTutorial"] = true
	E.db["layoutSet"] = "healer"
	E.db["thinBorderColorSet"] = true
	E.db["bossAuraFiltersConverted"] = true
	--General
	E.db["general"]["loginmessage"] = false
	E.db["general"]["threat"]["enable"] = false
	E.db["general"]["stickyFrames"] = false
	E.db["general"]["backdropcolor"]["r"] = 0.10196078431373
	E.db["general"]["backdropcolor"]["g"] = 0.10196078431373
	E.db["general"]["backdropcolor"]["b"] = 0.10196078431373
	E.db["general"]["topPanel"] = false
	E.db["general"]["afk"] = false
	E.db["general"]["autoRepair"] = "GUILD"
	E.db["general"]["minimap"]["size"] = 128
	E.db["general"]["minimap"]["locationFont"] = "HaxrCorp12cyr"
	E.db["general"]["minimap"]["locationText"] = "HIDE"
	E.db["general"]["minimap"]["locationFontSize"] = 16
	E.db["general"]["minimap"]["locationFontOutline"] = "MONOCHROMEOUTLINE"
	E.db["general"]["minimap"]["icons"]["difficulty"]["yOffset"] = -23
	E.db["general"]["minimap"]["icons"]["lfgEye"]["scale"] = 1.05
	E.db["general"]["minimap"]["icons"]["lfgEye"]["position"] = "TOPRIGHT"
	E.db["general"]["minimap"]["icons"]["lfgEye"]["xOffset"] = -19
	E.db["general"]["minimap"]["icons"]["lfgEye"]["yOffset"] = -1
	E.db["general"]["minimap"]["icons"]["ticket"]["xOffset"] = -1
	E.db["general"]["minimap"]["icons"]["ticket"]["scale"] = 0.85
	E.db["general"]["minimap"]["icons"]["ticket"]["yOffset"] = -33
	E.db["general"]["minimap"]["icons"]["calendar"]["scale"] = 0.7
	E.db["general"]["minimap"]["icons"]["calendar"]["xOffset"] = -2
	E.db["general"]["minimap"]["icons"]["calendar"]["yOffset"] = -3
	E.db["general"]["minimap"]["icons"]["mail"]["xOffset"] = -1
	E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = -27
	E.db["general"]["minimap"]["icons"]["challengeMode"]["scale"] = 0.5
	E.db["general"]["minimap"]["icons"]["challengeMode"]["position"] = "BOTTOMLEFT"
	E.db["general"]["minimap"]["icons"]["challengeMode"]["xOffset"] = 0
	E.db["general"]["minimap"]["icons"]["challengeMode"]["yOffset"] = 0
	E.db["general"]["minimap"]["icons"]["classHall"]["scale"] = 0.7
	E.db["general"]["minimap"]["icons"]["classHall"]["xOffset"] = 2
	E.db["general"]["minimap"]["icons"]["classHall"]["yOffset"] = -4
	E.db["general"]["minimap"]["icons"]["classHall"]["position"] = "BOTTOMRIGHT"
	E.db["general"]["talkingHeadFrameScale"] = 0.75
	E.db["general"]["font"] = "Expressway"
	E.db["general"]["bottomPanel"] = false
	E.db["general"]["backdropfadecolor"]["a"] = 0.53000000119209
	E.db["general"]["backdropfadecolor"]["r"] = 0.098039215686274
	E.db["general"]["backdropfadecolor"]["g"] = 0.10196078431373
	E.db["general"]["backdropfadecolor"]["b"] = 0.098039215686274
	E.db["general"]["objectiveFrameHeight"] = 740
	E.db["general"]["valuecolor"]["a"] = 1
	E.db["general"]["valuecolor"]["r"] = 0.95294117647059
	E.db["general"]["valuecolor"]["g"] = 0.76470588235294
	E.db["general"]["valuecolor"]["b"] = 0.11372549019608
	E.db["general"]["bordercolor"]["r"] = 0
	E.db["general"]["bordercolor"]["g"] = 0
	E.db["general"]["bordercolor"]["b"] = 0
	E.db["general"]["totems"]["enable"] = false
	E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
	E.db["general"]["totems"]["size"] = 32
	E.db["general"]["totems"]["spacing"] = 3
	E.db["general"]["backdropcolor"] = {
		["r"] = 0.125490196078431,
		["g"] = 0.125490196078431,
		["b"] = 0.125490196078431,
	}
	--Bags
	E.db["bags"]["countFontSize"] = 15
	E.db["bags"]["itemLevelFont"] = "HaxrCorp12cyr"
	E.db["bags"]["currencyFormat"] = "ICON"
	E.db["bags"]["itemLevelFontSize"] = 15
	E.db["bags"]["junkIcon"] = true
	E.db["bags"]["countFont"] = "HaxrCorp12cyr"
	E.db["bags"]["clearSearchOnClose"] = true
	E.db["bags"]["bankSize"] = 27
	E.db["bags"]["bankWidth"] = 390
	E.db["bags"]["moneyFormat"] = "CONDENSED"
	E.db["bags"]["bagWidth"] = 375
	E.db["bags"]["moneyCoins"] = false
	E.db["bags"]["useTooltipScanning"] = true
	E.db["bags"]["bagSize"] = 27
	--Chat
	E.db["chat"]["fontSize"] = 12
	E.db["chat"]["emotionIcons"] = false
	E.db["chat"]["keywordSound"] = "None"
	E.db["chat"]["tabFont"] = "Expressway"
	E.db["chat"]["tabFontSize"] = 14
	E.db["chat"]["editBoxPosition"] = "ABOVE_CHAT"
	E.db["chat"]["panelTabTransparency"] = true
	E.db["chat"]["panelHeight"] = 170
	E.db["chat"]["panelWidthRight"] = 400
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["numScrollMessages"] = 1
	E.db["chat"]["font"] = "Expressway"
	E.db["chat"]["noAlertInCombat"] = true
	E.db["chat"]["panelTabBackdrop"] = true
	E.db["chat"]["timeStampFormat"] = "%H:%M "
	E.db["chat"]["tabFontOutline"] = "NONE"
	E.db["chat"]["tapFontSize"] = 12
	E.db["chat"]["panelWidth"] = 411
	--Movers
	E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-8,-4"
	E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-170,3"
	E.db["movers"]["LootFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,248"
	E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,132,115"
	E.db["movers"]["ReputationBarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-192"
	E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-60,-88"
	E.db["movers"]["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,0,194"
	E.db["movers"]["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,397,284"
	E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,2,0"
	E.db["movers"]["LocationMover"] = "TOP,ElvUIParent,TOP,-1,-4"
	E.db["movers"]["SLE_UIButtonsMover"] = "TOP,ElvUIParent,TOP,0,-32"
	E.db["movers"]["OzCooldownsMover"] = "BOTTOM,ElvUIParent,BOTTOM,-10,169"
	E.db["movers"]["ExperienceBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,69"
	E.db["movers"]["SLE_DataPanel_2_Mover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-18,-510"
	E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,2,171"
	E.db["movers"]["SLE_DataPanel_1_Mover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-25,-486"
	E.db["movers"]["TotemBarMover"] = "TOP,ElvUIParent,TOP,-97,-389"
	E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,298"
	E.db["movers"]["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,45,505"
	E.db["movers"]["SLE_DataPanel_4_Mover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-12,-460"
	E.db["movers"]["LevelUpBossBannerMover"] = "TOP,ElvUIParent,TOP,2,-286"
	E.db["movers"]["SLE_DataPanel_8_Mover"] = "TOP,ElvUIParent,TOP,1,0"
	E.db["movers"]["HonorBarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-200"
	E.db["movers"]["PvPMover"] = "TOP,ElvUIParent,TOP,1,-94"
	E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,393"
	E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,46"
	E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,24"
	E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,2"
	E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,331"
	E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,228,2"
	E.db["movers"]["ElvAB_6"] = "TOPLEFT,ElvUIParent,TOPLEFT,2,-140"
	E.db["movers"]["MinimapMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,2,-1"
	E.db["movers"]["SquareMinimapBar"] = "TOPLEFT,ElvUIParent,TOPLEFT,132,-1"
	E.db["movers"]["ArtifactBarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-132"
	--Tooltip
	E.db["tooltip"]["itemCount"] = "BOTH"
	E.db["tooltip"]["healthBar"]["height"] = 3
	E.db["tooltip"]["healthBar"]["font"] = "Expressway"
	E.db["tooltip"]["healthBar"]["fontSize"] = 16
	E.db["tooltip"]["healthBar"]["text"] = false
	E.db["tooltip"]["headerFontSize"] = 13
	E.db["tooltip"]["font"] = "Expressway"
	E.db["tooltip"]["visibility"]["combat"] = true
	E.db["tooltip"]["fontSize"] = 12
	E.db["tooltip"]["guildRanks"] = false
	E.db["tooltip"]["playerTitles"] = false
	E.db["tooltip"]["spellID"] = false
	--Auras
	E.db["auras"]["timeXOffset"] = 2
	E.db["auras"]["fontSize"] = 12
	E.db["auras"]["countYOffset"] = 19
	E.db["auras"]["timeYOffset"] = -2
	E.db["auras"]["font"] = "Expressway"
	E.db["auras"]["fontOutline"] = "NONE"
	E.db["auras"]["buffs"]["sortDir"] = "+"
	E.db["auras"]["buffs"]["seperateOwn"] = 0
	E.db["auras"]["buffs"]["horizontalSpacing"] = 3
	E.db["auras"]["buffs"]["maxWraps"] = 2
	E.db["auras"]["buffs"]["verticalSpacing"] = 15
	E.db["auras"]["buffs"]["size"] = 26
	E.db["auras"]["buffs"]["wrapAfter"] = 18
	E.db["auras"]["countXOffset"] = -18
	E.db["auras"]["debuffs"]["horizontalSpacing"] = 3
	E.db["auras"]["debuffs"]["wrapAfter"] = 6
	E.db["auras"]["debuffs"]["size"] = 26
	E.db["auras"]["debuffs"]["growthDirection"] = "RIGHT_DOWN"
	--Databars
	E.db["databars"]["artifact"]["height"] = 7
	E.db["databars"]["artifact"]["hideInCombat"] = true
	E.db["databars"]["artifact"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["artifact"]["textSize"] = 22
	E.db["databars"]["artifact"]["width"] = 130
	E.db["databars"]["experience"]["height"] = 7
	E.db["databars"]["experience"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["experience"]["width"] = 263
	E.db["databars"]["honor"]["enable"] = false
	E.db["databars"]["honor"]["height"] = 7
	E.db["databars"]["honor"]["hideInCombat"] = true
	E.db["databars"]["honor"]["mouseover"] = true
	E.db["databars"]["honor"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["honor"]["reverseFill"] = true
	E.db["databars"]["honor"]["width"] = 130
	E.db["databars"]["reputation"]["height"] = 7
	E.db["databars"]["reputation"]["hideInCombat"] = true
	E.db["databars"]["reputation"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["reputation"]["reverseFill"] = false
	E.db["databars"]["reputation"]["width"] = 130
	--Datatexts
	E.db["datatexts"]["currencies"]["displayedCurrency"] = "ANCIENT_MANA"
	E.db["datatexts"]["font"] = "Expressway"
	E.db["datatexts"]["fontSize"] = 14
	E.db["datatexts"]["goldFormat"] = "CONDENSED"
	E.db["datatexts"]["leftChatPanel"] = false
	E.db["datatexts"]["minimapPanels"] = false
	E.db["datatexts"]["panels"]["BottomLeftMiniPanel"] = "Attack Power"
	E.db["datatexts"]["panels"]["BottomRightMiniPanel"] = "Bags"
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = "System"
	E.db["datatexts"]["panels"]["LeftMiniPanel"] = "Time"
	E.db["datatexts"]["panels"]["RightMiniPanel"] = "Gold"
	E.db["datatexts"]["panelTransparency"] = true
	E.db["datatexts"]["rightChatPanel"] = false
	E.db["datatexts"]["time24"] = false
	--ActionBars
	E.db["actionbar"]["backdropSpacingConverted"] = true
	E.db["actionbar"]["desaturateOnCooldown"] = true
	E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar1"]["buttonsize"] = 21
	E.db["actionbar"]["bar1"]["buttonspacing"] = 1
	E.db["actionbar"]["bar1"]["point"] = "TOPLEFT"
	E.db["actionbar"]["bar1"]["visibility"] = "[petbattle] hide; show"
	E.db["actionbar"]["bar2"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar2"]["buttonsize"] = 21
	E.db["actionbar"]["bar2"]["buttonspacing"] = 1
	E.db["actionbar"]["bar2"]["enabled"] = true
	E.db["actionbar"]["bar2"]["point"] = "TOPLEFT"
	E.db["actionbar"]["bar3"]["buttons"] = 12
	E.db["actionbar"]["bar3"]["buttonsize"] = 21
	E.db["actionbar"]["bar3"]["buttonspacing"] = 1
	E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar3"]["point"] = "TOPLEFT"
	E.db["actionbar"]["bar4"]["backdrop"] = false
	E.db["actionbar"]["bar4"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar4"]["buttons"] = 10
	E.db["actionbar"]["bar4"]["buttonsize"] = 30
	E.db["actionbar"]["bar4"]["buttonspacing"] = 1
	E.db["actionbar"]["bar4"]["buttonsPerRow"] = 5
	E.db["actionbar"]["bar4"]["enabled"] = true
	E.db["actionbar"]["bar5"]["buttons"] = 12
	E.db["actionbar"]["bar5"]["buttonsize"] = 29
	E.db["actionbar"]["bar5"]["buttonspacing"] = 1
	E.db["actionbar"]["bar5"]["buttonsPerRow"] = 6
	E.db["actionbar"]["bar5"]["mouseover"] = true
	E.db["actionbar"]["bar5"]["alpha"] = 1.00
	E.db["actionbar"]["bar5"]["backdrop"] = true
	E.db["actionbar"]["bar6"]["buttons"] = 10
	E.db["actionbar"]["bar6"]["buttonsize"] = 25
	E.db["actionbar"]["bar6"]["buttonspacing"] = 1
	E.db["actionbar"]["bar6"]["buttonsPerRow"] = 5
	E.db["actionbar"]["bar6"]["enabled"] = true
	E.db["actionbar"]["bar6"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [combat] hide; show"
	E.db["actionbar"]["barPet"]["backdrop"] = false
	E.db["actionbar"]["barPet"]["buttonsize"] = 22
	E.db["actionbar"]["barPet"]["buttonspacing"] = 1
	E.db["actionbar"]["barPet"]["buttonsPerRow"] = 5
	E.db["actionbar"]["font"] = "Expressway"
	E.db["actionbar"]["fontOutline"] = "NONE"
	E.db["actionbar"]["fontSize"] = 12
	E.db["actionbar"]["globalFadeAlpha"] = 0.9
	E.db["actionbar"]["keyDown"] = false
	E.db["actionbar"]["microbar"]["backdrop"] = true
	E.db["actionbar"]["microbar"]["buttonsPerRow"] = 1
	E.db["actionbar"]["microbar"]["scale"] = 0.82
	E.db["actionbar"]["noPowerColor"]["b"] = 0.67058823529412
	E.db["actionbar"]["noPowerColor"]["g"] = 0.11764705882353
	E.db["actionbar"]["noPowerColor"]["r"] = 0.65490196078431
	E.db["actionbar"]["noRangeColor"]["b"] = 0.18823529411765
	E.db["actionbar"]["noRangeColor"]["g"] = 0.18823529411765
	E.db["actionbar"]["noRangeColor"]["r"] = 0.19607843137255
	E.db["actionbar"]["stanceBar"]["buttonsize"] = 23
	E.db["actionbar"]["stanceBar"]["enabled"] = false
	--Nameplates
	E.db["nameplates"]["alwaysShowTargetHealth"] = false
	E.db["nameplates"]["clickThrough"]["friendly"] = true
	E.db["nameplates"]["font"] = "Expressway"
	E.db["nameplates"]["fontOutline"] = "NONE"
	E.db["nameplates"]["fontSize"] = 15
	E.db["nameplates"]["glowColor"]["b"] = 0.93725490196078
	E.db["nameplates"]["glowColor"]["g"] = 1
	E.db["nameplates"]["glowColor"]["r"] = 0.96078431372549
	E.db["nameplates"]["loadDistance"] = 50
	E.db["nameplates"]["lowHealthThreshold"] = 0.3
	E.db["nameplates"]["motionType"] = "OVERLAP"
	E.db["nameplates"]["nonTargetTransparency"] = 0.65
	E.db["nameplates"]["statusbar"] = "Flatt"
	E.db["nameplates"]["targetGlow"] = "none"
	E.db["nameplates"]["threat"]["useThreatColor"] = false
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["enable"] = false
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["baseHeight"] = 19
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["numAuras"] = 6
	E.db["nameplates"]["units"]["ENEMY_NPC"]["healthbar"]["width"] = 120
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["healthbar"]["text"]["enable"] = true
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["healthbar"]["width"] = 125
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["showLevel"] = false
	E.db["nameplates"]["units"]["HEALER"]["healthbar"]["enable"] = false
	E.db["nameplates"]["units"]["HEALER"]["showName"] = false
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["enable"] = false
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["enable"] = false
	E.db["nameplates"]["units"]["PLAYER"]["debuffs"]["enable"] = false
	E.db["nameplates"]["units"]["PLAYER"]["healthbar"]["height"] = 7
	E.db["nameplates"]["units"]["PLAYER"]["healthbar"]["width"] = 100
	E.db["nameplates"]["units"]["PLAYER"]["name"]["useClassColor"] = false
	E.db["nameplates"]["units"]["PLAYER"]["powerbar"]["enable"] = false
	E.db["nameplates"]["units"]["PLAYER"]["visibility"]["showAlways"] = true
	E.db["nameplates"]["useTargetGlow"] = false
	--UnitFrames
	E.db["unitframe"]["colors"]["healthclass"] = false
    E.db["unitframe"]["colors"]["castClassColor"] = false
	E.db["unitframe"]["colors"]["auraBarByType"] = false
	E.db["unitframe"]["colors"]["auraBarDebuff"]["b"] = 0.13725490196078
	E.db["unitframe"]["colors"]["auraBarDebuff"]["g"] = 0.062745098039216
	E.db["unitframe"]["colors"]["auraBarDebuff"]["r"] = 0.28627450980392
	E.db["unitframe"]["colors"]["castColor"]["b"] = 0.28235294117647
	E.db["unitframe"]["colors"]["castColor"]["g"] = 0.77254901960784
	E.db["unitframe"]["colors"]["castColor"]["r"] = 0.91372549019608
	E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
	E.db["unitframe"]["colors"]["customhealthbackdrop"] = true
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["b"] = 1
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["g"] = 0.89411764705882
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["r"] = 0.32549019607843
	E.db["unitframe"]["colors"]["health"]["b"] = 0.12549019607843
	E.db["unitframe"]["colors"]["health"]["g"] = 0.12549019607843
	E.db["unitframe"]["colors"]["health"]["r"] = 0.12549019607843
	E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0.42352941176471
	E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0.42352941176471
	E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0.42352941176471
	E.db["unitframe"]["colors"]["power"]["MANA"]["b"] = 0.85882352941176
	E.db["unitframe"]["colors"]["power"]["MANA"]["g"] = 0.78039215686274
	E.db["unitframe"]["colors"]["power"]["MANA"]["r"] = 0.34901960784314
	E.db["unitframe"]["colors"]["powerclass"] = true
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["b"] = 0.30588235294118
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["g"] = 0.31372549019608
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["r"] = 0.36862745098039
	E.db["unitframe"]["colors"]["useDeadBackdrop"] = true
	E.db["unitframe"]["font"] = "Expressway"
	E.db["unitframe"]["fontOutline"] = "NONE"
	E.db["unitframe"]["fontSize"] = 14
	E.db["unitframe"]["OORAlpha"] = 0.25
	E.db["unitframe"]["smoothbars"] = true
	E.db["unitframe"]["statusbar"] = "ElvUI Blank"
	E.db["unitframe"]["units"]["assist"]["enable"] = false
	E.db["unitframe"]["units"]["assist"]["targetsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["buffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["boss"]["castbar"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["debuffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["boss"]["debuffs"]["perrow"] = 2
	E.db["unitframe"]["units"]["boss"]["debuffs"]["priority"] = "Personal"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["sizeOverride"] = 19
	E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = 9
	E.db["unitframe"]["units"]["boss"]["growthDirection"] = "UP"
	E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["boss"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["spacing"] = 1
	E.db["unitframe"]["units"]["boss"]["targetGlow"] = false
	E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["focus"]["debuffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["focus"]["debuffs"]["sizeOverride"] = 28
	E.db["unitframe"]["units"]["focus"]["debuffs"]["xOffset"] = 191
	E.db["unitframe"]["units"]["focus"]["debuffs"]["yOffset"] = -28
	E.db["unitframe"]["units"]["focus"]["health"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["focus"]["health"]["yOffset"] = 3
	E.db["unitframe"]["units"]["focus"]["height"] = 35
	E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:medium]"
	E.db["unitframe"]["units"]["focus"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["focus"]["rangeCheck"] = false
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["buffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["party"]["buffs"]["noDuration"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["party"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["useFilter"] = "TurtleBuffs"
	E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["debuffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["party"]["debuffs"]["maxDuration"] = 3600
	E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = "AnnoyingShit,Dispellable,blockNoDuration"
	E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 33
	E.db["unitframe"]["units"]["party"]["debuffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["party"]["debuffs"]["useFilter"] = "AnnoyingShit"
	E.db["unitframe"]["units"]["party"]["debuffs"]["useWhitelist"] = true
	E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = -1
	E.db["unitframe"]["units"]["party"]["GPSArrow"] = {}
		E.db["unitframe"]["units"]["party"]["GPSArrow"]["size"] = 40
	E.db["unitframe"]["units"]["party"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["party"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["party"]["healPrediction"] = true
	E.db["unitframe"]["units"]["party"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["party"]["health"]["position"] = "BOTTOM"
	E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["height"] = 35
	E.db["unitframe"]["units"]["party"]["horizontalSpacing"] = -1
	E.db["unitframe"]["units"]["party"]["name"]["text_format"] = "[namecolor][name:short]"
	E.db["unitframe"]["units"]["party"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["party"]["name"]["yOffset"] = 1
	E.db["unitframe"]["units"]["party"]["orientation"] = "MIDDLE"
	E.db["unitframe"]["units"]["party"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["party"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["stack"]["color"]["g"] = 0.30980392156863
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["stack"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["stack"]["yOffset"] = 1
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 6
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["size"] = 17
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["xOffset"] = -22
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["roleIcon"]["damager"] = false
	E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["party"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 1
	E.db["unitframe"]["units"]["party"]["width"] = 110
	E.db["unitframe"]["units"]["pet"]["castbar"]["enable"] = false
	E.db["unitframe"]["units"]["pet"]["castbar"]["height"] = 10
	E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 115
	E.db["unitframe"]["units"]["pet"]["height"] = 25
	E.db["unitframe"]["units"]["pet"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["pet"]["name"]["yOffset"] = 2
	E.db["unitframe"]["units"]["pet"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["pet"]["width"] = 114
	E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["player"]["buffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["player"]["buffs"]["numrows"] = 3
	E.db["unitframe"]["units"]["player"]["buffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["player"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["sizeOverride"] = 26
	E.db["unitframe"]["units"]["player"]["buffs"]["sortMethod"] = "PLAYER"
	E.db["unitframe"]["units"]["player"]["buffs"]["xOffset"] = 13
	E.db["unitframe"]["units"]["player"]["buffs"]["yOffset"] = -1
	E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
	E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 154
	E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["health"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["health"]["text_format"] = "[health:current] • [health:percent]"
	E.db["unitframe"]["units"]["player"]["health"]["xOffset"] = 7
	E.db["unitframe"]["units"]["player"]["height"] = 32
	E.db["unitframe"]["units"]["player"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 154
	E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["power"]["xOffset"] = -60
	E.db["unitframe"]["units"]["player"]["pvp"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["RestIcon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["player"]["width"] = 154
	E.db["unitframe"]["units"]["raid"]["buffs"]["anchorPoint"] = "BOTTOMLEFT"
	E.db["unitframe"]["units"]["raid"]["buffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["raid"]["buffs"]["noDuration"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["raid"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid"]["buffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["useFilter"] = "TurtleBuffs"
	E.db["unitframe"]["units"]["raid"]["buffs"]["xOffset"] = 2
	E.db["unitframe"]["units"]["raid"]["buffs"]["yOffset"] = 28
	E.db["unitframe"]["units"]["raid"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["raid"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["raid"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["raid"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 1
	E.db["unitframe"]["units"]["raid"]["name"]["position"] = "TOPLEFT"
	E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid"]["name"]["xOffset"] = 4
	E.db["unitframe"]["units"]["raid"]["name"]["yOffset"] = -2
	E.db["unitframe"]["units"]["raid"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["raid"]["raidWideSorting"] = true
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["damager"] = false
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 1
	E.db["unitframe"]["units"]["raid40"]["healPrediction"] = true
	E.db["unitframe"]["units"]["raid40"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["raid40"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid40"]["height"] = 25
	E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 1
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["raid40"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 1
	E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_ON"
	E.db["unitframe"]["units"]["tank"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["height"] = 25
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["width"] = 100
	E.db["unitframe"]["units"]["target"]["aurabar"]["anchorPoint"] = "BELOW"
	E.db["unitframe"]["units"]["target"]["aurabar"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["aurabar"]["height"] = 22
	E.db["unitframe"]["units"]["target"]["aurabar"]["yOffset"] = 27
	E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["buffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["target"]["buffs"]["maxDuration"] = 7200
	E.db["unitframe"]["units"]["target"]["buffs"]["noDuration"] = {}
		E.db["unitframe"]["units"]["target"]["buffs"]["noDuration"]["enemy"] = true
		E.db["unitframe"]["units"]["target"]["buffs"]["noDuration"]["friendly"] = true
	E.db["unitframe"]["units"]["target"]["buffs"]["playerOnly"] = {}
		E.db["unitframe"]["units"]["target"]["buffs"]["playerOnly"]["friendly"] = true
	E.db["unitframe"]["units"]["target"]["buffs"]["priority"] = "blockNoDuration,Personal"
	E.db["unitframe"]["units"]["target"]["buffs"]["sizeOverride"] = 25
	E.db["unitframe"]["units"]["target"]["buffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["target"]["castbar"]["latency"] = false
	E.db["unitframe"]["units"]["target"]["debuffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["target"]["debuffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = 2
	E.db["unitframe"]["units"]["target"]["height"] = 35
	E.db["unitframe"]["units"]["target"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["target"]["middleClickFocus"] = false
	E.db["unitframe"]["units"]["target"]["name"]["xOffset"] = 1
	E.db["unitframe"]["units"]["target"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["smartAuraDisplay"] = "DISABLED"
	E.db["unitframe"]["units"]["target"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["targettarget"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["height"] = 25
	E.db["unitframe"]["units"]["targettarget"]["name"]["yOffset"] = 2
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 5
	E.db["unitframe"]["units"]["targettarget"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["targettarget"]["width"] = 125

	--[[
	Settings that rely on specific addons being present
	]]--
	--Shadow and Light
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["datatexts"]["panels"]["SLE_DataPanel_7"] = "Friends"
		E.db["datatexts"]["panels"]["SLE_DataPanel_8"]["middle"] = "Time"
		E.db["datatexts"]["panels"]["SLE_DataPanel_8"]["left"] = "AutoLog"
		if not E.db["sle"]["unitframes"]["unit"]["player"] then E.db["sle"]["unitframes"]["unit"]["player"] = {} end
			E.db["sle"]["unitframes"]["unit"]["player"]["rested"] = {}
			E.db["sle"]["unitframes"]["unit"]["player"]["rested"]["xoffset"] = -9
			E.db["sle"]["unitframes"]["unit"]["player"]["rested"]["yoffset"] = -15
		E.db["sle"]["Armory"]["Character"]["Artifact"]["Font"] = "HaxrCorp12cyr"
		E.db["sle"]["Armory"]["Character"]["Artifact"]["FontSize"] = 15
		E.db["sle"]["Armory"]["Character"]["Artifact"]["FontStyle"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["Armory"]["Character"]["Backdrop"]["Overlay"] = false
		E.db["sle"]["Armory"]["Character"]["Backdrop"]["SelectedBG"] = "HIDE"
		E.db["sle"]["Armory"]["Character"]["Durability"]["Display"] = "DamagedOnly"
		E.db["sle"]["Armory"]["Character"]["Durability"]["Font"] = "HaxrCorp12cyr"
		E.db["sle"]["Armory"]["Character"]["Durability"]["FontSize"] = 15
		E.db["sle"]["Armory"]["Character"]["Durability"]["FontStyle"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["Armory"]["Character"]["Enchant"]["Display"] = "MouseoverOnly"
		E.db["sle"]["Armory"]["Character"]["Enchant"]["Font"] = "HaxrCorp12cyr"
		E.db["sle"]["Armory"]["Character"]["Enchant"]["FontSize"] = 15
		E.db["sle"]["Armory"]["Character"]["Enchant"]["FontStyle"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["Armory"]["Character"]["Enchant"]["WarningIconOnly"] = true
		E.db["sle"]["Armory"]["Character"]["Enchant"]["WarningSize"] = 10
		E.db["sle"]["Armory"]["Character"]["Gradation"]["Color"][1] = 0.97647058823529
		E.db["sle"]["Armory"]["Character"]["Gradation"]["Color"][2] = 1
		E.db["sle"]["Armory"]["Character"]["Gradation"]["Color"][3] = 0.93725490196078
		E.db["sle"]["Armory"]["Character"]["Gradation"]["Color"][4] = 1
		E.db["sle"]["Armory"]["Character"]["Gradation"]["Display"] = false
		E.db["sle"]["Armory"]["Character"]["Level"]["Font"] = "HaxrCorp12cyr"
		E.db["sle"]["Armory"]["Character"]["Level"]["FontSize"] = 17
		E.db["sle"]["Armory"]["Character"]["Level"]["FontStyle"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["Armory"]["Character"]["MissingIcon"] = false
		E.db["sle"]["Armory"]["Character"]["Stats"]["AverageColor"]["a"] = 1
		E.db["sle"]["Armory"]["Character"]["Stats"]["AverageColor"]["b"] = 0.96862745098039
		E.db["sle"]["Armory"]["Character"]["Stats"]["AverageColor"]["r"] = 0.94901960784314
		E.db["sle"]["Armory"]["Character"]["Stats"]["IlvlColor"] = true
		E.db["sle"]["Armory"]["Character"]["Stats"]["ItemLevel"]["font"] = "Expressway"
		E.db["sle"]["Armory"]["Character"]["Stats"]["ItemLevel"]["size"] = 17
		E.db["sle"]["Armory"]["Character"]["Stats"]["List"]["HEALTH"] = true
		E.db["sle"]["Armory"]["Character"]["Stats"]["List"]["MOVESPEED"] = true
		E.db["sle"]["Armory"]["Character"]["Stats"]["List"]["POWER"] = true
		E.db["sle"]["Armory"]["Character"]["Stats"]["OnlyPrimary"] = false
		E.db["sle"]["Armory"]["Inspect"]["Backdrop"]["SelectedBG"] = "HIDE"
		E.db["sle"]["Armory"]["Inspect"]["Enable"] = false
		E.db["sle"]["Armory"]["Inspect"]["Enchant"]["Display"] = "MouseoverOnly"
		E.db["sle"]["Armory"]["Inspect"]["Enchant"]["Font"] = "HaxrCorp12cyr"
		E.db["sle"]["Armory"]["Inspect"]["Enchant"]["FontSize"] = 15
		E.db["sle"]["Armory"]["Inspect"]["Enchant"]["FontStyle"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["Armory"]["Inspect"]["Gem"]["Display"] = "MouseoverOnly"
		E.db["sle"]["Armory"]["Inspect"]["Gradation"]["Display"] = false
		E.db["sle"]["Armory"]["Inspect"]["Level"]["Font"] = "HaxrCorp12cyr"
		E.db["sle"]["Armory"]["Inspect"]["Level"]["FontSize"] = 17
		E.db["sle"]["Armory"]["Inspect"]["Level"]["FontStyle"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["Armory"]["Inspect"]["NoticeMissing"] = false
		E.db["sle"]["bags"]["artifactPower"]["enable"] = true
		E.db["sle"]["bags"]["artifactPower"]["fonts"]["font"] = "HaxrCorp12cyr"
		E.db["sle"]["bags"]["artifactPower"]["fonts"]["outline"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["bags"]["artifactPower"]["fonts"]["size"] = 15
		E.db["sle"]["chat"]["dpsSpam"] = true
		E.db["sle"]["chat"]["invite"]["altInv"] = true
		E.db["sle"]["chat"]["tab"]["select"] = true
		E.db["sle"]["chat"]["tab"]["style"] = "SQUARE"
		E.db["sle"]["databars"]["artifact"]["chatfilter"]["enable"] = true
		E.db["sle"]["databars"]["artifact"]["chatfilter"]["style"] = "STYLE2"
		E.db["sle"]["databars"]["honor"]["chatfilter"]["awardStyle"] = "STYLE2"
		E.db["sle"]["databars"]["honor"]["chatfilter"]["enable"] = true
		E.db["sle"]["databars"]["honor"]["chatfilter"]["style"] = "STYLE2"
		E.db["sle"]["databars"]["rep"]["chatfilter"]["enable"] = true
		E.db["sle"]["databars"]["rep"]["chatfilter"]["showAll"] = true
		E.db["sle"]["databars"]["rep"]["chatfilter"]["style"] = "STYLE2"
		E.db["sle"]["databars"]["rep"]["chatfilter"]["styleDec"] = "STYLE2"
		E.db["sle"]["datatexts"]["panel1"]["noback"] = true
		E.db["sle"]["datatexts"]["panel1"]["transparent"] = true
		E.db["sle"]["datatexts"]["panel1"]["width"] = 317
		E.db["sle"]["datatexts"]["panel2"]["noback"] = true
		E.db["sle"]["datatexts"]["panel2"]["transparent"] = true
		E.db["sle"]["datatexts"]["panel3"]["noback"] = true
		E.db["sle"]["datatexts"]["panel3"]["transparent"] = true
		E.db["sle"]["datatexts"]["panel4"]["noback"] = true
		E.db["sle"]["datatexts"]["panel8"]["enabled"] = true
		E.db["sle"]["datatexts"]["panel8"]["noback"] = true
		E.db["sle"]["datatexts"]["panel8"]["transparent"] = true
		E.db["sle"]["datatexts"]["panel8"]["width"] = 262
		E.db["sle"]["loot"]["announcer"]["enable"] = true
		E.db["sle"]["loot"]["autoroll"]["enable"] = false
		E.db["sle"]["loot"]["enable"] = true
		E.db["sle"]["media"]["fonts"]["editbox"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["editbox"]["size"] = 13
		E.db["sle"]["media"]["fonts"]["gossip"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["gossip"]["size"] = 13
		E.db["sle"]["media"]["fonts"]["mail"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["mail"]["size"] = 13
		E.db["sle"]["media"]["fonts"]["objective"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["objectiveHeader"]["size"] = 15
		E.db["sle"]["media"]["fonts"]["pvp"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["pvp"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["pvp"]["size"] = 19
		E.db["sle"]["media"]["fonts"]["questFontSuperHuge"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["subzone"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["subzone"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["subzone"]["size"] = 19
		E.db["sle"]["media"]["fonts"]["zone"]["font"] = "Expressway"
		E.db["sle"]["media"]["fonts"]["zone"]["outline"] = "NONE"
		E.db["sle"]["media"]["fonts"]["zone"]["size"] = 20
		E.db["sle"]["minimap"]["coords"]["font"] = "HaxrCorp12cyr"
		E.db["sle"]["minimap"]["coords"]["fontSize"] = 16
		E.db["sle"]["minimap"]["coords"]["format"] = "%.1f"
		E.db["sle"]["minimap"]["coords"]["position"] = "BOTTOMRIGHT"
		E.db["sle"]["minimap"]["instance"]["colors"]["challenge"]["a"] = 1
		E.db["sle"]["minimap"]["instance"]["colors"]["challenge"]["b"] = 0.12156862745098
		E.db["sle"]["minimap"]["instance"]["colors"]["challenge"]["g"] = 0.59607843137255
		E.db["sle"]["minimap"]["instance"]["colors"]["challenge"]["r"] = 0.90196078431373
		E.db["sle"]["minimap"]["instance"]["colors"]["heroic"]["a"] = 1
		E.db["sle"]["minimap"]["instance"]["colors"]["heroic"]["b"] = 0.88235294117647
		E.db["sle"]["minimap"]["instance"]["colors"]["heroic"]["g"] = 0.70196078431373
		E.db["sle"]["minimap"]["instance"]["colors"]["heroic"]["r"] = 0.37254901960784
		E.db["sle"]["minimap"]["instance"]["colors"]["lfr"]["a"] = 1
		E.db["sle"]["minimap"]["instance"]["colors"]["lfr"]["b"] = 0.89019607843137
		E.db["sle"]["minimap"]["instance"]["colors"]["lfr"]["g"] = 0.95294117647059
		E.db["sle"]["minimap"]["instance"]["colors"]["lfr"]["r"] = 0.92941176470588
		E.db["sle"]["minimap"]["instance"]["colors"]["mythic"]["a"] = 1
		E.db["sle"]["minimap"]["instance"]["colors"]["mythic"]["b"] = 0.90196078431373
		E.db["sle"]["minimap"]["instance"]["colors"]["mythic"]["g"] = 0.30980392156863
		E.db["sle"]["minimap"]["instance"]["colors"]["mythic"]["r"] = 0.62745098039216
		E.db["sle"]["minimap"]["instance"]["colors"]["normal"]["a"] = 1
		E.db["sle"]["minimap"]["instance"]["colors"]["normal"]["b"] = 0.55686274509804
		E.db["sle"]["minimap"]["instance"]["colors"]["normal"]["g"] = 0.81960784313725
		E.db["sle"]["minimap"]["instance"]["colors"]["normal"]["r"] = 0.49803921568628
		E.db["sle"]["minimap"]["instance"]["colors"]["time"]["a"] = 1
		E.db["sle"]["minimap"]["instance"]["colors"]["time"]["b"] = 0.9921568627451
		E.db["sle"]["minimap"]["instance"]["colors"]["time"]["g"] = 0.51372549019608
		E.db["sle"]["minimap"]["instance"]["colors"]["time"]["r"] = 0.090196078431373
		E.db["sle"]["minimap"]["instance"]["enable"] = true
		E.db["sle"]["minimap"]["instance"]["font"] = "HaxrCorp12cyr"
		E.db["sle"]["minimap"]["instance"]["fontOutline"] = "MONOCHROMEOUTLINE"
		E.db["sle"]["minimap"]["instance"]["fontSize"] = 17
		E.db["sle"]["minimap"]["mapicons"]["enable"] = true
		E.db["sle"]["minimap"]["mapicons"]["iconsize"] = 25
		E.db["sle"]["minimap"]["mapicons"]["spacing"] = 1
		E.db["sle"]["minimap"]["mapicons"]["iconperrow"] = 1
		E.db["sle"]["misc"]["threat"]["position"] = "LeftChatDataPanel"
		E.db["sle"]["nameplates"]["targetcount"]["enable"] = true
		E.db["sle"]["pvp"]["autorelease"] = true
		E.db["sle"]["quests"]["visibility"]["arena"] = "HIDE"
		E.db["sle"]["quests"]["visibility"]["dungeon"] = "HIDE"
		E.db["sle"]["quests"]["visibility"]["enable"] = true
		E.db["sle"]["quests"]["visibility"]["raid"] = "FULL"
		E.db["sle"]["raidmanager"]["roles"] = true
		E.db["sle"]["raidmarkers"]["orientation"] = "VERTICAL"
		E.db["sle"]["raidmarkers"]["spacing"] = 1
		E.db["sle"]["raidmarkers"]["visibility"] = "INPARTY"
		E.db["sle"]["screensaver"]["crest"]["size"] = 84
		E.db["sle"]["screensaver"]["date"]["font"] = "Expressway"
		E.db["sle"]["screensaver"]["date"]["outline"] = "NONE"
		E.db["sle"]["screensaver"]["player"]["font"] = "Expressway"
		E.db["sle"]["screensaver"]["player"]["outline"] = "NONE"
		E.db["sle"]["screensaver"]["playermodel"]["rotation"] = 290
		E.db["sle"]["screensaver"]["subtitle"]["font"] = "Expressway"
		E.db["sle"]["screensaver"]["subtitle"]["outline"] = "NONE"
		E.db["sle"]["screensaver"]["tips"]["font"] = "Expressway"
		E.db["sle"]["screensaver"]["tips"]["outline"] = "NONE"
		E.db["sle"]["screensaver"]["title"]["font"] = "Expressway"
		E.db["sle"]["screensaver"]["title"]["outline"] = "NONE"
		E.db["sle"]["screensaver"]["xpack"] = 100
		E.db["sle"]["skins"]["objectiveTracker"]["colorHeader"]["b"] = 0.9843137254902
		E.db["sle"]["skins"]["objectiveTracker"]["colorHeader"]["g"] = 1
		E.db["sle"]["skins"]["objectiveTracker"]["colorHeader"]["r"] = 0.97254901960784
		E.db["sle"]["skins"]["objectiveTracker"]["underlineColor"]["b"] = 1
		E.db["sle"]["skins"]["objectiveTracker"]["underlineColor"]["g"] = 1
		E.db["sle"]["tooltip"]["yOffset"] = 14
		E.db["sle"]["uibuttons"]["orientation"] = "horizontal"
		E.db["sle"]["uibuttons"]["spacing"] = 2
	end

	--CustomTweaks
	if IsAddOnLoaded("ElvUI_CustomTweaks") then
		E.db["CustomTweaks"]["AuraIconText"]["durationTextOffsetX"] = 1
		E.db["CustomTweaks"]["AuraIconText"]["durationTextOffsetY"] = 0
		E.db["CustomTweaks"]["AuraIconText"]["durationTextPos"] = "CENTER"
		E.db["CustomTweaks"]["AuraIconText"]["stackTextPos"] = "TOPRIGHT"
	end

	--EverySecondCounts
	if IsAddOnLoaded("ElvUI_EverySecondCounts") then
		E.db["ESC"]["font"] = "Expressway"
		E.db["ESC"]["textOffsetY"] = 0
		E.db["ESC"]["textOffsetX"] = 2
	end

	--GarrisonOrderHall
	if IsAddOnLoaded("Broker_Garrison") then
		E.db["datatexts"]["panels"]["TopLeftMiniPanel"] = "Broker_GarrisonOrderhall"
		E.db["datatexts"]["panels"]["TopMiniPanel"] = "Broker_GarrisonOrderhall"
	end

	--Altoholic
	if IsAddOnLoaded("Altoholic") then
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Altoholic"
	end

	--Layout: DPS
	if layout == "dps" or layout == "tank" then
		--make some changes here
		E.db["bags"]["itemLevelThreshold"] = 850
		--Movers
		E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,3,300"
		E.db["movers"]["ElvUF_FocusMover"] = "TOP,ElvUIParent,TOP,212,-386"
		E.db["movers"]["ElvUF_TargetMover"] = "TOP,ElvUIParent,TOP,212,-472"
		E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,3,430"
		E.db["movers"]["ElvUF_TargetCastbarMover"] = "TOP,ElvUIParent,TOP,212,-508"
		E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-11,401"
		E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,-136,367"
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,3,430"
		E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-135,393"
		E.db["movers"]["RaidMarkerBarAnchor"] = "TOPLEFT,ElvUIParent,TOPLEFT,5,-369"
		E.db["movers"]["ZoneAbility"] = "BOTTOM,ElvUIParent,BOTTOM,-170,3"
		E.db["movers"]["VehicleSeatMover"] = "BOTTOM,ElvUIParent,BOTTOM,160,256"
		E.db["movers"]["LossControlMover"] = "BOTTOM,ElvUIParent,BOTTOM,-2,467"
		E.db["movers"]["AltPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-1,229"
		E.db["movers"]["RaidUtility_Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,432,2"
		E.db["movers"]["ArenaHeaderMover"] = "TOP,ElvUIParent,TOP,-265,-443"
		E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-205,2"
		E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,130"
		E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-136,320"
		E.db["movers"]["GMMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,130"
		E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,401"
		E.db["movers"]["MicrobarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-2,112"
		E.db["movers"]["BNETMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,130"
		E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,3,171"
		E.db["movers"]["UIErrorsFrameMover"] = "TOP,ElvUIParent,TOP,6,-432"
		E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-1,91"
		E.db["movers"]["BossHeaderMover"] = "BOTTOM,ElvUIParent,BOTTOM,212,368"

		E.db["movers"]["AlertFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,198"
		E.db["movers"]["DebuffsMover"] = "BOTTOM,ElvUIParent,BOTTOM,166,237"

		--Auras
		E.db["auras"]["debuffs"]["verticalSpacing"] = 3
		E.db["auras"]["debuffs"]["maxWraps"] = 3
		--Nameplates
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["showName"] = false
		--UnitFrames
		E.db["unitframe"]["units"]["arena"]["buffs"]["enable"] = false
		E.db["unitframe"]["units"]["arena"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["arena"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["arena"]["height"] = 35
		E.db["unitframe"]["units"]["arena"]["power"]["height"] = 4
		E.db["unitframe"]["units"]["arena"]["pvpTrinket"]["xOffset"] = 14
		E.db["unitframe"]["units"]["arena"]["spacing"] = 1
		E.db["unitframe"]["units"]["arena"]["width"] = 150
		E.db["unitframe"]["units"]["boss"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = -1
		E.db["unitframe"]["units"]["boss"]["height"] = 35
		E.db["unitframe"]["units"]["boss"]["width"] = 150
		E.db["unitframe"]["units"]["focus"]["castbar"]["enable"] = false
		E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 150
		E.db["unitframe"]["units"]["focus"]["power"]["enable"] = false
		E.db["unitframe"]["units"]["focus"]["width"] = 150
		E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 22
		E.db["unitframe"]["units"]["party"]["buffs"]["xOffset"] = 50
		E.db["unitframe"]["units"]["party"]["buffs"]["yOffset"] = -6
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFontSize"] = 18
		E.db["unitframe"]["units"]["party"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["party"]["debuffs"]["fontSize"] = 16
		E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 1
		E.db["unitframe"]["units"]["pet"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 22
		E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 176
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 7
		E.db["unitframe"]["units"]["player"]["power"]["height"] = 7
		E.db["unitframe"]["units"]["raid"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["perrow"] = 2
		E.db["unitframe"]["units"]["raid"]["debuffs"]["sizeOverride"] = 16
		E.db["unitframe"]["units"]["raid"]["debuffs"]["xOffset"] = -3
		E.db["unitframe"]["units"]["raid"]["debuffs"]["yOffset"] = -19
		E.db["unitframe"]["units"]["raid"]["height"] = 25
		E.db["unitframe"]["units"]["raid"]["roleIcon"]["enable"] = false
		E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid40"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 150
		E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "BOTTOMLEFT"
		E.db["unitframe"]["units"]["target"]["debuffs"]["numrows"] = 10
		E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 1
		E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = "Personal"
		E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 32
		E.db["unitframe"]["units"]["target"]["debuffs"]["xOffset"] = -33
		E.db["unitframe"]["units"]["target"]["debuffs"]["yOffset"] = 35
		E.db["unitframe"]["units"]["target"]["health"]["position"] = "TOPLEFT"
		E.db["unitframe"]["units"]["target"]["health"]["text_format"] = "[health:percent] • [health:current]"
		E.db["unitframe"]["units"]["target"]["health"]["yOffset"] = 19
		E.db["unitframe"]["units"]["target"]["name"]["position"] = "TOPLEFT"
		E.db["unitframe"]["units"]["target"]["name"]["text_format"] = "[namecolor][name:short] [difficultycolor][smartlevel][shortclassification]"
		E.db["unitframe"]["units"]["target"]["name"]["yOffset"] = 36
		E.db["unitframe"]["units"]["target"]["width"] = 150
		--UF_CustomTexts
		if not E.db["unitframe"]["units"]["pet"]["customTexts"] then E.db["unitframe"]["units"]["pet"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"] = {}
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["justifyH"] = "CENTER"
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["xOffset"] = 0
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["size"] = 13
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["text_format"] = "[namecolor][name:medium]"
			E.db["unitframe"]["units"]["pet"]["customTexts"]["CustomPet"]["yOffset"] = 0
		if not E.db["unitframe"]["units"]["raid40"]["customTexts"] then E.db["unitframe"]["units"]["raid40"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"] = {}
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["justifyH"] = "CENTER"
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["xOffset"] = 0
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["yOffset"] = 0
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["text_format"] = "[namecolor][name:short]"
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["raidname"]["size"] = 13
		if not E.db["unitframe"]["units"]["target"]["customTexts"] then E.db["unitframe"]["units"]["target"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"] = {}
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["justifyH"] = "RIGHT"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["size"] = 16
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["text_format"] = ""
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["xOffset"] = 35
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["yOffset"] = 1
		if not E.db["unitframe"]["units"]["boss"]["customTexts"] then E.db["unitframe"]["units"]["boss"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"] = {}
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["justifyH"] = "LEFT"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["size"] = 13
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["text_format"] = "[namecolor][name:medium]"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["xOffset"] = 8
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["yOffset"] = 0
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"] = {}
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["justifyH"] = "RIGHT"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["size"] = 13
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["text_format"] = "[health:percent]"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["xOffset"] = -5
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["yOffset"] = -1
		if not E.db["unitframe"]["units"]["raid"]["customTexts"] then E.db["unitframe"]["units"]["raid"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"] = {}
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["justifyH"] = "CENTER"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["size"] = 12
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["text_format"] = "[namecolor][name:short]"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["xOffset"] = 10
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["yOffset"] = 1

		--Settings that require addons
		--CustomTweaks
		if IsAddOnLoaded("ElvUI_CustomTweaks") then
			E.db["CustomTweaks"]["AuraIconText"]["stackTextOffsetY"] = 10
			E.db["CustomTweaks"]["CastbarCustomBackdrop"]["backdropColor"]["b"] = 0.42352941176471
			E.db["CustomTweaks"]["CastbarCustomBackdrop"]["backdropColor"]["g"] = 0.42352941176471
			E.db["CustomTweaks"]["CastbarCustomBackdrop"]["backdropColor"]["r"] = 0.42352941176471
			E.db["CustomTweaks"]["CastbarText"]["Player"]["text"]["color"]["b"] = 0.83921568627451
			E.db["CustomTweaks"]["CastbarText"]["Player"]["text"]["color"]["g"] = 0.83921568627451
			E.db["CustomTweaks"]["CastbarText"]["Player"]["text"]["color"]["r"] = 0.81960784313725
			E.db["CustomTweaks"]["CastbarText"]["Target"]["duration"]["color"]["b"] = 0.93725490196078
			E.db["CustomTweaks"]["CastbarText"]["Target"]["duration"]["color"]["g"] = 1
			E.db["CustomTweaks"]["CastbarText"]["Target"]["duration"]["color"]["r"] = 0.96078431372549
			E.db["CustomTweaks"]["CastbarText"]["Target"]["duration"]["xOffset"] = 17
			E.db["CustomTweaks"]["CastbarText"]["Target"]["duration"]["yOffset"] = -20
			E.db["CustomTweaks"]["CastbarText"]["Target"]["text"]["color"]["b"] = 0.96862745098039
			E.db["CustomTweaks"]["CastbarText"]["Target"]["text"]["color"]["g"] = 1
			E.db["CustomTweaks"]["CastbarText"]["Target"]["text"]["color"]["r"] = 0.96862745098039
			E.db["CustomTweaks"]["CastbarText"]["Target"]["text"]["xOffset"] = 0
			E.db["CustomTweaks"]["CastbarText"]["Target"]["text"]["yOffset"] = -20
		end
		--Shadow and Light
		if IsAddOnLoaded("ElvUI_SLE") then
			E.db["sle"]["Armory"]["Character"]["Gem"]["SocketSize"] = 8
			E.db["sle"]["Armory"]["Character"]["NoticeMissing"] = false
			E.db["sle"]["Armory"]["Character"]["Stats"]["ItemLevel"]["outline"] = "OUTLINE"
			E.db["sle"]["chat"]["tab"]["color"]["b"] = 0.07843137254902
			E.db["sle"]["chat"]["tab"]["color"]["g"] = 0.77647058823529
			E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "HaxrCorp12cyr"
			E.db["sle"]["skins"]["merchant"]["list"]["nameOutline"] = "MONOCHROMEOUTLINE"
			E.db["sle"]["skins"]["merchant"]["list"]["nameSize"] = 17
			E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "HaxrCorp12cyr"
			E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "MONOCHROMEOUTLINE"
			E.db["sle"]["skins"]["merchant"]["list"]["subSize"] = 17
			if not E.db["sle"]["unitframes"]["unit"]["target"] then E.db["sle"]["unitframes"]["unit"]["target"] = {} end
				E.db["sle"]["unitframes"]["unit"]["target"]["auras"] = {}
				E.db["sle"]["unitframes"]["unit"]["target"]["auras"]["debuffs"] = {}
				E.db["sle"]["unitframes"]["unit"]["target"]["auras"]["debuffs"]["threshold"] = -1
				E.db["sle"]["unitframes"]["unit"]["target"]["auras"]["buffs"]= {}
				E.db["sle"]["unitframes"]["unit"]["target"]["auras"]["buffs"]["threshold"] = -1
		end

	--Layout: Healer
	elseif layout == "healer" then
		--make some changes here
		E.db["bags"]["itemLevelThreshold"] = 900
		--movers
		E.db["movers"]["RaidMarkerBarAnchor"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,0,381"
		E.db["movers"]["ZoneAbility"] = "BOTTOM,ElvUIParent,BOTTOM,-171,2"
		E.db["movers"]["VehicleSeatMover"] = "BOTTOM,ElvUIParent,BOTTOM,204,49"
		E.db["movers"]["LossControlMover"] = "TOP,ElvUIParent,TOP,-1,-478"
		E.db["movers"]["MirrorTimer1Mover"] = "BOTTOM,ElvUIParent,BOTTOM,-3,182"
		E.db["movers"]["AltPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-2,245"
		E.db["movers"]["MirrorTimer2Mover"] = "BOTTOM,ElvUIParent,BOTTOM,-3,182"
		E.db["movers"]["RaidUtility_Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,462,2"
		E.db["movers"]["ArenaHeaderMover"] = "BOTTOM,ElvUIParent,BOTTOM,-304,269"
		E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-200,2"
		E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,0"
		E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1141,612"
		E.db["movers"]["GMMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-202,3"
		E.db["movers"]["MirrorTimer3Mover"] = "BOTTOM,ElvUIParent,BOTTOM,-3,182"
		E.db["movers"]["ElvUF_FocusMover"] = "TOP,ElvUIParent,TOP,235,-424"
		E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,400"
		E.db["movers"]["MicrobarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-1,204"
		E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,168,364"
		E.db["movers"]["BNETMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-200,4"
		E.db["movers"]["ElvUF_Raid40Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMLEFT,1519,406"
		E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,168,347"
		E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-11,400"
		E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,0,170"
		E.db["movers"]["UIErrorsFrameMover"] = "TOP,ElvUIParent,TOP,-3,-348"
		E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-1,91"
		E.db["movers"]["BossHeaderMover"] = "TOP,ElvUIParent,TOP,-289,-96"
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1140,613"
		E.db["movers"]["AlertFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,250"
		E.db["movers"]["DebuffsMover"] = "BOTTOM,ElvUIParent,BOTTOM,166,279"
		E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-136,320"
    E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,-136,367"
    E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-135,393"
		--Auras
		E.db["auras"]["debuffs"]["verticalSpacing"] = 20
		--Nameplates
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["buffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["castbar"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["debuffs"]["enable"] = false
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["healthbar"]["height"] = 4
		E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["healthbar"]["width"] = 50
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["name"]["useClassColor"] = false
		E.db["nameplates"]["units"]["FRIENDLY_NPC"]["healthbar"]["enable"] = true
		E.db["nameplates"]["reactions"]["bad"]["b"] = 0.25098039215686
		E.db["nameplates"]["reactions"]["bad"]["g"] = 0.25098039215686
		E.db["nameplates"]["reactions"]["bad"]["r"] = 0.78039215686274
		E.db["nameplates"]["clampToScreen"] = true
		--UnitFrames
		E.db["unitframe"]["colors"]["disconnected"]["b"] = 0.25098039215686
		E.db["unitframe"]["colors"]["disconnected"]["g"] = 0.32941176470588
		E.db["unitframe"]["colors"]["disconnected"]["r"] = 0.36862745098039
		E.db["unitframe"]["units"]["boss"]["castbar"]["width"] = 175
		E.db["unitframe"]["units"]["boss"]["debuffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["height"] = 38
		E.db["unitframe"]["units"]["boss"]["threatStyle"] = "NONE"
		E.db["unitframe"]["units"]["boss"]["width"] = 175
		E.db["unitframe"]["units"]["focus"]["castbar"]["height"] = 25
		E.db["unitframe"]["units"]["focus"]["name"]["yOffset"] = 1
		E.db["unitframe"]["units"]["focus"]["width"] = 110
		E.db["unitframe"]["units"]["party"]["buffs"]["anchorPoint"] = "CENTER"
		E.db["unitframe"]["units"]["party"]["buffs"]["enable"] = true
		E.db["unitframe"]["units"]["party"]["buffs"]["fontSize"] = 14
		E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = "AmazingShit"
		E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 27
		E.db["unitframe"]["units"]["party"]["debuffs"]["countFontSize"] = 16
		E.db["unitframe"]["units"]["party"]["debuffs"]["fontSize"] = 14
		E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 2
		E.db["unitframe"]["units"]["party"]["GPSArrow"] = {}
		E.db["unitframe"]["units"]["party"]["roleIcon"]["combatHide"] = true
		E.db["unitframe"]["units"]["pet"]["enable"] = true
		E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 23
		E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 176
		E.db["unitframe"]["units"]["player"]["classbar"]["additionalPowerText"] = false
		E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 6
		E.db["unitframe"]["units"]["player"]["power"]["height"] = 6
		E.db["unitframe"]["units"]["raid"]["debuffs"]["anchorPoint"] = "CENTER"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["clickThrough"] = true
		E.db["unitframe"]["units"]["raid"]["debuffs"]["countFontSize"] = 13
		E.db["unitframe"]["units"]["raid"]["debuffs"]["enable"] = true
		E.db["unitframe"]["units"]["raid"]["debuffs"]["fontSize"] = 16
		E.db["unitframe"]["units"]["raid"]["debuffs"]["perrow"] = 1
		E.db["unitframe"]["units"]["raid"]["debuffs"]["priority"] = "AnnoyingShit"
		E.db["unitframe"]["units"]["raid"]["debuffs"]["sizeOverride"] = 28
		E.db["unitframe"]["units"]["raid"]["debuffs"]["yOffset"] = -1
		E.db["unitframe"]["units"]["raid"]["healPrediction"] = true
		E.db["unitframe"]["units"]["raid"]["height"] = 35
		E.db["unitframe"]["units"]["raid"]["raidicon"]["attachTo"] = "RIGHT"
		E.db["unitframe"]["units"]["raid"]["raidicon"]["size"] = 14
		E.db["unitframe"]["units"]["raid"]["raidicon"]["xOffset"] = -4
		E.db["unitframe"]["units"]["raid"]["raidicon"]["yOffset"] = 7
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "LEFT_UP"
		E.db["unitframe"]["units"]["raid40"]["width"] = 75
		E.db["unitframe"]["units"]["target"]["buffs"]["noDuration"] = {}
		E.db["unitframe"]["units"]["target"]["buffs"]["playerOnly"] = {}
		E.db["unitframe"]["units"]["target"]["castbar"]["enable"] = false
		E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 16
		E.db["unitframe"]["units"]["target"]["castbar"]["icon"] = false
		E.db["unitframe"]["units"]["target"]["castbar"]["spark"] = false
		E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 110
		E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "RIGHT"
		E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 4
		E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = "CastByPlayers,blockNoDuration"
		E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 34
		E.db["unitframe"]["units"]["target"]["debuffs"]["sortMethod"] = "PLAYER"
		E.db["unitframe"]["units"]["target"]["debuffs"]["xOffset"] = 1
		E.db["unitframe"]["units"]["target"]["health"]["text_format"] = "[health:current] • [health:percent]"
		E.db["unitframe"]["units"]["target"]["health"]["yOffset"] = -30
		E.db["unitframe"]["units"]["target"]["name"]["position"] = "BOTTOMRIGHT"
		E.db["unitframe"]["units"]["target"]["name"]["text_format"] = "[name:short] [difficultycolor][smartlevel][shortclassification]"
		E.db["unitframe"]["units"]["target"]["name"]["yOffset"] = -38
		E.db["unitframe"]["units"]["target"]["width"] = 110
		--UF_CustomTexts
		if not E.db["unitframe"]["units"]["target"]["customTexts"] then E.db["unitframe"]["units"]["target"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"] = {}
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["justifyH"] = "RIGHT"
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["size"] = 16
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["text_format"] = ""
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["xOffset"] = 35
			E.db["unitframe"]["units"]["target"]["customTexts"]["levelnew"]["yOffset"] = 1
		if not E.db["unitframe"]["units"]["boss"]["customTexts"] then E.db["unitframe"]["units"]["boss"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"] = {}
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["justifyH"] = "LEFT"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["size"] = 14
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["text_format"] = "[namecolor][name:medium]"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["xOffset"] = 8
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossName"]["yOffset"] = 0
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"] = {}
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["justifyH"] = "RIGHT"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["size"] = 14
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["text_format"] = "[health:percent]"
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["xOffset"] = -5
			E.db["unitframe"]["units"]["boss"]["customTexts"]["BossHealth"]["yOffset"] = -1
		if not E.db["unitframe"]["units"]["raid"]["customTexts"] then E.db["unitframe"]["units"]["raid"]["customTexts"] = {} end
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"] = {}
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["fontOutline"] = "NONE"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["justifyH"] = "LEFT"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["size"] = 11
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["text_format"] = "[namecolor][name:short]"
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["xOffset"] = 4
			E.db["unitframe"]["units"]["raid"]["customTexts"]["names"]["yOffset"] = 6

		--Settings that require addons
		--CustomTweaks
		if IsAddOnLoaded("ElvUI_CustomTweaks") then
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["arena"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["assist"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["boss"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["focus"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["focustarget"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["pet"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["pettarget"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["player"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["raid"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["raid40"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["raidpet"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["tank"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["targettarget"] = false
			E.db["CustomTweaks"]["AuraIconSpacing"]["units"]["targettargettarget"] = false
			E.db["CustomTweaks"]["AuraIconText"]["stackTextOffsetX"] = 0
			E.db["CustomTweaks"]["AuraIconText"]["stackTextOffsetY"] = 0
			E.db["CustomTweaks"]["ClickThroughActionBars"]["bar4"] = true
		end
		--Shadow and Light
		if IsAddOnLoaded("ElvUI_SLE") then
			E.db["sle"]["Armory"]["Character"]["Stats"]["IlvlFull"] = true
			E.db["sle"]["chat"]["tab"]["color"]["b"] = 0.95294117647059
			E.db["sle"]["chat"]["tab"]["color"]["r"] = 0.9843137254902
			E.db["sle"]["minimap"]["mapicons"]["iconperrow"] = 1
			E.db["sle"]["minimap"]["mapicons"]["iconsize"] = 25
			E.db["sle"]["minimap"]["mapicons"]["spacing"] = 1
			E.db["sle"]["skins"]["merchant"]["list"]["nameFont"] = "Expressway"
			E.db["sle"]["skins"]["merchant"]["list"]["nameOutline"] = "NONE"
			E.db["sle"]["skins"]["merchant"]["list"]["subFont"] = "Expressway"
			E.db["sle"]["skins"]["merchant"]["list"]["subOutline"] = "NONE"
			E.db["sle"]["skins"]["merchant"]["list"]["subSize"] = 10
			E.db["sle"]["tooltip"]["RaidProg"]["enable"] = true
			E.db["sle"]["tooltip"]["RaidProg"]["NameStyle"] = "LONG"
			E.db["sle"]["tooltip"]["RaidProg"]["raids"]["nighthold"] = false
			E.db["sle"]["tooltip"]["RaidProg"]["raids"]["nightmare"] = false
			E.db["sle"]["tooltip"]["RaidProg"]["raids"]["sargeras"] = false
			E.db["sle"]["tooltip"]["RaidProg"]["raids"]["trial"] = false
			E.db["sle"]["unitframes"]["unit"]["target"]["auras"]["buffs"]["threshold"] = -1
			E.db["sle"]["unitframes"]["unit"]["target"]["auras"]["debuffs"]["threshold"] = -1
		end

	end



	--[[
	--	This section at the bottom is just to update ElvUI and display a message
	--]]
	--Update ElvUI
	E:UpdateAll(true)
	--Show message about layout being set
	PluginInstallStepComplete.message = "Layout Set"
	PluginInstallStepComplete:Show()
end

local function CreateStyleFilter(name)
	local filter = {} --Create filter table
	NP:StyleFilterInitializeFilter(filter) --Initialize new filter with default options
	E.global.nameplate.filters[name] = filter --Add new filter to database

	--Add the "Enable" option to current profile
	if not E.db.nameplates then E.db.nameplates = {} end
	if not E.db.nameplates.filters then E.db.nameplates.filters = {} end
	if not E.db.nameplates.filters[name] then E.db.nameplates.filters[name] = {} end
	if not E.db.nameplates.filters[name].triggers then E.db.nameplates.filters[name].triggers = {} end
	E.db["nameplates"]["filters"][name]["triggers"]["enable"] = true
end

local function CreateAuraFilter(value)
	if match(value, "^[%s%p]-$") then
		return
	end
	if match(value, ",") then
		E:Print(L["Filters are not allowed to have commas in their name. Stripping commas from filter name."])
		value = gsub(value, ",", "")
	end
	if match(value, "^Friendly:") or match(value, "^Enemy:") then
		return --dont allow people to create Friendly: or Enemy: filters
	end
	if G.unitframe.specialFilters[value] or E.global.unitframe.aurafilters[value] then
		--E:Print(L["Filter already exists!"])
		return
	end
	E.global.unitframe['aurafilters'][value] = {};
	E.global.unitframe['aurafilters'][value]['spells'] = {};
end

local function Filters()

	--[[
	--	Setup the Nameplate Filters
	--]]
	CreateStyleFilter("Aggro")
	E.global.nameplate.filters["Aggro"]["actions"]["usePortrait"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["frameLevel"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["power"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["healthColor"]["a"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["healthColor"]["r"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["healthColor"]["g"] = 0.015686274509804
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["healthColor"]["b"] = 0.007843137254902
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["health"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["borderColor"]["a"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["borderColor"]["r"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["borderColor"]["g"] = 0.36862745098039
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["borderColor"]["b"] = 0.36862745098039
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["nameColor"]["a"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["nameColor"]["r"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["nameColor"]["g"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["nameColor"]["b"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["name"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["border"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["powerColor"]["a"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["powerColor"]["r"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["powerColor"]["g"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["color"]["powerColor"]["b"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["nameOnly"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["alpha"] = -1
	E.global.nameplate.filters["Aggro"]["actions"]["flash"]["color"]["a"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["flash"]["color"]["r"] = 0.77254901960784
	E.global.nameplate.filters["Aggro"]["actions"]["flash"]["color"]["g"] = 0.75294117647059
	E.global.nameplate.filters["Aggro"]["actions"]["flash"]["color"]["b"] = 0.74117647058823
	E.global.nameplate.filters["Aggro"]["actions"]["flash"]["enable"] = true
	E.global.nameplate.filters["Aggro"]["actions"]["flash"]["speed"] = 8
	E.global.nameplate.filters["Aggro"]["actions"]["hide"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["scale"] = 1
	E.global.nameplate.filters["Aggro"]["actions"]["texture"]["enable"] = false
	E.global.nameplate.filters["Aggro"]["actions"]["texture"]["texture"] = "Cloud"
	E.global.nameplate.filters["Aggro"]["triggers"]["debuffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["debuffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["debuffs"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["debuffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceType"]["party"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceType"]["scenario"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceType"]["none"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceType"]["raid"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceType"]["arena"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceType"]["pvp"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["inCombatUnit"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["powerThreshold"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["maxlevel"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["level"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["overHealthThreshold"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["neutral"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["enemyNPC"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["healer"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["enable"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["friendlyPlayer"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["enemyPlayer"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["nameplateType"]["friendlyNPC"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["powerUsePlayer"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["outOfCombatUnit"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["buffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["buffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["buffs"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["buffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["inCombat"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["healthThreshold"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["isTarget"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["priority"] = 1
	E.global.nameplate.filters["Aggro"]["triggers"]["healthUsePlayer"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["targetMe"] = true
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["elite"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["normal"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["rareelite"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["minus"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["worldboss"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["trivial"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["classification"]["rare"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["underPowerThreshold"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["dungeon"]["normal"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic+"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["dungeon"]["heroic"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["dungeon"]["timewalking"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["normal"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["legacy25normal"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["heroic"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["legacy10normal"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["legacy10heroic"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["mythic"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["lfr"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["timewalking"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["instanceDifficulty"]["raid"]["legacy25heroic"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["minlevel"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["underHealthThreshold"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier7enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier7"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier7"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier2enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier1"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier1"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier4"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier4"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["type"] = "normal"
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier2"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier2"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier4enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier3"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier3"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier5enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier5"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier5"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier1enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["requireAll"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier6enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier3enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier6"]["missing"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["talent"]["tier6"]["column"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["role"]["tank"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["role"]["healer"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["role"]["damager"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["questBoss"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["overPowerThreshold"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["notTarget"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["curlevel"] = 0
	E.global.nameplate.filters["Aggro"]["triggers"]["cooldowns"]["mustHaveAll"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["casting"]["interruptible"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["outOfCombat"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["enabled"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["reputation"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["friendly"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["revered"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["honored"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["hostile"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["unfriendly"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["hated"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["neutral"] = false
	E.global.nameplate.filters["Aggro"]["triggers"]["reactionType"]["exalted"] = false

	CreateStyleFilter("Boss")
	E.global.nameplate.filters["Boss"]["actions"]["texture"]["enable"] = false
	E.global.nameplate.filters["Boss"]["actions"]["texture"]["texture"] = "ElvUI Norm"
	E.global.nameplate.filters["Boss"]["actions"]["usePortrait"] = false
	E.global.nameplate.filters["Boss"]["actions"]["frameLevel"] = 0
	E.global.nameplate.filters["Boss"]["actions"]["hide"] = false
	E.global.nameplate.filters["Boss"]["actions"]["color"]["borderColor"]["a"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["borderColor"]["b"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["borderColor"]["g"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["borderColor"]["r"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["nameColor"]["a"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["nameColor"]["b"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["nameColor"]["g"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["nameColor"]["r"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["health"] = false
	E.global.nameplate.filters["Boss"]["actions"]["color"]["power"] = false
	E.global.nameplate.filters["Boss"]["actions"]["color"]["healthColor"]["a"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["healthColor"]["b"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["healthColor"]["g"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["healthColor"]["r"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["name"] = false
	E.global.nameplate.filters["Boss"]["actions"]["color"]["border"] = false
	E.global.nameplate.filters["Boss"]["actions"]["color"]["powerColor"]["a"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["powerColor"]["b"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["powerColor"]["g"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["color"]["powerColor"]["r"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["nameOnly"] = false
	E.global.nameplate.filters["Boss"]["actions"]["alpha"] = -1
	E.global.nameplate.filters["Boss"]["actions"]["flash"]["color"]["a"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["flash"]["color"]["b"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["flash"]["color"]["g"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["flash"]["color"]["r"] = 1
	E.global.nameplate.filters["Boss"]["actions"]["flash"]["enable"] = false
	E.global.nameplate.filters["Boss"]["actions"]["flash"]["speed"] = 4
	E.global.nameplate.filters["Boss"]["triggers"]["debuffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["debuffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["debuffs"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["debuffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["instanceType"]["party"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceType"]["scenario"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceType"]["pvp"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceType"]["raid"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceType"]["arena"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceType"]["none"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["inCombatUnit"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["role"]["tank"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["role"]["damager"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["role"]["healer"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["maxlevel"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["overHealthThreshold"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["nameplateType"]["healer"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["nameplateType"]["enemyPlayer"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["nameplateType"]["friendlyPlayer"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["nameplateType"]["neutral"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["nameplateType"]["friendlyNPC"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["underHealthThreshold"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["reputation"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["friendly"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["revered"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["honored"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["hostile"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["unfriendly"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["exalted"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["neutral"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["reactionType"]["hated"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["buffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["buffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["buffs"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["buffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["inCombat"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["healthThreshold"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["isTarget"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["priority"] = 1
	E.global.nameplate.filters["Boss"]["triggers"]["outOfCombat"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["targetMe"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["elite"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["minus"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["trivial"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["normal"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["worldboss"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["rareelite"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["classification"]["rare"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["underPowerThreshold"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier1enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier5"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier5"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier2enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier1"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier1"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier4"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier4"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["type"] = "normal"
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier2"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier2"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier4enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier3"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier3"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier5enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier7"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier7"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier7enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["requireAll"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier6enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier3enabled"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier6"]["missing"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["talent"]["tier6"]["column"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["minlevel"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["notTarget"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["healthUsePlayer"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["dungeon"]["normal"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic+"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["dungeon"]["heroic"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["dungeon"]["timewalking"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["normal"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["legacy25normal"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["heroic"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["legacy10normal"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["legacy10heroic"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["legacy25heroic"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["lfr"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["timewalking"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["instanceDifficulty"]["raid"]["mythic"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["questBoss"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["powerThreshold"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["overPowerThreshold"] = 0
	E.global.nameplate.filters["Boss"]["triggers"]["cooldowns"]["mustHaveAll"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["casting"]["interruptible"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["powerUsePlayer"] = false
	E.global.nameplate.filters["Boss"]["triggers"]["outOfCombatUnit"] = false

	CreateStyleFilter("CC")
	E.global.nameplate.filters["CC"]["actions"]["usePortrait"] = false
	E.global.nameplate.filters["CC"]["actions"]["frameLevel"] = 0
	E.global.nameplate.filters["CC"]["actions"]["color"]["health"] = true
	E.global.nameplate.filters["CC"]["actions"]["color"]["power"] = false
	E.global.nameplate.filters["CC"]["actions"]["color"]["name"] = true
	E.global.nameplate.filters["CC"]["actions"]["color"]["borderColor"]["a"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["borderColor"]["r"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["borderColor"]["g"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["borderColor"]["b"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["nameColor"]["a"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["nameColor"]["r"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["nameColor"]["g"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["nameColor"]["b"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["healthColor"]["a"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["healthColor"]["r"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["healthColor"]["g"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["healthColor"]["b"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["border"] = false
	E.global.nameplate.filters["CC"]["actions"]["color"]["powerColor"]["a"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["powerColor"]["r"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["powerColor"]["g"] = 1
	E.global.nameplate.filters["CC"]["actions"]["color"]["powerColor"]["b"] = 1
	E.global.nameplate.filters["CC"]["actions"]["nameOnly"] = false
	E.global.nameplate.filters["CC"]["actions"]["alpha"] = -1
	E.global.nameplate.filters["CC"]["actions"]["flash"]["color"]["a"] = 1
	E.global.nameplate.filters["CC"]["actions"]["flash"]["color"]["r"] = 1
	E.global.nameplate.filters["CC"]["actions"]["flash"]["color"]["g"] = 1
	E.global.nameplate.filters["CC"]["actions"]["flash"]["color"]["b"] = 1
	E.global.nameplate.filters["CC"]["actions"]["flash"]["enable"] = false
	E.global.nameplate.filters["CC"]["actions"]["flash"]["speed"] = 4
	E.global.nameplate.filters["CC"]["actions"]["texture"]["enable"] = false
	E.global.nameplate.filters["CC"]["actions"]["texture"]["texture"] = "ElvUI Norm"
	E.global.nameplate.filters["CC"]["actions"]["scale"] = 1
	E.global.nameplate.filters["CC"]["actions"]["hide"] = false
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Blind"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Banish"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Polymorph"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Sap"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Imprison"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Paralysis"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Entangling Roots"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Freezing Trap"] = true
	E.global.nameplate.filters["CC"]["triggers"]["debuffs"]["names"]["Repentance"] = true
	E.global.nameplate.filters["CC"]["triggers"]["instanceType"]["party"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceType"]["scenario"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceType"]["none"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceType"]["raid"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceType"]["arena"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceType"]["pvp"] = false
	E.global.nameplate.filters["CC"]["triggers"]["inCombatUnit"] = false
	E.global.nameplate.filters["CC"]["triggers"]["powerThreshold"] = false
	E.global.nameplate.filters["CC"]["triggers"]["maxlevel"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["level"] = false
	E.global.nameplate.filters["CC"]["triggers"]["overHealthThreshold"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["neutral"] = false
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["enemyNPC"] = false
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["healer"] = false
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["enable"] = false
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["friendlyPlayer"] = false
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["enemyPlayer"] = false
	E.global.nameplate.filters["CC"]["triggers"]["nameplateType"]["friendlyNPC"] = false
	E.global.nameplate.filters["CC"]["triggers"]["powerUsePlayer"] = false
	E.global.nameplate.filters["CC"]["triggers"]["outOfCombatUnit"] = false
	E.global.nameplate.filters["CC"]["triggers"]["buffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["buffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["CC"]["triggers"]["buffs"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["buffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["inCombat"] = false
	E.global.nameplate.filters["CC"]["triggers"]["healthThreshold"] = false
	E.global.nameplate.filters["CC"]["triggers"]["isTarget"] = false
	E.global.nameplate.filters["CC"]["triggers"]["priority"] = 1
	E.global.nameplate.filters["CC"]["triggers"]["healthUsePlayer"] = false
	E.global.nameplate.filters["CC"]["triggers"]["targetMe"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["elite"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["normal"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["rareelite"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["minus"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["worldboss"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["trivial"] = false
	E.global.nameplate.filters["CC"]["triggers"]["classification"]["rare"] = false
	E.global.nameplate.filters["CC"]["triggers"]["underPowerThreshold"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["dungeon"]["normal"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic+"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["dungeon"]["heroic"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["dungeon"]["timewalking"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["normal"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["legacy25normal"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["heroic"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["legacy10normal"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["legacy10heroic"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["mythic"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["lfr"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["timewalking"] = false
	E.global.nameplate.filters["CC"]["triggers"]["instanceDifficulty"]["raid"]["legacy25heroic"] = false
	E.global.nameplate.filters["CC"]["triggers"]["minlevel"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["underHealthThreshold"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier7enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier7"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier7"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier2enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier1"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier1"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier4"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier4"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["type"] = "normal"
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier2"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier2"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier4enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier3"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier3"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier5enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier5"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier5"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier1enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["requireAll"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier6enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier3enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier6"]["missing"] = false
	E.global.nameplate.filters["CC"]["triggers"]["talent"]["tier6"]["column"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["role"]["tank"] = false
	E.global.nameplate.filters["CC"]["triggers"]["role"]["healer"] = false
	E.global.nameplate.filters["CC"]["triggers"]["role"]["damager"] = false
	E.global.nameplate.filters["CC"]["triggers"]["questBoss"] = false
	E.global.nameplate.filters["CC"]["triggers"]["overPowerThreshold"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["notTarget"] = false
	E.global.nameplate.filters["CC"]["triggers"]["curlevel"] = 0
	E.global.nameplate.filters["CC"]["triggers"]["cooldowns"]["mustHaveAll"] = false
	E.global.nameplate.filters["CC"]["triggers"]["casting"]["interruptible"] = false
	E.global.nameplate.filters["CC"]["triggers"]["outOfCombat"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["enabled"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["reputation"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["friendly"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["revered"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["honored"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["hostile"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["unfriendly"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["hated"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["neutral"] = false
	E.global.nameplate.filters["CC"]["triggers"]["reactionType"]["exalted"] = false

	CreateStyleFilter("Explosive Orb")
	E.global.nameplate.filters["Explosive Orb"]["actions"]["usePortrait"] = false
	E.global.nameplate.filters["Explosive Orb"]["actions"]["frameLevel"] = 0
	E.global.nameplate.filters["Explosive Orb"]["actions"]["scale"] = 1.5
	E.global.nameplate.filters["Explosive Orb"]["actions"]["nameOnly"] = false
	E.global.nameplate.filters["Explosive Orb"]["actions"]["alpha"] = -1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["flash"]["color"]["a"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["flash"]["color"]["r"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["flash"]["color"]["g"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["flash"]["color"]["b"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["flash"]["enable"] = false
	E.global.nameplate.filters["Explosive Orb"]["actions"]["flash"]["speed"] = 4
	E.global.nameplate.filters["Explosive Orb"]["actions"]["texture"]["enable"] = false
	E.global.nameplate.filters["Explosive Orb"]["actions"]["texture"]["texture"] = "ElvUI Norm"
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["name"] = false
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["nameColor"]["a"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["nameColor"]["r"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["nameColor"]["g"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["nameColor"]["b"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["health"] = true
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["borderColor"]["a"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["borderColor"]["r"] = 0.16470588235294
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["borderColor"]["g"] = 0.36078431372549
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["borderColor"]["b"] = 0.07843137254902
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["healthColor"]["a"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["healthColor"]["r"] = 0.023529411764706
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["healthColor"]["g"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["healthColor"]["b"] = 0.13333333333333
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["power"] = false
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["border"] = true
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["powerColor"]["a"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["powerColor"]["r"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["powerColor"]["g"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["color"]["powerColor"]["b"] = 1
	E.global.nameplate.filters["Explosive Orb"]["actions"]["hide"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["debuffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["debuffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["debuffs"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["debuffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceType"]["party"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceType"]["scenario"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceType"]["none"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceType"]["raid"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceType"]["arena"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceType"]["pvp"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["inCombatUnit"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["role"]["tank"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["role"]["healer"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["role"]["damager"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["maxlevel"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["level"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["notTarget"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["neutral"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["enemyNPC"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["healer"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["enable"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["friendlyPlayer"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["enemyPlayer"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["nameplateType"]["friendlyNPC"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["underHealthThreshold"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["reputation"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["friendly"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["revered"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["honored"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["hostile"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["unfriendly"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["hated"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["neutral"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["reactionType"]["exalted"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["buffs"]["minTimeLeft"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["buffs"]["mustHaveAll"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["buffs"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["buffs"]["maxTimeLeft"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["inCombat"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["enable"] = true
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["healthThreshold"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["names"]["Fell Explosives"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["names"]["Explosive Orb"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["names"]["Fel Explosives"] = true
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["isTarget"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["priority"] = 1
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["healthUsePlayer"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["targetMe"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["elite"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["normal"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["rareelite"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["minus"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["worldboss"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["trivial"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["classification"]["rare"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["underPowerThreshold"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier7enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier7"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier7"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier2enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier1"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier1"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier4"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier4"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["type"] = "normal"
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier2"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier2"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier4enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier3"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier3"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier5enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier5"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier5"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier1enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["requireAll"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier6enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier3enabled"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier6"]["missing"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["talent"]["tier6"]["column"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["minlevel"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["powerUsePlayer"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["overHealthThreshold"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["outOfCombat"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["powerThreshold"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["questBoss"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["overPowerThreshold"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["curlevel"] = 0
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["cooldowns"]["mustHaveAll"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["casting"]["interruptible"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["dungeon"]["normal"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic+"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["dungeon"]["heroic"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["dungeon"]["timewalking"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["normal"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["legacy25normal"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["heroic"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["legacy10normal"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["legacy10heroic"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["mythic"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["lfr"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["timewalking"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["instanceDifficulty"]["raid"]["legacy25heroic"] = false
	E.global.nameplate.filters["Explosive Orb"]["triggers"]["outOfCombatUnit"] = false

	NP:ConfigureAll()

	--[[
	--	Unitframe Aura Filters
	--]]
	CreateAuraFilter("AnnoyingShit")
	if E.global.unitframe.aurafilters["AnnoyingShit"] then
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"][""] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"][""] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"][""]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"][""]["priority"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Soulblight"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Soulblight"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Soulblight"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Soulblight"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Soulblight"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Necrotic Embrace"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Necrotic Embrace"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Necrotic Embrace"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Necrotic Embrace"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Necrotic Embrace"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Flame Wreath"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Flame Wreath"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Flame Wreath"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Flame Wreath"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Flame Wreath"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Fulminating Pulse"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Fulminating Pulse"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Fulminating Pulse"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Fulminating Pulse"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Fulminating Pulse"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Throw Spear"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Throw Spear"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Throw Spear"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Throw Spear"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Throw Spear"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Grievous Wound"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Grievous Wound"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Grievous Wound"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Grievous Wound"]["priority"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Disintegration Beam"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Disintegration Beam"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Disintegration Beam"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Disintegration Beam"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Disintegration Beam"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Burst"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Burst"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Burst"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Burst"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Burst"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Soulbomb"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Soulbomb"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Soulbomb"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Soulbomb"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Soulbomb"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Brutal Glaive"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Brutal Glaive"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Brutal Glaive"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Brutal Glaive"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Brutal Glaive"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Misery"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Misery"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Misery"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Misery"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Misery"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Fel Detonation"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Fel Detonation"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Fel Detonation"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Fel Detonation"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Fel Detonation"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Tormenting Eye"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Tormenting Eye"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Tormenting Eye"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Tormenting Eye"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Tormenting Eye"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Souldburst"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Souldburst"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Souldburst"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Souldburst"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Souldburst"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Unstable Affliction"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Unstable Affliction"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Unstable Affliction"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Unstable Affliction"]["priority"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Scorching Blaze"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Scorching Blaze"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Scorching Blaze"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Scorching Blaze"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Scorching Blaze"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Necrotic Rot"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Necrotic Rot"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Necrotic Rot"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Necrotic Rot"]["priority"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Demonic Upheaval"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Demonic Upheaval"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Demonic Upheaval"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Demonic Upheaval"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Demonic Upheaval"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Chaos Pulse"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Chaos Pulse"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Chaos Pulse"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Chaos Pulse"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Chaos Pulse"]["stackThreshold"] = 9
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Garrote"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Garrote"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Garrote"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Garrote"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Garrote"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Chilled Blood"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Chilled Blood"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Chilled Blood"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Chilled Blood"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Chilled Blood"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Feed on the Weak"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Feed on the Weak"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Feed on the Weak"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Feed on the Weak"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Feed on the Weak"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Inferno Bolt"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Inferno Bolt"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Inferno Bolt"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Inferno Bolt"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Inferno Bolt"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Stinging Swarm"] then E.global.unitframe.aurafilters["AnnoyingShit"]["spells"]["Stinging Swarm"] = {} end
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Stinging Swarm"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Stinging Swarm"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["spells"]["Stinging Swarm"]["stackThreshold"] = 0
		E.global["unitframe"]["aurafilters"]["AnnoyingShit"]["type"] = "Whitelist"
	end

	CreateAuraFilter("AmazingShit")
	if E.global.unitframe.aurafilters["AmazingShit"] then
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["type"] = "Whitelist"
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Divine Shield"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Divine Shield"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Divine Shield"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Divine Shield"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Divine Shield"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Guardian of Ancient Kings"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Guardian of Ancient Kings"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Guardian of Ancient Kings"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Guardian of Ancient Kings"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Guardian of Ancient Kings"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Deterrence"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Deterrence"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Deterrence"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Deterrence"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Deterrence"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Astral Shift"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Astral Shift"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Astral Shift"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Astral Shift"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Astral Shift"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Diffuse Magic"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Diffuse Magic"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Diffuse Magic"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Diffuse Magic"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Diffuse Magic"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Fortifying Brew"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Fortifying Brew"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Fortifying Brew"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Fortifying Brew"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Fortifying Brew"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Dancing Rune Weapon"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Dancing Rune Weapon"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Dancing Rune Weapon"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Dancing Rune Weapon"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Dancing Rune Weapon"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Unending Resolve"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Unending Resolve"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Unending Resolve"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Unending Resolve"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Unending Resolve"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Icebound Fortitude"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Icebound Fortitude"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Icebound Fortitude"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Icebound Fortitude"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Icebound Fortitude"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Dispersion"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Dispersion"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Dispersion"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Dispersion"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Dispersion"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Divine Protection"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Divine Protection"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Divine Protection"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Divine Protection"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Divine Protection"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Shield Wall"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Shield Wall"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Shield Wall"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Shield Wall"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Shield Wall"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Spell Reflection"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Spell Reflection"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Spell Reflection"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Spell Reflection"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Spell Reflection"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Blessing of Protection"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Blessing of Protection"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Blessing of Protection"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Blessing of Protection"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Blessing of Protection"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Die by the Sword"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Die by the Sword"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Die by the Sword"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Die by the Sword"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Die by the Sword"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Feint"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Feint"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Feint"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Feint"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Feint"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Barkskin"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Barkskin"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Barkskin"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Barkskin"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Barkskin"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Last Stand"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Last Stand"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Last Stand"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Last Stand"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Last Stand"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Cloak of Shadows"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Cloak of Shadows"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Cloak of Shadows"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Cloak of Shadows"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Cloak of Shadows"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Ice Block"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Ice Block"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Ice Block"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Ice Block"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Ice Block"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Anti-Magic Shell"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Anti-Magic Shell"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Anti-Magic Shell"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Anti-Magic Shell"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Anti-Magic Shell"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Survival Instincts"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Survival Instincts"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Survival Instincts"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Survival Instincts"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Survival Instincts"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Vampiric Blood"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Vampiric Blood"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Vampiric Blood"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Vampiric Blood"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Vampiric Blood"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Ardent Defender"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Ardent Defender"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Ardent Defender"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Ardent Defender"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Ardent Defender"]["stackThreshold"] = 0
		if not E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Evasion"] then E.global.unitframe.aurafilters["AmazingShit"]["spells"]["Evasion"] = {} end
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Evasion"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Evasion"]["priority"] = 0
		E.global["unitframe"]["aurafilters"]["AmazingShit"]["spells"]["Evasion"]["stackThreshold"] = 0
	end

	CreateAuraFilter("Blacklist")
	if E.global.unitframe.aurafilters["Blacklist"] then
		if not E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Sign of the Skirmisher"] then E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Sign of the Skirmisher"] = {} end
		E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Sign of the Skirmisher"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Sign of the Skirmisher"]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Guild Champion"] then E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Guild Champion"] = {} end
		E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Guild Champion"]["enable"] = true
		E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"]["Guild Champion"]["priority"] = 0
	end

	CreateAuraFilter("RaidDebuffs")
	if E.global.unitframe.aurafilters["RaidDebuffs"] then
		if not E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][235117] then E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][235117] = {} end
		E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][235117]["priority"] = 1
		if not E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][238505] then E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][238505] = {} end
		E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][238505]["priority"] = 2
		if not E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][234995] then E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][234995] = {} end
		E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][234995]["enable"] = false
		if not E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][231770] then E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][231770] = {} end
		E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][231770]["enable"] = false
		if not E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][240209] then E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][240209] = {} end
		E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][240209]["priority"] = 1
		if not E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][238429] then E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][238429] = {} end
		E.global["unitframe"]["aurafilters"]["RaidDebuffs"]["spells"][238429]["priority"] = 1
	end

	CreateAuraFilter("CCDebuffs")
	if E.global.unitframe.aurafilters["CCDebuffs"] then
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][96294] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][96294] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][96294]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][96294]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][205369] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][205369] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][205369]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][205369]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][55536] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][55536] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][55536]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][55536]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][197214] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][197214] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][197214]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][197214]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][131556] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][131556] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][131556]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][131556]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][30108] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][30108] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][30108]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][30108]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][53148] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][53148] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][53148]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][53148]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][115268] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][115268] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][115268]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][115268]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][136634] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][136634] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][136634]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][136634]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][170855] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][170855] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][170855]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][170855]["priority"] = 0
		if not E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][135373] then E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][135373] = {} end
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][135373]["enable"] = true
		E.global["unitframe"]["aurafilters"]["CCDebuffs"]["spells"][135373]["priority"] = 0
	end

	--[[
	--	Buff watch Filters
	--]]
	if not E.global["unitframe"]["buffwatch"]["PALADIN"] then E.global["unitframe"]["buffwatch"]["PALADIN"] = {} end
		if not E.global["unitframe"]["buffwatch"]["PALADIN"][200652] then E.global["unitframe"]["buffwatch"]["PALADIN"][200652] = {} end
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["enabled"] = true
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["anyUnit"] = false
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["point"] = "TOP"
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["id"] = 200652
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["color"] = {}
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["color"]["r"] = 1
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["color"]["g"] = 0.66274509803922
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["color"]["b"] = 0.4
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["style"] = "coloredIcon"
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["xOffset"] = 0
		E.global["unitframe"]["buffwatch"]["PALADIN"][200652]["yOffset"] = 0
		if not E.global["unitframe"]["buffwatch"]["PALADIN"][223306] then E.global["unitframe"]["buffwatch"]["PALADIN"][223306] = {} end
		E.global["unitframe"]["buffwatch"]["PALADIN"][223306]["color"] = {}
		E.global["unitframe"]["buffwatch"]["PALADIN"][223306]["color"]["r"] = 1
		E.global["unitframe"]["buffwatch"]["PALADIN"][223306]["color"]["g"] = 0.89019607843137
		E.global["unitframe"]["buffwatch"]["PALADIN"][223306]["color"]["b"] = 0
		E.global["unitframe"]["buffwatch"]["PALADIN"][223306]["anyUnit"] = false
		E.global["unitframe"]["buffwatch"]["PALADIN"][223306]["point"] = "TOPLEFT"

	if not E.global["unitframe"]["buffwatch"]["DRUID"] then E.global["unitframe"]["buffwatch"]["DRUID"] = {} end
		if not E.global["unitframe"]["buffwatch"]["DRUID"][102342] then E.global["unitframe"]["buffwatch"]["DRUID"][102342] = {} end
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["enabled"] = true
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["anyUnit"] = false
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["point"] = "BOTTOMLEFT"
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["color"] = {}
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["color"]["b"] = 0.12549019607843
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["color"]["g"] = 0.53725490196078
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["color"]["r"] = 0.73333333333333
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["id"] = 102342
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["xOffset"] = 0
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["style"] = "coloredIcon"
		E.global["unitframe"]["buffwatch"]["DRUID"][102342]["yOffset"] = 0
		if not E.global["unitframe"]["buffwatch"]["DRUID"][253277] then E.global["unitframe"]["buffwatch"]["DRUID"][253277] = {} end
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["enabled"] = true
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["anyUnit"] = false
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["point"] = "BOTTOMLEFT"
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["id"] = 253277
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["color"] = {}
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["color"]["r"] = 0.73725490196078
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["color"]["g"] = 1
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["color"]["b"] = 0.086274509803922
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["style"] = "coloredIcon"
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["xOffset"] = 11
		E.global["unitframe"]["buffwatch"]["DRUID"][253277]["yOffset"] = 0
		if not E.global["unitframe"]["buffwatch"]["DRUID"][8936] then E.global["unitframe"]["buffwatch"]["DRUID"][8936] = {} end
		E.global["unitframe"]["buffwatch"]["DRUID"][8936]["xOffset"] = -11
		E.global["unitframe"]["buffwatch"]["DRUID"][8936]["point"] = "TOPRIGHT"

	--[[
	--	This section at the bottom is just to update ElvUI and display a message
	--]]
	--Update ElvUI
	E:UpdateAll(true)
	--Show message about layout being set
	PluginInstallStepComplete.message = "Filters Set"
	PluginInstallStepComplete:Show()
end

--This function is executed when you press "Skip Process" or "Finished" in the installer.
local function InstallComplete()
	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end

	--Set a variable tracking the version of the addon when layout was installed
	E.db[modName].install_version = Version

	ReloadUI()
end

local function SetupAddon(addon)
	if addon == 'BigWigs' then
		mod:LoadBigWigsProfile(selectedLayout)
	elseif addon == 'Details' then
		mod:LoadDetailsProfile(selectedLayout)
	elseif addon == 'Parrot' then
		mod:LoadParrot2Profile(selectedLayout)
	elseif addon == 'Gnosis' then
		mod:LoadGnosisProfile(selectedLayout)
	end

	--[[
	--	This section at the bottom is just to update ElvUI and display a message
	--]]
	--Update ElvUI
	E:UpdateAll(true)
	--Show message about layout being set
	PluginInstallStepComplete.message = format("%s Profile Created.", addon)
end

--This is the data we pass on to the ElvUI Plugin Installer.
--The Plugin Installer is reponsible for displaying the install guide for this layout.
local InstallerData = {
	Title = format("|cFFC79C6E%s's |cFFBABABAUI|r |cFFFFFFFF%s|r", modName, "Installation"),
	Name = modName,
	tutorialImage = "Interface\\AddOns\\ElvUI_Souschef\\logo_sui.tga",
	--tutorialImage = "Interface\\AddOns\\MyAddOn\\logo.tga", --If you have a logo you want to use, otherwise it uses the one from ElvUI
	Pages = {
		[1] = function()
			PluginInstallFrame.SubTitle:SetFormattedText("Welcome to the installation for %s's UI.", modName)
			PluginInstallFrame.Desc1:SetText("This installation process will guide you through a few steps and apply settings to your current ElvUI profile.")
			PluginInstallFrame.Desc2:SetText("|cFFEE4545If you want to be able to go back to your original settings please create a new profile before going through this installation process.")
			PluginInstallFrame.Desc3:SetText("Please press the continue button if you wish to go through the installation process, otherwise click the 'Skip Process' button.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
			PluginInstallFrame.Option1:SetText("Skip Process")
		end,
		[2] = function()
			PluginInstallFrame.SubTitle:SetText("Layouts")
			PluginInstallFrame.Desc1:SetText("These are all the available layouts. Please click a button below to apply the layout of your choice.")
			PluginInstallFrame.Desc2:SetText("Importance: |cff07D400High|r")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SetupLayout("tank") end)
			PluginInstallFrame.Option1:SetText("Tank")
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript("OnClick", function() SetupLayout("healer") end)
			PluginInstallFrame.Option2:SetText("Healer")
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript("OnClick", function() SetupLayout("dps") end)
			PluginInstallFrame.Option3:SetText("DPS")
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText("Aura and Name Plate Filters")
			PluginInstallFrame.Desc1:SetText("This step will apply my custom Aura and Name Plate Filters")
			PluginInstallFrame.Desc2:SetText("|cFFEE4545Please note that this will replace any filters you already have in place. \n If you'd like to keep your own filters, please skip this step.")
			PluginInstallFrame.Desc3:SetText("Importance: |cff07D400Low|r")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() Filters() end)
			PluginInstallFrame.Option1:SetText("Set Filters")
		end,
		[4] = function()
			PluginInstallFrame.SubTitle:SetText(L["Addons"])
			PluginInstallFrame.Desc1:SetFormattedText(L["This step allows you to apply pre-configured settings to various AddOns in order to make their appearance match %s's UI."], modName)
			PluginInstallFrame.Desc2:SetFormattedText(L["Please click any button below to apply the pre-configured settings for that particular AddOn. A new profile named %s will be created for that particular addon, which you MAY have to select manually."], modName)
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() SetupAddon('BigWigs') end)
			PluginInstallFrame.Option1:SetText('BigWigs')
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() SetupAddon('Details') end)
			PluginInstallFrame.Option2:SetText('Details')
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript('OnClick', function() SetupAddon('Parrot') end)
			PluginInstallFrame.Option3:SetText('Parrot')
			PluginInstallFrame.Option4:Show()
			PluginInstallFrame.Option4:SetScript('OnClick', function() SetupAddon('Gnosis') end)
			PluginInstallFrame.Option4:SetText('Gnosis')
		end,
		[5] = function()
			PluginInstallFrame.SubTitle:SetText(L["Chat"])
			PluginInstallFrame.Desc1:SetText(format(L["This step changes your chat windows and positions them all in the left chat panel. These changes are tailored to the needs of the author of %s and are not necessary for this edit to function."], modName))
			PluginInstallFrame.Desc2:SetText(L["|cFFEE4545Please note that using this will overwrite the existing Chat Tab settings."])
			PluginInstallFrame.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", SetupChat)
			PluginInstallFrame.Option1:SetText(L["Setup Chat"])
		end,
		[6] = function()
			PluginInstallFrame.SubTitle:SetText("Installation Complete!")
			PluginInstallFrame.Desc1:SetText("You have now completed the installation process.")
			PluginInstallFrame.Desc2:SetText("Click the button below in order to finalize everything and automatically reload your UI.")
			PluginInstallFrame.Desc3:SetText("If you have any questions or feedback , please don't hesitate to drop by my |cFF7289d9Discord |cFFFFFFFFserver or |cFF6441a4Twitch |cFFFFFFFFchannel.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
			PluginInstallFrame.Option1:SetText("Finished")
		end,
	},
	StepTitles = {
		[1] = "• Welcome",
		[2] = "• Layouts",
		[3] = "• Filters",
		[4] = "• Addons",
		[4] = "• Chat",
		[5] = "• Installation Complete",
	},
	StepTitlesColor = {186/255, 186/255, 186/255},
	StepTitlesColorSelected = {199/255, 156/255, 110/255},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = "LEFT"
}

--This function holds the options table which will be inserted into the ElvUI config
local function InsertOptions()
	E.Options.args.modName = {
		order = 100,
		type = "group",
		name = format("|cFFC79C6E%s's|r |cFFFFFFFFUI", modName),
		args = {
			header1 = {
				order = 1,
				type = "header",
				name = format("|cFFC79C6E%s's|r |cFFFFFFFFUI", modName),
			},
			description1 = {
				order = 2,
				type = "description",
				name = format("%s's UI is a layout for ElvUI, designed by |cFFed9248Except|r. The plugin was kindly put together by r1pt1de. If you have any questions or feedback please feel free to pop over to the Discord link below.", modName),
			},
			discord = {
				order = 3,
				type = "input",
				width = "full",
				name = L["Discord Server"],
				get = function(info) return "https://discord.gg/011CGgxFqikk9Ih5K" end,
				set = function(info) return "https://discord.gg/011CGgxFqikk9Ih5K" end,},
			twitch = {
				order = 4,
				type = "input",
				width = "full",
				name = L["Twitch Channel"],
				get = function(info) return "https://www.twitch.tv/exceptstreams" end,
				set = function(info) return "https://www.twitch.tv/exceptstreams" end,},
			header2 = {
				order = 5,
				type = "header",
				name = "Installation",
			},
			description2 = {
				order = 6,
				type = "description",
				name = "The installation guide should pop up automatically after you have completed the ElvUI installation. If you wish to re-run the installation process for this layout then please click the button below.",
			},
			spacer2 = {
				order = 7,
				type = "description",
				name = "",
			},
			install = {
				order = 8,
				type = "execute",
				name = "Install",
				desc = "Run the installation process.",
				func = function() E:GetModule("PluginInstaller"):Queue(InstallerData); E:ToggleConfig(); end,
			},
		},
	}
end

--Create a unique table for our plugin
P[modName] = {}

--This function will handle initialization of the addon
function mod:Initialize()
	--Initiate installation process if ElvUI install is complete and our plugin install has not yet been run
	if E.private.install_complete and E.db[modName].install_version == nil then
		E:GetModule("PluginInstaller"):Queue(InstallerData)
	end

	--Insert our options table when ElvUI config is loaded
	EP:RegisterPlugin(addon, InsertOptions)
end

--This function will get called by ElvUI automatically when it is ready to initialize modules
local function CallbackInitialize()
	mod:Initialize()
end

--Register module with callback so it gets initialized when ready
E:RegisterModule(modName, CallbackInitialize)
