local _, FixMouseLookSpeed = ...

-- Create main frame
FixMouseLookSpeed.frame = CreateFrame("Frame")
FixMouseLookSpeed.frame:RegisterEvent("ADDON_LOADED")
FixMouseLookSpeed.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Load Config and UI
FixMouseLookSpeed.Config.Load()
FixMouseLookSpeed.UI.Init()