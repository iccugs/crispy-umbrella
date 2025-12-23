# CrispyUI Installation Guide

## Requirements

- World of Warcraft (Retail version)
- Compatible with Interface version: 110002 (The War Within)

## Installation Steps

### Method 1: Manual Installation

1. **Download the Add-on**
   - Download the repository as a ZIP file or clone it
   - If downloaded as ZIP, extract it to a temporary location

2. **Locate Your WoW AddOns Folder**
   - Windows: `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\`
   - Mac: `/Applications/World of Warcraft/_retail_/Interface/AddOns/`
   - Or find it through your WoW installation directory

3. **Install the Add-on**
   - Copy the entire `crispy-umbrella` folder to the AddOns directory
   - Optionally rename it to `CrispyUI` for clarity
   - Ensure the folder structure looks like this:
     ```
     AddOns/
       └── CrispyUI/
           ├── CrispyUI.toc
           ├── Core.lua
           ├── Config.lua
           ├── Modules/
           │   ├── ActionBars.lua
           │   ├── ChatFrames.lua
           │   ├── FrameStyling.lua
           │   ├── Tooltips.lua
           │   └── UnitFrames.lua
           └── README.md
     ```

4. **Enable the Add-on**
   - Launch World of Warcraft
   - At the character selection screen, click "AddOns" button (bottom left)
   - Find "CrispyUI" in the list and check it to enable
   - Click "Okay"

5. **Load into Game**
   - Select your character and enter the game
   - You should see a message: `[CrispyUI] CrispyUI v1.0.0 loaded! Type /cui for options.`

## First-Time Configuration

Once in game, you can use these commands:

- `/cui` or `/crispyui` - Display available commands
- `/cui status` - Check if the add-on is running
- `/cui toggle` - Enable or disable the add-on

## Verifying Installation

To verify CrispyUI is working:

1. Type `/cui status` in chat
2. You should see: `Status: Enabled` and `Version: 1.0.0`
3. Look at your UI - you should notice:
   - Frames have a subtle blue border glow
   - Action buttons have enhanced hover effects
   - Tooltips show item levels
   - Chat frames have modern styling

## Troubleshooting

### Add-on Not Appearing in List

- Make sure the folder is directly in the `AddOns` folder
- Check that `CrispyUI.toc` file exists in the folder
- Verify the folder name doesn't have extra characters or spaces

### Add-on Enabled But Not Working

- Type `/reload` to reload the UI
- Check the Interface version in the TOC file matches your WoW version
- Look for any error messages in the chat window

### Errors or Lua Issues

- Disable other UI add-ons to check for conflicts
- Try a fresh installation
- Check that all files are present and not corrupted

### Reverting Changes

If you want to disable the cosmetic changes:
- Type `/cui toggle` to disable (requires UI reload to fully revert)
- Or disable the add-on from the AddOns menu and reload UI

## Uninstallation

1. Exit World of Warcraft completely
2. Navigate to your AddOns folder
3. Delete the `CrispyUI` (or `crispy-umbrella`) folder
4. Restart WoW

## Getting Help

If you encounter issues:
- Check the GitHub repository for updates
- Review the README.md for command documentation
- Open an issue on GitHub with details about your problem

## Notes

- Your settings are saved in `WTF/Account/[YourAccount]/SavedVariables/CrispyUI.lua`
- Back up this file to preserve your customizations
- The add-on applies changes on login and after combat ends
