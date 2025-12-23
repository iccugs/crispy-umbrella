-- CrispyUI: Core addon initialization
-- A cosmetic UI overhaul created through AI voice workflow

local ADDON_NAME, addon = ...

-- Create addon namespace
CrispyUI = CrispyUI or {}
local CUI = CrispyUI

-- Version info
CUI.version = "1.0.0"
CUI.author = "AI Voice Workflow"
CUI.isLoaded = false

-- Default settings
local defaults = {
    enabled = true,
    frameStyling = {
        enabled = true,
        borderColor = {0.2, 0.6, 1.0, 1.0}, -- Crispy blue
        backgroundColor = {0.0, 0.0, 0.0, 0.8},
        borderSize = 2,
    },
    actionBars = {
        enabled = true,
        showHotkeys = true,
        buttonSpacing = 4,
        fadeOut = true,
    },
    unitFrames = {
        enabled = true,
        showPortraits = true,
        largerHealthBars = true,
        colorByClass = true,
    },
    tooltips = {
        enabled = true,
        showItemLevel = true,
        showItemID = false,
        fontSize = 12,
    },
    chatFrames = {
        enabled = true,
        modernStyle = true,
        fadeOutTime = 10,
    },
}

-- Initialize saved variables with defaults
local function InitializeDB()
    if not CrispyUIDB then
        CrispyUIDB = {}
    end
    
    -- Deep copy defaults (handles nested tables properly)
    local function deepCopy(original)
        local copy
        if type(original) == "table" then
            copy = {}
            for key, value in pairs(original) do
                copy[key] = deepCopy(value)
            end
        else
            copy = original
        end
        return copy
    end
    
    -- Apply defaults if not set
    for key, value in pairs(defaults) do
        if CrispyUIDB[key] == nil then
            CrispyUIDB[key] = deepCopy(value)
        end
    end
    
    CUI.db = CrispyUIDB
end

-- Event frame for handling events
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

-- Event handler
eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == ADDON_NAME then
            CUI:OnInitialize()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        if not CUI.isLoaded then
            CUI:OnEnable()
            CUI.isLoaded = true
        else
            CUI:ApplyCosmetics()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        CUI:ApplyCosmetics()
    end
end)

-- Initialize the addon
function CUI:OnInitialize()
    -- Setup database with defaults
    InitializeDB()
    
    -- Register slash commands
    SLASH_CRISPYUI1 = "/crispyui"
    SLASH_CRISPYUI2 = "/cui"
    SlashCmdList["CRISPYUI"] = function(msg)
        CUI:SlashCommand(msg)
    end
    
    -- Print welcome message
    self:Print("CrispyUI v" .. self.version .. " loaded! Type /cui for options.")
end

-- Called when addon is enabled
function CUI:OnEnable()
    -- Apply cosmetic changes
    self:ApplyCosmetics()
    
    self:Print("CrispyUI enabled! Applying cosmetic enhancements...")
end

-- Apply all cosmetic enhancements
function CUI:ApplyCosmetics()
    if not self.db or not self.db.enabled then
        return
    end
    
    -- Apply each module's cosmetics
    if self.FrameStyling and self.db.frameStyling.enabled then
        self.FrameStyling:Apply()
    end
    
    if self.ActionBars and self.db.actionBars.enabled then
        self.ActionBars:Apply()
    end
    
    if self.UnitFrames and self.db.unitFrames.enabled then
        self.UnitFrames:Apply()
    end
    
    if self.Tooltips and self.db.tooltips.enabled then
        self.Tooltips:Apply()
    end
    
    if self.ChatFrames and self.db.chatFrames.enabled then
        self.ChatFrames:Apply()
    end
end

-- Slash command handler
function CUI:SlashCommand(input)
    input = string.lower(input or "")
    
    if input == "toggle" then
        self.db.enabled = not self.db.enabled
        if self.db.enabled then
            self:Print("CrispyUI enabled!")
            self:ApplyCosmetics()
        else
            self:Print("CrispyUI disabled! Reload UI to revert changes.")
        end
    elseif input == "reload" or input == "rl" then
        ReloadUI()
    elseif input == "status" then
        self:Print("Status: " .. (self.db.enabled and "|cff00ff00Enabled|r" or "|cffff0000Disabled|r"))
        self:Print("Version: " .. self.version)
    else
        self:Print("CrispyUI Commands:")
        self:Print("/cui toggle - Toggle addon on/off")
        self:Print("/cui status - Show current status")
        self:Print("/cui reload - Reload UI")
    end
end

-- Utility function to apply backdrop styling
function CUI:ApplyBackdrop(frame, config)
    config = config or self.db.frameStyling
    
    if not frame then
        return
    end
    
    -- For modern WoW, use BackdropTemplate mixin
    if not frame.SetBackdrop then
        if BackdropTemplateMixin then
            Mixin(frame, BackdropTemplateMixin)
        end
    end
    
    if frame.SetBackdrop then
        local backdrop = {
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            tile = true,
            tileSize = 16,
            edgeSize = config.borderSize or 2,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        }
        
        frame:SetBackdrop(backdrop)
        
        if config.backgroundColor then
            frame:SetBackdropColor(unpack(config.backgroundColor))
        end
        
        if config.borderColor then
            frame:SetBackdropBorderColor(unpack(config.borderColor))
        end
    end
end

-- Print helper with addon prefix
function CUI:Print(msg)
    print("|cff20a0ff[CrispyUI]|r " .. tostring(msg))
end
