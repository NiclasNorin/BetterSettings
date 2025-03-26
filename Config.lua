local _, BetterSettings = ...

BetterSettings.Config = {}

-- Default settings
local defaultSettings = {
    rawMouseEnable = 1,
    rawMouseAccelerationEnable = 0,
    cameraYawMoveSpeed = 30,
    cameraPitchMoveSpeed = 30,
    cameraDistanceMaxZoomFactor = 1.9
}

-- Load settings from saved variables
function BetterSettings.Config.Load()
    if not BetterSettingsDB then
        BetterSettingsDB = {}
    end
    for key, value in pairs(defaultSettings) do
        if BetterSettingsDB[key] == nil then
            BetterSettingsDB[key] = value
        end
    end
end

-- Apply settings
function BetterSettings.Config.Apply()
    for key, value in pairs(BetterSettingsDB) do
        SetCVar(key, value)
    end
    BetterSettingsDB.saved = true
end
