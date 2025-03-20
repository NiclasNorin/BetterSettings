local _, FixMouseLookSpeed = ...

FixMouseLookSpeed.UI = {}

function FixMouseLookSpeed.UI.Init()
    local ui = CreateFrame("Frame", "FixMouseLookSpeedUI", UIParent, "BasicFrameTemplateWithInset")
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
    rawMouseCheckbox:SetChecked(FixMouseLookSpeedDB.rawMouseEnable == 1)
    rawMouseCheckbox:SetScript("OnClick", function(self)
        FixMouseLookSpeedDB.rawMouseEnable = self:GetChecked() and 1 or 0
    end)

    -- Slider: Camera Speed
    local yawSlider = CreateFrame("Slider", nil, ui, "OptionsSliderTemplate")
    yawSlider:SetPoint("TOPLEFT", 20, -100)
    yawSlider:SetMinMaxValues(10, 50)
    yawSlider:SetValueStep(1)
    yawSlider:SetValue(FixMouseLookSpeedDB.cameraYawMoveSpeed)

    local yawSliderLabel = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    yawSliderLabel:SetPoint("BOTTOMLEFT", yawSlider, "TOPLEFT", 0, 5)
    yawSliderLabel:SetText("Mouse and Camera speed")

    local yawSliderValue = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    yawSliderValue:SetPoint("LEFT", yawSlider, "RIGHT", 10, 0)
    yawSliderValue:SetText(math.floor(yawSlider:GetValue()))

    yawSlider:SetScript("OnValueChanged", function(self, value)
        FixMouseLookSpeedDB.cameraYawMoveSpeed = value
        FixMouseLookSpeedDB.cameraPitchMoveSpeed = value
        yawSliderValue:SetText(math.floor(value))
    end)

    -- Slider: Maximum Zoom Distance
    local zoomSlider = CreateFrame("Slider", nil, ui, "OptionsSliderTemplate")
    zoomSlider:SetPoint("TOPLEFT", 20, -150)
    zoomSlider:SetMinMaxValues(1, 2.6)
    zoomSlider:SetValueStep(0.1)
    zoomSlider:SetValue(FixMouseLookSpeedDB.cameraDistanceMaxZoomFactor)

    local zoomSliderLabel = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zoomSliderLabel:SetPoint("BOTTOMLEFT", zoomSlider, "TOPLEFT", 0, 5)
    zoomSliderLabel:SetText("Max Zoom Distance")

    local zoomSliderValue = ui:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zoomSliderValue:SetPoint("LEFT", zoomSlider, "RIGHT", 10, 0)
    zoomSliderValue:SetText(string.format("%.1f", zoomSlider:GetValue()))

    zoomSlider:SetScript("OnValueChanged", function(self, value)
        FixMouseLookSpeedDB.cameraDistanceMaxZoomFactor = value
        zoomSliderValue:SetText(string.format("%.1f", value))
    end)

    -- Apply Button
    local applyButton = CreateFrame("Button", nil, ui, "GameMenuButtonTemplate")
    applyButton:SetPoint("BOTTOM", 0, 20)
    applyButton:SetSize(100, 25)
    applyButton:SetText("Apply")
    applyButton:SetScript("OnClick", function()
        FixMouseLookSpeedDB.saved = true
        FixMouseLookSpeedDB.cameraDistanceMaxZoomFactor = zoomSlider:GetValue()
        FixMouseLookSpeedDB.cameraYawMoveSpeed = yawSlider:GetValue()
        FixMouseLookSpeedDB.cameraPitchMoveSpeed = yawSlider:GetValue()
        FixMouseLookSpeedDB.rawMouseEnable = rawMouseCheckbox:GetChecked() and 1 or 0

        FixMouseLookSpeed.Config.Apply()
        ui:Hide()
    end)

    SLASH_BETTERSETTINGS1 = "/bettersettings"
    SlashCmdList["BETTERSETTINGS"] = function()
        if ui:IsShown() then
            ui:Hide()
        else
            rawMouseCheckbox:SetChecked(FixMouseLookSpeedDB.rawMouseEnable == 1)
            yawSlider:SetValue(FixMouseLookSpeedDB.cameraYawMoveSpeed)
            yawSliderValue:SetText(math.floor(FixMouseLookSpeedDB.cameraYawMoveSpeed))
            zoomSlider:SetValue(FixMouseLookSpeedDB.cameraDistanceMaxZoomFactor)
            zoomSliderValue:SetText(string.format("%.1f", FixMouseLookSpeedDB.cameraDistanceMaxZoomFactor))
            ui:Show()
        end
    end
end
