
local _ = {
    rank = nil;
}


function _Admin.Panel:OwnerManagement(rank)
    _.rank = rank

    RageUI.Button("Gestion des bans", nil, {RightLabel = "~c~→→→"}, true, {
        onSelected = function()
            _Admin.RefreshBans()
        end
    }, _Admin.Menu.sub_ownerManagementBans)

    RageUI.Button("Gestion des staff", nil, {RightLabel = "~c~→→→"}, true, {
        onSelected = function()
            _Admin.RefreshStaff()
        end
    }, _Admin.Menu.sub_ownerManagementStaff)

end