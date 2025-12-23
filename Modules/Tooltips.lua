-- CrispyUI: Tooltips Module
-- Enhances tooltips with additional information and modern styling

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Create module
CUI.Tooltips = CUI.Tooltips or {}
local TT = CUI.Tooltips

-- Apply tooltip enhancements
function TT:Apply()
    local config = CUI.db.profile.tooltips
    
    if not config.enabled then
        return
    end
    
    -- Hook tooltip display
    GameTooltip:HookScript("OnShow", function(self)
        TT:EnhanceTooltip(self, config)
    end)
    
    ItemRefTooltip:HookScript("OnShow", function(self)
        TT:EnhanceTooltip(self, config)
    end)
    
    -- Style all tooltip-related frames
    self:StyleTooltipFrames()
end

-- Enhance individual tooltip
function TT:EnhanceTooltip(tooltip, config)
    if not tooltip then return end
    
    -- Apply modern backdrop
    CUI:ApplyBackdrop(tooltip)
    
    -- Set font size
    if config.fontSize then
        local font, _, flags = GameTooltipText:GetFont()
        if font then
            for i = 1, tooltip:NumLines() do
                local line = _G[tooltip:GetName() .. "TextLeft" .. i]
                if line then
                    line:SetFont(font, config.fontSize, flags)
                end
                
                line = _G[tooltip:GetName() .. "TextRight" .. i]
                if line then
                    line:SetFont(font, config.fontSize, flags)
                end
            end
        end
    end
    
    -- Add item level to item tooltips
    if config.showItemLevel then
        self:AddItemLevel(tooltip)
    end
    
    -- Add item ID if enabled
    if config.showItemID then
        self:AddItemID(tooltip)
    end
    
    -- Add visual separator
    self:AddSeparator(tooltip)
end

-- Add item level to tooltip
function TT:AddItemLevel(tooltip)
    local _, link = tooltip:GetItem()
    if not link then return end
    
    local itemLevel = GetDetailedItemLevelInfo(link)
    if itemLevel and itemLevel > 0 then
        -- Check if we already added it
        for i = 1, tooltip:NumLines() do
            local line = _G[tooltip:GetName() .. "TextLeft" .. i]
            if line and line:GetText() and string.find(line:GetText(), "Item Level") then
                return
            end
        end
        
        tooltip:AddLine("|cff20a0ffItem Level: " .. itemLevel .. "|r")
        tooltip:Show()
    end
end

-- Add item ID to tooltip
function TT:AddItemID(tooltip)
    local _, link = tooltip:GetItem()
    if not link then return end
    
    local itemID = tonumber(link:match("item:(%d+)"))
    if itemID then
        -- Check if we already added it
        for i = 1, tooltip:NumLines() do
            local line = _G[tooltip:GetName() .. "TextLeft" .. i]
            if line and line:GetText() and string.find(line:GetText(), "Item ID") then
                return
            end
        end
        
        tooltip:AddLine("|cff808080Item ID: " .. itemID .. "|r")
        tooltip:Show()
    end
end

-- Add visual separator
function TT:AddSeparator(tooltip)
    if not tooltip.CrispySeparator then
        local separator = tooltip:CreateTexture(nil, "ARTWORK")
        separator:SetTexture("Interface\\Buttons\\WHITE8X8")
        separator:SetHeight(1)
        separator:SetPoint("LEFT", tooltip, "LEFT", 10, 0)
        separator:SetPoint("RIGHT", tooltip, "RIGHT", -10, 0)
        separator:SetVertexColor(0.2, 0.6, 1.0, 0.5)
        tooltip.CrispySeparator = separator
    end
end

-- Style tooltip frames
function TT:StyleTooltipFrames()
    local tooltips = {
        GameTooltip,
        ItemRefTooltip,
        ShoppingTooltip1,
        ShoppingTooltip2,
        FloatingBattlePetTooltip,
        FloatingPetBattleAbilityTooltip,
        FloatingGarrisonFollowerTooltip,
    }
    
    for _, tooltip in ipairs(tooltips) do
        if tooltip then
            CUI:ApplyBackdrop(tooltip)
        end
    end
end

-- Export module
CUI.Tooltips = TT
