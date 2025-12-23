# Contributing to CrispyUI

Thank you for your interest in contributing to CrispyUI! This document provides guidelines for contributing to the project.

## Project Philosophy

CrispyUI was created as an experimental project using AI-assisted voice coding. The goal is to provide a lightweight, cosmetic UI enhancement for World of Warcraft that:

- Maintains a consistent visual theme
- Has minimal performance impact
- Remains compatible with other add-ons
- Requires no external dependencies
- Uses clean, readable code

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:

1. **Clear Title**: Brief description of the issue
2. **WoW Version**: Your World of Warcraft version and build
3. **Steps to Reproduce**: Detailed steps to recreate the bug
4. **Expected Behavior**: What should happen
5. **Actual Behavior**: What actually happens
6. **Screenshots**: If applicable
7. **Other Add-ons**: List of other UI add-ons you're using
8. **Error Messages**: Any Lua errors from the game

### Suggesting Features

Feature suggestions are welcome! Please include:

1. **Use Case**: Why this feature would be useful
2. **Description**: Detailed explanation of the feature
3. **Mockups**: Visual examples if applicable
4. **Compatibility**: How it fits with existing features

### Submitting Code

#### Code Style

- Use 4 spaces for indentation (no tabs)
- Follow existing naming conventions:
  - `PascalCase` for module names
  - `camelCase` for function names
  - `UPPER_SNAKE_CASE` for constants
- Add comments for complex logic
- Keep functions focused and single-purpose

#### Module Structure

Each module should follow this pattern:

```lua
-- CrispyUI: [Module Name]
-- [Brief description]

local ADDON_NAME, addon = ...
local CUI = CrispyUI

-- Create module
CUI.ModuleName = CUI.ModuleName or {}
local MOD = CUI.ModuleName

-- Module functions
function MOD:Apply()
    local config = CUI.db.moduleName
    
    if not config.enabled then
        return
    end
    
    -- Implementation here
end

-- Export module
CUI.ModuleName = MOD
```

#### Adding a New Module

1. Create a new file in `Modules/` directory
2. Follow the module structure above
3. Add the file to `CrispyUI.toc` in the appropriate section
4. Add default configuration in `Core.lua` defaults table
5. Add module call in `CUI:ApplyCosmetics()` function
6. Document the module in `FEATURES.md`
7. Update `CHANGELOG.md`

#### Testing Your Changes

1. Copy the add-on folder to your WoW AddOns directory
2. Launch WoW and enable CrispyUI
3. Test in-game functionality
4. Check for Lua errors (`/console scriptErrors 1`)
5. Verify no performance issues
6. Test with other common add-ons

### Pull Request Process

1. **Fork the Repository**: Create your own fork
2. **Create a Branch**: Use a descriptive name (`feature/minimap-styling`)
3. **Make Changes**: Follow code style guidelines
4. **Test Thoroughly**: Ensure everything works
5. **Update Documentation**: Add/update relevant docs
6. **Commit**: Use clear, descriptive commit messages
7. **Push**: Push to your fork
8. **Open PR**: Create a pull request with:
   - Clear title and description
   - Reference any related issues
   - List of changes made
   - Screenshots of visual changes

## Development Setup

### Prerequisites

- World of Warcraft (Retail)
- Text editor (VS Code, Sublime, etc.)
- Git for version control
- Basic knowledge of Lua

### Local Development

1. Clone the repository
2. Symlink or copy to your WoW AddOns folder:
   ```bash
   # Windows (PowerShell as Admin)
   New-Item -ItemType SymbolicLink -Path "C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\CrispyUI" -Target "C:\path\to\crispy-umbrella"
   
   # Mac/Linux
   ln -s /path/to/crispy-umbrella "/Applications/World of Warcraft/_retail_/Interface/AddOns/CrispyUI"
   ```
3. Make changes to your local files
4. Reload UI in-game (`/reload`) to test

### Debugging

Enable Lua errors in-game:
```
/console scriptErrors 1
```

Use print statements for debugging:
```lua
CUI:Print("Debug: variable = " .. tostring(variable))
```

### Useful WoW API Resources

- [WoW Programming Wiki](https://wowpedia.fandom.com/wiki/World_of_Warcraft_API)
- [WoW UI & Macro Forums](https://us.forums.blizzard.com/en/wow/c/ui-macros)
- [WoW Interface](https://www.wowinterface.com/)

## Coding Standards

### Lua Best Practices

- Avoid global variables (use `local` whenever possible)
- Cache frame references instead of repeated lookups
- Use frame:HookScript() instead of :SetScript() when possible
- Clean up after yourself (unregister events, remove hooks)
- Handle nil cases gracefully

### Performance Considerations

- Minimize operations in frequently-called functions
- Use `C_Timer.After()` for delayed operations
- Avoid heavy operations during combat
- Cache color tables instead of creating new ones
- Use frame recycling for dynamic UI elements

### Security

- Never use loadstring() or RunScript() with user input
- Validate all user inputs
- Don't execute code from untrusted sources
- Be careful with saved variables (sanitize data)

## What We're Looking For

### High Priority

- Bug fixes
- Performance improvements
- Compatibility fixes with other add-ons
- WoW version updates

### Medium Priority

- New cosmetic modules
- Configuration UI panel
- Additional customization options
- Code cleanup and optimization

### Low Priority (But Still Welcome!)

- Additional color themes
- Minor visual tweaks
- Documentation improvements
- Code comments

## What We're NOT Looking For

- Gameplay-affecting features
- Features that require external libraries
- Non-cosmetic modifications
- Features that conflict with Blizzard's ToS
- Overly complex solutions to simple problems

## Questions?

If you have questions about contributing:

1. Check existing issues and pull requests
2. Review the documentation
3. Open a new issue with the "question" label

## License

By contributing to CrispyUI, you agree that your contributions will be licensed under the GPL v3 license.

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- CHANGELOG.md for significant contributions
- Special thanks in README.md for major features

Thank you for helping make CrispyUI better!
