-- CrispyUI: Configuration System
-- Provides runtime configuration and settings management

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Configuration panel
CUI.Config = CUI.Config or {}
local Config = CUI.Config

-- Initialize configuration
function Config:Initialize()
    -- This function is called after the addon is loaded
    -- Settings are stored in CUI.db (handled by Core.lua)
end

-- Reset to defaults
function Config:ResetToDefaults()
    if CUI.db then
        -- Clear saved variables
        for k in pairs(CUI.db) do
            CUI.db[k] = nil
        end
        CUI:Print("Settings reset to defaults. Reloading UI...")
        C_Timer.After(1, ReloadUI)
    end
end

-- Export current settings
function Config:ExportSettings()
    if not CUI.db then return end
    
    local settings = CUI.db
    CUI:Print("Current Settings:")
    CUI:Print("Frame Styling: " .. (settings.frameStyling.enabled and "Enabled" or "Disabled"))
    CUI:Print("Action Bars: " .. (settings.actionBars.enabled and "Enabled" or "Disabled"))
    CUI:Print("Unit Frames: " .. (settings.unitFrames.enabled and "Enabled" or "Disabled"))
    CUI:Print("Tooltips: " .. (settings.tooltips.enabled and "Enabled" or "Disabled"))
    CUI:Print("Chat Frames: " .. (settings.chatFrames.enabled and "Enabled" or "Disabled"))
end

-- Toggle individual module
function Config:ToggleModule(moduleName)
    if not CUI.db then return end
    
    local moduleKey = moduleName:lower():gsub(" ", "")
    if CUI.db[moduleKey] then
        CUI.db[moduleKey].enabled = not CUI.db[moduleKey].enabled
        local status = CUI.db[moduleKey].enabled and "enabled" or "disabled"
        CUI:Print(moduleName .. " " .. status .. ". Reload UI to apply changes.")
    else
        CUI:Print("Unknown module: " .. moduleName)
    end
end

-- Color configuration helpers
function Config:SetBorderColor(r, g, b, a)
    if not CUI.db then return end
    
    r = tonumber(r) or 0.2
    g = tonumber(g) or 0.6
    b = tonumber(b) or 1.0
    a = tonumber(a) or 1.0
    
    CUI.db.frameStyling.borderColor = {r, g, b, a}
    CUI:Print(string.format("Border color set to RGBA(%.2f, %.2f, %.2f, %.2f)", r, g, b, a))
    CUI:Print("Reload UI to apply changes.")
end

function Config:SetBackgroundColor(r, g, b, a)
    if not CUI.db then return end
    
    r = tonumber(r) or 0.0
    g = tonumber(g) or 0.0
    b = tonumber(b) or 0.0
    a = tonumber(a) or 0.8
    
    CUI.db.frameStyling.backgroundColor = {r, g, b, a}
    CUI:Print(string.format("Background color set to RGBA(%.2f, %.2f, %.2f, %.2f)", r, g, b, a))
    CUI:Print("Reload UI to apply changes.")
end

-- Extended slash command handler with config options
function Config:HandleCommand(input)
    input = string.lower(input or "")
    local args = {}
    for arg in string.gmatch(input, "%S+") do
        table.insert(args, arg)
    end
    
    local cmd = args[1]
    
    if cmd == "config" or cmd == "settings" then
        self:ExportSettings()
    elseif cmd == "reset" then
        self:ResetToDefaults()
    elseif cmd == "toggle" and args[2] then
        self:ToggleModule(args[2])
    elseif cmd == "bordercolor" and args[2] then
        self:SetBorderColor(tonumber(args[2]), tonumber(args[3]), tonumber(args[4]), tonumber(args[5]))
    elseif cmd == "bgcolor" and args[2] then
        self:SetBackgroundColor(tonumber(args[2]), tonumber(args[3]), tonumber(args[4]), tonumber(args[5]))
    else
        return false -- Command not handled
    end
    
    return true -- Command handled
end

-- Register extended commands with core
if CUI.RegisterSlashCommand then
    CUI:RegisterSlashCommand("config", function() Config:ExportSettings() end)
    CUI:RegisterSlashCommand("reset", function() Config:ResetToDefaults() end)
end

-- Export module
CUI.Config = Config
