---@type table
local SettingsSeparator = {
    Background = { Width = 431, Height = 18 },
    Text = { X = 8, Y = 2, Scale = 0.33 },
}

---Separator
---@param Label string
function RageUI.Separator(Label)
    local CurrentMenu = RageUI.CurrentMenu

    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUI.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                RageUI.ItemsSafeZone(CurrentMenu)

                RenderText(Label or "", CurrentMenu.X + SettingsSeparator.Text.X,
                    CurrentMenu.Y + SettingsSeparator.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0,
                    SettingsSeparator.Text.Scale, 245, 245, 245, 255)
            end

            RageUI.ItemOffset = RageUI.ItemOffset + SettingsSeparator.Background.Height
            RageUI.Options = RageUI.Options + 1
        end
    end
end
