

function _Admin:HaveAccess(rank, btn)
    if (rank.grade ~= "Owner" ) then
        for k,v in ipairs(btn) do
            if (rank.grade == v) then
                return true
            end
        end
    else
        return true
    end
end

