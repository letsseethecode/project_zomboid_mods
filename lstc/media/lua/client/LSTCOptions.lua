LSTC = LSTC or {}
LSTC.Options = LSTC.Options or {}

LSTC.Options.Peek = true
LSTC.Options.LockPicking = true

local function OnApply(optionValues)
    LSTC.Options.Peek = optionValues.settings.options.peek
    LSTC.Options.LockPicking = optionValues.settings.options.LockPicking
    -- self:resetLua()
end

if ModOptions and ModOptions.getInstance then
    local SETTINGS = {
        mod_id = 'LSTC',
        mod_shortname = getText("UI_LSTC_Mod_Short"),
        mod_fullname = getText("UI_LSTC_Mod_Long"),
        options = {
        },
        options_data = {
            peek = {
                -- other properties of the option:
                name = "UI_LSTC_Peek",
                tooltip = "UI_LSTC_Peek_Tooltip",
                default = true,
                OnApplyMainMenu = OnApply,
                OnApplyInGame = OnApply,
            },
            LockPicking = {
                name = "UI_LSTC_LockPicking",
                tooltip = "UI_LSTC_LockPicking_Tooltip",
                default = true,
                OnApplyMainMenu = OnApply,
                OnApplyInGame = OnApply,
            }
        },
    }

    ModOptions:getInstance(SETTINGS)
end

-- Check actual options at game loading.
Events.OnGameStart.Add(function()
    print("door = ", LSTC.Options.door)
end)
