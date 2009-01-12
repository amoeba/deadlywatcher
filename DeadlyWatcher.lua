local function Print(...) print("|cFF33FF99Addon Template|r:", ...) end

DeadlyWatcher = CreateFrame("frame")
DeadlyWatcher:SetParent(UIParent)
DeadlyWatcher:SetWidth(50)
DeadlyWatcher:SetHeight(50)
DeadlyWatcher:SetPoint("CENTER", UIParent, "CENTER", 0, -150)

DeadlyWatcher.countText = DeadlyWatcher:CreateFontString(nil, "OVERLAY")
DeadlyWatcher.countText:SetAllPoints(DeadlyWatcher)
DeadlyWatcher.countText:SetFont(STANDARD_TEXT_FONT, 26)
DeadlyWatcher.countText:SetJustifyH("CENTER")
DeadlyWatcher.countText:SetTextColor(0.1, 1, 0.1)
DeadlyWatcher.countText:SetShadowOffset(0.7, -0.7)

DeadlyWatcher:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
DeadlyWatcher:RegisterEvent("UNIT_AURA")
DeadlyWatcher:RegisterEvent("UNIT_TARGET")

function DeadlyWatcher:scanAndUpdate()
  name,_,_,count,_,_,_,isMine,_ = UnitDebuff("target", "Deadly Poison IX")

  if name and isMine then
    self.countText:SetText(count)
  else
    self.countText:SetText("")
  end
end

function DeadlyWatcher:UNIT_AURA(event, unitID)
  if unitID == "target" then self:scanAndUpdate() end
end

function DeadlyWatcher:UNIT_TARGET(event, unitID)
  if unitID == "player" then self:scanAndUpdate() end
end