_Admin.Keys = { ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 34, ["W"] = 20, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 85, ["S"] = 33, ["D"] = 35, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 32, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118 }


local Ibuttons = nil


function SetIButtons(buttons, layout) --Layout: 0 - Horizontal, 1 - vertical
    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(Ibuttons) then
            Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(Ibuttons) do
                Citizen.Wait(0)
            end
        end
        local sf = Ibuttons
        local w,h = GetScreenResolution()
        PushScaleformMovieFunction(sf,"INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunction()
        --PushScaleformMovieFunction(sf,"SET_BACKGROUND_COLOUR")
        --PushScaleformMovieFunctionParameterInt(0)
        --PushScaleformMovieFunctionParameterInt(0)
        --PushScaleformMovieFunctionParameterInt(0)
        --PushScaleformMovieFunctionParameterInt(100)
        --PopScaleformMovieFunction()

        for i,btn in pairs(buttons) do
            PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(i-1)
            PushScaleformMovieFunctionParameterString(btn[1])
            PushScaleformMovieFunctionParameterString(btn[2])
            PopScaleformMovieFunction()

        end
        if layout ~= 1 then
            PushScaleformMovieFunction(sf,"SET_PADDING")
            PushScaleformMovieFunctionParameterInt(10)
            PopScaleformMovieFunction()
        end
        PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(layout)
        PopScaleformMovieFunction()
    end)
end

function DrawIButtons() -- Layout: 1 - vertical,0 - horizontal
    if HasScaleformMovieLoaded(Ibuttons) then
        DrawScaleformMovie(Ibuttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
    end
end



--[[
////////////////////////////Usage///////////////////////////////////
--In same resource
--Setting up
SetIbuttons({
{GetControlInstructionalButton(1,Keys["NENTER"],0),"Select"},
{GetControlInstructionalButton(1,Keys["TOP"],0),"Up"},
{GetControlInstructionalButton(1,Keys["DOWN"],0),"Down"},
}, 0)
--Drawing
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1,27) then --If is holding UP ARROW key
			DrawIbuttons()
		end
	end
end)
--In other resources
--Setting up
exports.Ibuttons:SetIbuttons({
{GetControlInstructionalButton(1,Keys["NENTER"],0),"Select"},
{GetControlInstructionalButton(1,Keys["TOP"],0),"Up"},
{GetControlInstructionalButton(1,Keys["DOWN"],0),"Down"},
}, 0)
--Drawing
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1,27) then --If is holding UP ARROW key
			exports.Ibuttons:DrawIbuttons()
		end
	end
end)
]]


--