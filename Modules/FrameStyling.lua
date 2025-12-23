-- CrispyUI: Frame Styling Module
-- Applies modern, sleek styling to various UI frames

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Create module
CUI.FrameStyling = CUI.FrameStyling or {}
local FS = CUI.FrameStyling

-- List of frames to style
local framesToStyle = {
    -- Main UI frames
    "CharacterFrame",
    "PaperDollFrame",
    "SpellBookFrame",
    "TalentFrame",
    "QuestFrame",
    "QuestLogFrame",
    "FriendsFrame",
    "GuildFrame",
    "PVPFrame",
    "WorldMapFrame",
    "GameMenuFrame",
    "VideoOptionsFrame",
    "InterfaceOptionsFrame",
    "MailFrame",
    "BankFrame",
    "MerchantFrame",
    "GossipFrame",
    "TradeFrame",
    "LFGDungeonReadyDialog",
    "StaticPopup1",
    "StaticPopup2",
}

-- Apply styling to all frames
function FS:Apply()
    local config = CUI.db.frameStyling
    
    if not config.enabled then
        return
    end
    
    -- Style standard frames
    for _, frameName in ipairs(framesToStyle) do
        local frame = _G[frameName]
        if frame then
            self:StyleFrame(frame)
        end
    end
    
    -- Style tooltips background
    self:StyleTooltips()
    
    -- Apply hook for new frames (with debounce to prevent performance issues)
    if not self.hookedUIParent then
        self.hookedUIParent = true
        self.lastApplyTime = 0
        
        hooksecurefunc("UIParent_ManageFramePosition", function()
            local now = GetTime()
            if now - FS.lastApplyTime > 1 then  -- Debounce: only apply once per second
                FS.lastApplyTime = now
                C_Timer.After(0.1, function()
                    FS:Apply()
                end)
            end
        end)
    end
end

-- Style individual frame
function FS:StyleFrame(frame)
    if not frame then return end
    
    local config = CUI.db.frameStyling
    
    -- Apply backdrop
    CUI:ApplyBackdrop(frame, config)
    
    -- Style close button if it exists
    local closeButton = frame.CloseButton or frame.closeButton
    if closeButton then
        self:StyleButton(closeButton)
    end
    
    -- Add subtle glow effect
    if not frame.CrispyGlow then
        local glow = frame:CreateTexture(nil, "OVERLAY")
        glow:SetTexture("Interface\\GLUES\\MODELS\\UI_MainMenu\\UI-MainMenu-ButtonGlow")
        glow:SetPoint("CENTER", frame, "CENTER", 0, 0)
        glow:SetSize(frame:GetWidth() * 1.1, frame:GetHeight() * 1.1)
        glow:SetBlendMode("ADD")
        glow:SetAlpha(0.1)
        frame.CrispyGlow = glow
    end
end

-- Style buttons with modern look
function FS:StyleButton(button)
    if not button or button.CrispyStyled then return end
    
    local config = CUI.db.frameStyling
    
    -- Create custom textures
    if button:GetNormalTexture() then
        button:GetNormalTexture():SetAlpha(0.3)
    end
    
    if button:GetHighlightTexture() then
        button:GetHighlightTexture():SetVertexColor(
            config.borderColor[1],
            config.borderColor[2],
            config.borderColor[3],
            0.5
        )
    end
    
    button.CrispyStyled = true
end

-- Style game tooltips
function FS:StyleTooltips()
    local tooltips = {
        GameTooltip,
        ItemRefTooltip,
        ShoppingTooltip1,
        ShoppingTooltip2,
    }
    
    for _, tooltip in ipairs(tooltips) do
        if tooltip then
            CUI:ApplyBackdrop(tooltip)
        end
    end
end

-- Export module
CUI.FrameStyling = FS
