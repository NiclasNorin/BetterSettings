local _, FixMouseLookSpeed = ...

FixMouseLookSpeed.Config = {}

-- Default settings
local defaultSettings = {
    rawMouseEnable = 1,
    rawMouseAccelerationEnable = 0,
    cameraYawMoveSpeed = 30,
    cameraPitchMoveSpeed = 30,
    cameraDistanceMaxZoomFactor = 1.9
}

-- Load settings from saved variables
function FixMouseLookSpeed.Config.Load()
    if not FixMouseLookSpeedDB then
        FixMouseLookSpeedDB = {}
    end
    for key, value in pairs(defaultSettings) do
        if FixMouseLookSpeedDB[key] == nil then
            FixMouseLookSpeedDB[key] = value
        end
    end
end

-- Apply settings
function FixMouseLookSpeed.Config.Apply()
    for key, value in pairs(FixMouseLookSpeedDB) do
        SetCVar(key, value)
    end
    FixMouseLookSpeedDB.saved = true
end
