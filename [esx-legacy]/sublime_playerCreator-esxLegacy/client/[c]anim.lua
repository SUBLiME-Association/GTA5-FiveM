
---@public
function SublimeIndex.PlayAnimCharacterCreator()
    ESX.Streaming.RequestAnimDict("timetable@reunited@ig_10", function()
        TaskPlayAnim(PlayerPedId(), "timetable@reunited@ig_10", "base_amanda", 8.0, -8.0, -1, 1, 0, false, false, false)
        RemoveAnimDict("timetable@reunited@ig_10")
        ESX.Streaming.RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a", function()
            TaskPlayAnim(PlayerPedId(), "amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", 8.0, -8.0, -1, 51, 0, false, false, false)
            RemoveAnimDict("amb@world_human_hang_out_street@female_arms_crossed@idle_a")
        end)
    end)
end