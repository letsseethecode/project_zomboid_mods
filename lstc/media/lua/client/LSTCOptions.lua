LSTC = LSTC or {}
LSTC.Options = LSTC.Options or {}

local function OnApply(self, val)
    self:resetLua()
end

if ModOptions and ModOptions.getInstance then
    local SETTINGS = {
        mod_id = 'LSTC',
        mod_shortname = getText("UI_LSTC_Mod_Short"),
        mod_fullname = getText("UI_LSTC_Mod_Long"),
        options_data = {
            doors = {
                getText("UI_Mod_LSTC_Option_Door_Internal"),
                getText("UI_Mod_LSTC_Option_Door_External"),
                getText("UI_Mod_LSTC_Option_Door_All"),

                -- other properties of the option:
                name = "UI_Mod_LSTC_Option_Doors",
                tooltip = "UI_Mod_LSTC_Option_Doors_Tooltip",
                default = 2,
                OnApplyMainMenu = OnApply,
                OnApplyInGame = OnApply,
            },
        },
    }

    ModOptions:getInstance(SETTINGS)
end

-- Check actual options at game loading.
Events.OnGameStart.Add(function()
    print("door = ", LSTC.Options.door)
end)
