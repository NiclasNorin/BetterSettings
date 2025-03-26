local _, BetterSettings = ...

BetterSettings.frame:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "BetterSettings" then
        BetterSettings.Config.Load()
        print("|cff00ff00[BetterSettings]|r Settings Loaded!")
    elseif event == "PLAYER_ENTERING_WORLD" then
        BetterSettings.Config.Apply()
    end
end)
