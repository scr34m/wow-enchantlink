local setupCF = false

local function EL_AddChatText(self, button, down)
	if down then
		return
	end

	if not ChatFrame1EditBox:IsShown() then
		return
	end

	local id = GetCraftSelectionIndex()
	local craftName = GetCraftInfo(id);
	local a = {}

	for j = 1, GetCraftNumReagents(id) do
		local reagentName, reagentTexturePath, reagentNumRequired = GetCraftReagentInfo(id, j)
		local link = reagentNumRequired .. "x" .. GetCraftReagentItemLink(id, j)
		tinsert(a, link)
	end

	local msg = craftName .. " mat(s): " .. table.concat(a,", ")

	ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText() .. msg)
end

local function EL_SetupWidget()
	local btn = CreateFrame("Button", nil, CraftFrame, "UIPanelButtonTemplate")
 	btn:SetFrameLevel(4)
 	btn:SetPoint("CENTER")
	btn:SetPoint("RIGHT", CraftFrame, "RIGHT", -70, 0)
	btn:SetText("L")
	btn:SetScript("OnClick", EL_AddChatText)
	btn:RegisterForClicks("AnyDown", "AnyUp")

	local name = GetCraftReagentInfo(GetCraftSelectionIndex(), self:GetID())
end

local frame, events = CreateFrame("Frame"), {};
function events:CRAFT_SHOW(...)
	if not setupCF then -- and CraftFrame ~= nil
		EL_SetupWidget()
		setupCF = true
	end
end
frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

