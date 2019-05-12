function GetFiveMLicense(playerSrc)
    local identifiers = GetPlayerIdentifiers(playerSrc)
    for i = 1, #identifiers, 1 do
        if (string.sub(identifiers[i], 1, 7) == "license") then
            return identifiers[i]
        end
    end
end