-- CrispyUI: Chat Frames Module
-- Modernizes chat frames with enhanced styling and features

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Create module
CUI.ChatFrames = CUI.ChatFrames or {}
local CF = CUI.ChatFrames

-- Chat frame list
local chatFrames = {
    ChatFrame1,
    ChatFrame2,
    ChatFrame3,
    ChatFrame4,
}

-- Apply chat frame enhancements
function CF:Apply()
    local config = CUI.db.chatFrames
    
    if not config.enabled then
        return
    end
    
    -- Style each chat frame
    for i, frame in ipairs(chatFrames) do
        if frame then
            self:StyleChatFrame(frame, config)
        end
    end
    
    -- Apply modern style
    if config.modernStyle then
        self:ApplyModernStyle(config)
    end
end

-- Style individual chat frame
function CF:StyleChatFrame(frame, config)
    if not frame or frame.CrispyStyled then return end
    
    -- Apply backdrop to chat frame
    CUI:ApplyBackdrop(frame)
    
    -- Style edit box
    local editBox = frame.editBox or _G[frame:GetName() .. "EditBox"]
    if editBox then
        self:StyleEditBox(editBox)
    end
    
    -- Style buttons
    local buttonFrame = frame.buttonFrame or _G[frame:GetName() .. "ButtonFrame"]
    if buttonFrame then
        self:StyleChatButtons(buttonFrame)
    end
    
    -- Enhance font
    local font, size, flags = frame:GetFont()
    if font then
        frame:SetFont(font, size + 1, flags)
    end
    
    -- Add fade out timer
    if config.fadeOutTime and config.fadeOutTime > 0 then
        frame:SetFading(true)
        frame:SetTimeVisible(config.fadeOutTime)
        frame:SetFadeDuration(2)
    else
        frame:SetFading(false)
    end
    
    frame.CrispyStyled = true
end

-- Style chat edit box
function CF:StyleEditBox(editBox)
    if not editBox or editBox.CrispyStyled then return end
    
    -- Apply backdrop
    CUI:ApplyBackdrop(editBox)
    
    -- Style the text
    local font, size, flags = editBox:GetFont()
    if font then
        editBox:SetFont(font, size + 1, "OUTLINE")
    end
    
    -- Color the edit box
    editBox:SetTextColor(1, 1, 1, 1)
    
    -- Add focus glow
    editBox:HookScript("OnEditFocusGained", function(self)
        CUI:ApplyBackdrop(self, {
            borderColor = {0.2, 0.6, 1.0, 1.0},
            backgroundColor = {0.0, 0.0, 0.0, 0.9},
            borderSize = 3,
        })
    end)
    
    editBox:HookScript("OnEditFocusLost", function(self)
        CUI:ApplyBackdrop(self)
    end)
    
    editBox.CrispyStyled = true
end

-- Style chat buttons
function CF:StyleChatButtons(buttonFrame)
    if not buttonFrame then return end
    
    -- Find and style all buttons
    for i = 1, buttonFrame:GetNumChildren() do
        local button = select(i, buttonFrame:GetChildren())
        if button then
            self:StyleButton(button)
        end
    end
end

-- Style individual button
function CF:StyleButton(button)
    if not button or button.CrispyStyled then return end
    
    -- Enhance button appearance
    if button:GetNormalTexture() then
        button:GetNormalTexture():SetVertexColor(0.2, 0.6, 1.0, 0.8)
    end
    
    if button:GetHighlightTexture() then
        button:GetHighlightTexture():SetVertexColor(0.2, 0.6, 1.0, 1.0)
    end
    
    button.CrispyStyled = true
end

-- Apply modern chat style
function CF:ApplyModernStyle(config)
    -- Set up modern chat appearance
    for i = 1, NUM_CHAT_WINDOWS do
        local frame = _G["ChatFrame" .. i]
        if frame then
            -- Modern look adjustments
            frame:SetClampedToScreen(true)
            frame:SetClampRectInsets(0, 0, 0, 0)
            frame:SetMinResize(100, 50)
            frame:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
        end
    end
end

-- Add chat channel colors customization
function CF:CustomizeChannelColors()
    -- Enhanced channel colors with Crispy theme
    ChangeChatColor("CHANNEL1", 0.2, 0.6, 1.0)  -- Blue theme for general
    ChangeChatColor("CHANNEL2", 0.4, 0.8, 1.0)  -- Light blue for trade
end

-- Export module
CUI.ChatFrames = CF
