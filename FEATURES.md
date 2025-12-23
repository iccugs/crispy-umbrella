# CrispyUI Features

CrispyUI is a comprehensive cosmetic overhaul for World of Warcraft that enhances the visual appearance of the interface with a modern, cohesive blue theme.

## Core Features

### 🎨 Modern Frame Styling

The Frame Styling module applies a consistent visual theme across all major UI frames:

- **Custom Backdrop**: All frames get a sleek backdrop with configurable border and background colors
- **Signature Blue Border**: Crispy blue (RGB: 51, 153, 255) borders that stand out
- **Subtle Glow Effects**: Frames have a gentle glow overlay for depth
- **Styled Close Buttons**: Enhanced close button appearance on all frames

**Frames Enhanced:**
- Character Frame
- Spell Book
- Talent Frame
- Quest Frame & Quest Log
- Friends & Guild Frames
- PVP Frame
- World Map
- Game Menu & Options
- Mail Frame
- Bank Frame
- Merchant Frame
- Trade Frame
- Dialog boxes and popups

### ⚔️ Action Bar Enhancements

The Action Bars module modernizes your combat interface:

- **Icon Enhancement**: Cleaner icon borders with better visibility
- **Hover Effects**: Smooth blue glow animation when hovering over buttons
- **Custom Hotkey Styling**: Crispy blue colored hotkeys with improved font
- **Cooldown Improvements**: Enhanced cooldown display with better contrast
- **Button Polish**: Refined normal and highlight textures

**Features:**
- Configurable hotkey visibility
- Adjustable button spacing (default: 4px)
- Fade out options for out-of-combat
- Supports all default action bars (Main, Bottom, Side, Pet, Stance)
- Extra action button support

### 👤 Unit Frame Improvements

The Unit Frames module enhances how you see player, target, and party information:

- **Larger Health Bars**: Option for 20% larger health bars for better visibility
- **Class-Colored Health**: Automatically colors health bars by class
- **Portrait Borders**: Adds crispy blue borders to unit portraits
- **Status Bar Glow**: Subtle borders around health and mana bars
- **Enhanced Contrast**: Better visual separation of information

**Frames Affected:**
- Player Frame
- Target Frame
- Focus Frame
- Pet Frame
- Party Member Frames (1-4)

### 💬 Tooltip Enhancements

The Tooltips module adds useful information and improves appearance:

- **Item Level Display**: Automatically shows item level for equipment
- **Item ID Option**: Can display item IDs for debugging (disabled by default)
- **Modern Backdrop**: Consistent styling with the rest of CrispyUI
- **Custom Font Sizing**: Configurable tooltip font size (default: 12)
- **Visual Separator**: Adds decorative line separators in tooltips

**Enhanced Tooltips:**
- Game Tooltip
- Item Ref Tooltip
- Shopping Tooltips
- Battle Pet Tooltips
- Garrison Follower Tooltips

### 💭 Chat Frame Modernization

The Chat Frames module brings your chat into the modern era:

- **Modern Style**: Clean, contemporary appearance
- **Enhanced Font**: Slightly larger, more readable font
- **Edit Box Styling**: Custom backdrop for the chat input box
- **Focus Effects**: Edit box border brightens when typing
- **Auto-Fade**: Configurable fade-out timer (default: 10 seconds)
- **Button Styling**: Modernized chat window buttons

**Features:**
- Fade duration customization
- Modern chat frame positioning
- Enhanced channel color options
- Supports all chat windows (1-4)

## Color Scheme

CrispyUI uses a signature color palette:

- **Primary Blue**: RGB(51, 153, 255) / Hex #20a0ff
- **Border Color**: RGBA(0.2, 0.6, 1.0, 1.0)
- **Background**: RGBA(0.0, 0.0, 0.0, 0.8) - Semi-transparent black
- **Accent Glow**: Blue with varying alpha for depth

All colors can be customized through the configuration system.

## Configuration Options

### Slash Commands

Access features through simple commands:

```
/cui               - Show help menu
/cui toggle        - Enable/disable add-on
/cui status        - Display current status
/cui reload        - Reload UI (applies changes)
```

### Per-Module Toggle

Each cosmetic module can be individually enabled or disabled:

- Frame Styling
- Action Bars
- Unit Frames
- Tooltips
- Chat Frames

Settings are automatically saved to your account.

## Performance

CrispyUI is designed to be lightweight:

- **Minimal CPU Usage**: Only applies styling when needed
- **Smart Hooks**: Uses efficient event handling
- **No Constant Updates**: Changes apply on load and specific events
- **Memory Efficient**: Small footprint with no heavy libraries

## Compatibility

- **WoW Version**: Retail (The War Within - 11.0.2+)
- **Other Add-ons**: Designed to work alongside most add-ons
- **UI Scale**: Works with all UI scale settings
- **Resolution**: Supports all resolutions

### Known Compatibility

CrispyUI applies cosmetic changes that generally don't conflict with:
- Quest helper add-ons
- DPS meters
- Raid frames
- Inventory managers
- Auction house add-ons

**Note**: Other UI overhaul add-ons may conflict. If using ElvUI, Bartender, or similar, you may want to disable overlapping CrispyUI modules.

## Future Enhancements

Planned features for future versions:

- In-game configuration UI panel
- More color theme presets
- Additional font options
- Minimap styling
- Bag frame enhancements
- Quest tracker styling
- Nameplate improvements
- Profile system for multiple characters

## Technical Details

### Architecture

- **Modular Design**: Each feature is a separate module
- **Event-Driven**: Uses WoW's event system efficiently
- **Saved Variables**: Persistent settings across sessions
- **No External Dependencies**: Standalone, no library requirements

### File Structure

```
CrispyUI/
├── CrispyUI.toc     - Add-on manifest
├── Core.lua         - Main initialization and core functions
├── Config.lua       - Configuration system
└── Modules/
    ├── FrameStyling.lua  - Frame cosmetics
    ├── ActionBars.lua    - Action bar enhancements
    ├── UnitFrames.lua    - Unit frame improvements
    ├── Tooltips.lua      - Tooltip enhancements
    └── ChatFrames.lua    - Chat modernization
```

## Customization Examples

### Change Border Color

The border color can be customized (requires UI reload):

```lua
-- Edit Config.lua or use in-game command:
-- /cui bordercolor R G B A
-- Example for red borders:
-- /cui bordercolor 1.0 0.2 0.2 1.0
```

### Disable Specific Module

```lua
-- Disable tooltips only:
-- /cui toggle tooltips
```

## Credits

Created through an experimental AI voice-coding workflow as a proof of concept for modern development methodologies.

## License

GPL v3 - Free and open source
