local _, BetterSettings = ...

-- Create main frame
BetterSettings.frame = CreateFrame("Frame")
BetterSettings.frame:RegisterEvent("ADDON_LOADED")
BetterSettings.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Load Config and UI
BetterSettings.Config.Load()
BetterSettings.UI.Init()