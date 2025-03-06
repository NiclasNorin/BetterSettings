local f = CreateFrame("Frame")

f:RegisterEvent("PLAYER_ENTERING_WORLD")

f:SetScript("OnEvent", function(self, event, isLogin, isReload)
    SetCVar("rawMouseEnable", 1)
    print("|cff00ff00[FixMouseLookSpeed]|r Changed the rawMouseEnable to 1.")
    SetCVar("cameraYawMoveSpeed", 35)
    print("|cff00ff00[FixMouseLookSpeed]|r Changed the cameraYawMoveSpeed to 35.")
    SetCVar("cameraPitchMoveSpeed", 35)
    print("|cff00ff00[FixMouseLookSpeed]|r Changed the cameraPitchMoveSpeed to 35.")
end)