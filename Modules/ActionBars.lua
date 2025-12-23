-- CrispyUI: Action Bars Module
-- Enhances action bars with modern styling and animations

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Create module
CUI.ActionBars = CUI.ActionBars or {}
local AB = CUI.ActionBars

-- Action bar frames
local actionBars = {
    "ActionButton",
    "MultiBarBottomLeftButton",
    "MultiBarBottomRightButton",
    "MultiBarLeftButton",
    "MultiBarRightButton",
    "StanceButton",
    "PetActionButton",
}

-- Apply action bar enhancements
function AB:Apply()
    local config = CUI.db.actionBars
    
    if not config.enabled then
        return
    end
    
    -- Style all action buttons
    for _, barPrefix in ipairs(actionBars) do
        for i = 1, 12 do
            local button = _G[barPrefix .. i]
            if button then
                self:StyleActionButton(button, config)
            end
        end
    end
    
    -- Style extra action button
    if ExtraActionButton1 then
        self:StyleActionButton(ExtraActionButton1, config)
    end
end

-- Style individual action button
function AB:StyleActionButton(button, config)
    if not button or button.CrispyStyled then return end
    
    -- Enhance icon borders
    local icon = button.icon
    if icon then
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    
    -- Style the button border
    if button.NormalTexture then
        button.NormalTexture:SetVertexColor(0.2, 0.6, 1.0, 1.0)
    end
    
    -- Add glow on hover
    if not button.CrispyHover then
        button.CrispyHover = button:CreateTexture(nil, "OVERLAY")
        button.CrispyHover:SetTexture("Interface\\Buttons\\WHITE8X8")
        button.CrispyHover:SetAllPoints(button)
        button.CrispyHover:SetVertexColor(0.2, 0.6, 1.0, 0)
        button.CrispyHover:SetBlendMode("ADD")
    end
    
    -- Hover animation
    button:HookScript("OnEnter", function(self)
        if self.CrispyHover then
            UIFrameFadeIn(self.CrispyHover, 0.2, self.CrispyHover:GetAlpha(), 0.3)
        end
    end)
    
    button:HookScript("OnLeave", function(self)
        if self.CrispyHover then
            UIFrameFadeOut(self.CrispyHover, 0.2, self.CrispyHover:GetAlpha(), 0)
        end
    end)
    
    -- Hotkey styling
    if config.showHotkeys and button.HotKey then
        button.HotKey:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
        button.HotKey:SetTextColor(0.2, 0.6, 1.0)
    end
    
    -- Add cooldown text enhancement
    if button.cooldown then
        button.cooldown:SetDrawEdge(false)
        button.cooldown:SetDrawSwipe(true)
        button.cooldown:SetSwipeColor(0, 0, 0, 0.8)
    end
    
    button.CrispyStyled = true
end

-- Apply button spacing
function AB:ApplySpacing(spacing)
    -- This would typically use a more advanced layout system
    -- For now, it's a placeholder for future enhancement
    spacing = spacing or CUI.db.actionBars.buttonSpacing
end

-- Export module
CUI.ActionBars = AB
