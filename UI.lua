local _, BetterSettings = ...

BetterSettings.UI = {}

function BetterSettings.UI.Init()
    local ui = CreateFrame("Frame", "BetterSettingsUI", UIParent, "BasicFrameTemplateWithInset")
    ui:SetSize(250, 300)
    ui:SetPoint("CENTER")
    ui:SetMovable(true)
    ui:EnableMouse(true)
    ui:RegisterForDrag("LeftButton")
    ui:SetScript("OnDragStart", ui.StartMoving)
    ui:SetScript("OnDragStop", ui.StopMovingOrSizing)
    ui:Hide()

    ui.title = ui:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    ui.title:SetPoint("TOP", ui, "TOP", 0, -10)
    ui.title:SetText("Better Settings")

    -- Checkbox: Mouse Acceleration
    local rawMouseCheckbox = CreateFrame("CheckButton", nil, ui, "UICheckButtonTemplate")
    rawMouseCheckbox:SetPoint("TOPLEFT", 20, -40)
    rawMouseCheckbox.text = rawMouseCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    rawMouseCheckbox.text:SetPoint("LEFT", rawMouseCheckbox, "RIGHT", 5, 0)
    rawMouseCheckbox.text:SetText("Mouse Acceleration")
    rawMouseCheckbox:SetChecked(BetterSettingsDB.rawMouseEnable == 1)
    rawMouseCheckbox:SetScript("OnClick", function(self)
        BetterSettingsDB.rawMouseEnable = self:GetChecked() and 1 or 0
    end)

    -- Slider: Camera Speed
    local yawSlider = CreateFrame("Slider", nil, ui, "OptionsSliderTemplate")
    yawSlider:SetPoint("TOPLEFT", 20, -100)
    yawSlider:SetMinMaxValues(10, 100)
    yawSlider:SetValueStep(1)
    yawSlider:SetValue(BetterSettingsDB.cameraYawMoveSpeed)

    local yawSliderLabel = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    yawSliderLabel:SetPoint("BOTTOMLEFT", yawSlider, "TOPLEFT", 0, 5)
    yawSliderLabel:SetText("Mouse and Camera speed")

    local yawSliderValue = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    yawSliderValue:SetPoint("LEFT", yawSlider, "RIGHT", 10, 0)
    yawSliderValue:SetText(math.floor(yawSlider:GetValue()))

    yawSlider:SetScript("OnValueChanged", function(self, value)
        BetterSettingsDB.cameraYawMoveSpeed = value
        BetterSettingsDB.cameraPitchMoveSpeed = value
        yawSliderValue:SetText(math.floor(value))
    end)

    -- Slider: Maximum Zoom Distance
    local zoomSlider = CreateFrame("Slider", nil, ui, "OptionsSliderTemplate")
    zoomSlider:SetPoint("TOPLEFT", 20, -150)
    zoomSlider:SetMinMaxValues(1, 2.6)
    zoomSlider:SetValueStep(0.1)
    zoomSlider:SetValue(BetterSettingsDB.cameraDistanceMaxZoomFactor)

    local zoomSliderLabel = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zoomSliderLabel:SetPoint("BOTTOMLEFT", zoomSlider, "TOPLEFT", 0, 5)
    zoomSliderLabel:SetText("Max Zoom Distance")

    local zoomSliderValue = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zoomSliderValue:SetPoint("LEFT", zoomSlider, "RIGHT", 10, 0)
    zoomSliderValue:SetText(string.format("%.1f", zoomSlider:GetValue()))

    zoomSlider:SetScript("OnValueChanged", function(self, value)
        BetterSettingsDB.cameraDistanceMaxZoomFactor = value
        zoomSliderValue:SetText(string.format("%.1f", value))
    end)

    -- Apply Button
    local applyButton = CreateFrame("Button", nil, ui, "GameMenuButtonTemplate")
    applyButton:SetPoint("BOTTOM", 0, 20)
    applyButton:SetSize(100, 25)
    applyButton:SetText("Apply")
    applyButton:SetScript("OnClick", function()
        BetterSettingsDB.saved = true
        BetterSettingsDB.cameraDistanceMaxZoomFactor = zoomSlider:GetValue()
        BetterSettingsDB.cameraYawMoveSpeed = yawSlider:GetValue()
        BetterSettingsDB.cameraPitchMoveSpeed = yawSlider:GetValue()
        BetterSettingsDB.rawMouseEnable = rawMouseCheckbox:GetChecked() and 1 or 0

        BetterSettings.Config.Apply()
        ui:Hide()
    end)

    SLASH_BETTERSETTINGS1 = "/bettersettings"
    SlashCmdList["BETTERSETTINGS"] = function()
        if ui:IsShown() then
            ui:Hide()
        else
            rawMouseCheckbox:SetChecked(BetterSettingsDB.rawMouseEnable == 1)
            yawSlider:SetValue(BetterSettingsDB.cameraYawMoveSpeed)
            yawSliderValue:SetText(math.floor(BetterSettingsDB.cameraYawMoveSpeed))
            zoomSlider:SetValue(BetterSettingsDB.cameraDistanceMaxZoomFactor)
            zoomSliderValue:SetText(string.format("%.1f", BetterSettingsDB.cameraDistanceMaxZoomFactor))
            ui:Show()
        end
    end
end
