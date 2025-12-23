-- CrispyUI: Unit Frames Module
-- Enhances player, target, party, and raid frames

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Create module
CUI.UnitFrames = CUI.UnitFrames or {}
local UF = CUI.UnitFrames

-- Unit frame list
local unitFrames = {
    "PlayerFrame",
    "TargetFrame",
    "FocusFrame",
    "PetFrame",
    "PartyMemberFrame1",
    "PartyMemberFrame2",
    "PartyMemberFrame3",
    "PartyMemberFrame4",
}

-- Apply unit frame enhancements
function UF:Apply()
    local config = CUI.db.profile.unitFrames
    
    if not config.enabled then
        return
    end
    
    -- Style each unit frame
    for _, frameName in ipairs(unitFrames) do
        local frame = _G[frameName]
        if frame then
            self:StyleUnitFrame(frame, config)
        end
    end
    
    -- Special handling for player and target
    if PlayerFrame then
        self:EnhancePlayerFrame(PlayerFrame, config)
    end
    
    if TargetFrame then
        self:EnhanceTargetFrame(TargetFrame, config)
    end
end

-- Style individual unit frame
function UF:StyleUnitFrame(frame, config)
    if not frame or frame.CrispyStyled then return end
    
    -- Enhance health bar
    local healthBar = frame.healthbar or frame.HealthBar
    if healthBar then
        self:StyleStatusBar(healthBar, "health", config)
    end
    
    -- Enhance mana/power bar
    local manaBar = frame.manabar or frame.ManaBar
    if manaBar then
        self:StyleStatusBar(manaBar, "power", config)
    end
    
    -- Enhance portrait
    if config.showPortraits then
        local portrait = frame.portrait or frame.Portrait
        if portrait then
            self:StylePortrait(portrait)
        end
    end
    
    frame.CrispyStyled = true
end

-- Style status bars (health/mana)
function UF:StyleStatusBar(bar, barType, config)
    if not bar then return end
    
    -- Add subtle border glow
    if not bar.CrispyBorder then
        bar.CrispyBorder = bar:CreateTexture(nil, "OVERLAY")
        bar.CrispyBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
        bar.CrispyBorder:SetPoint("TOPLEFT", bar, "TOPLEFT", -1, 1)
        bar.CrispyBorder:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 1, -1)
        bar.CrispyBorder:SetVertexColor(0.2, 0.6, 1.0, 0.5)
    end
    
    -- Larger health bars option
    if config.largerHealthBars and barType == "health" then
        local currentHeight = bar:GetHeight()
        if currentHeight and currentHeight > 0 then
            bar:SetHeight(currentHeight * 1.2)
        end
    end
    
    -- Class colored health bars
    if config.colorByClass and barType == "health" then
        local unit = bar:GetParent().unit
        if unit and UnitExists(unit) and UnitIsPlayer(unit) then
            local _, class = UnitClass(unit)
            if class then
                local color = RAID_CLASS_COLORS[class]
                if color then
                    bar:SetStatusBarColor(color.r, color.g, color.b)
                end
            end
        end
    end
end

-- Style portraits
function UF:StylePortrait(portrait)
    if not portrait or portrait.CrispyStyled then return end
    
    -- Add border to portrait
    if not portrait.CrispyBorder then
        portrait.CrispyBorder = portrait:CreateTexture(nil, "OVERLAY")
        portrait.CrispyBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
        portrait.CrispyBorder:SetAllPoints(portrait)
        portrait.CrispyBorder:SetVertexColor(0.2, 0.6, 1.0, 0.3)
    end
    
    portrait.CrispyStyled = true
end

-- Enhanced player frame
function UF:EnhancePlayerFrame(frame, config)
    -- Additional player-specific enhancements
    if frame.PlayerFrameContainer then
        -- Modern frame container styling
    end
end

-- Enhanced target frame
function UF:EnhanceTargetFrame(frame, config)
    -- Additional target-specific enhancements
    if frame.TargetFrameContainer then
        -- Modern frame container styling
    end
end

-- Export module
CUI.UnitFrames = UF
