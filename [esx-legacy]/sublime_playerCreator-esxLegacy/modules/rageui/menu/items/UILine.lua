---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUI
---

---@type table

local SettingsButton = {
    Rectangle = { Y = 0, Width = 420, Height = 38 },
    Line = { X = 8, Y = 15 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}


function RageUI.Line(Style)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if Style then
                    if Style.BackgroundColor then
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.BackgroundColor[1], Style.BackgroundColor[2], Style.BackgroundColor[3], Style.BackgroundColor[4])
                    end
                    if Style.Line then
                        RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 60), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 300, 3, Style.Line[1], Style.Line[2], Style.Line[3], Style.Line[4])
                    end
                else
                    RenderRectangle(CurrentMenu.X + SettingsButton.Line.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 60), CurrentMenu.Y + SettingsButton.Line.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 300, 3, 255, 255, 255, 255)
                end

                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end

