local _, FixMouseLookSpeed = ...

FixMouseLookSpeed.frame:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "FixMouseLookSpeed" then
        FixMouseLookSpeed.Config.Load()
        print("|cff00ff00[FixMouseLookSpeed]|r Settings Loaded!")
    elseif event == "PLAYER_ENTERING_WORLD" then
        FixMouseLookSpeed.Config.Apply()
    end
end)
