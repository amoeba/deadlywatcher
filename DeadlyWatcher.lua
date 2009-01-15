-----------------------------
--  Locals and Defaults    --
-----------------------------

-----------------------
--    Frame Setup    --
-----------------------

local f = CreateFrame("frame")
f:SetParent(UIParent)
f:SetWidth(50)
f:SetHeight(50)
f:SetPoint("CENTER", UIParent, "CENTER", 0, -150)

local countText = f:CreateFontString(nil, "OVERLAY")
countText:SetAllPoints(f)
countText:SetFont(STANDARD_TEXT_FONT, 26)
countText:SetJustifyH("CENTER")
countText:SetTextColor(0.1, 1, 0.1)
countText:SetShadowOffset(0.7, -0.7)

f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
f:RegisterEvent("UNIT_AURA")
f:RegisterEvent("UNIT_TARGET")
-----------------------------
--    Utility Functions    --
-----------------------------
local function scanAndUpdate()
  name,_,_,count,_,_,_,isMine,_ = UnitDebuff("target", "Deadly Poison IX")

  if name and isMine then
    countText:SetText(count)
  else
    countText:SetText("")
  end
end

--------------------------
--    Event Handling    --
--------------------------

function f:UNIT_AURA(event, unitID)
  if unitID == "target" then scanAndUpdate() end
end

function f:UNIT_TARGET(event, unitID)
  if unitID == "player" then scanAndUpdate() end
end