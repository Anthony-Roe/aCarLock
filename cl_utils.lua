function GetVehicleInFront()
	local myPed = GetPlayerPed(-1)
	local myPos = GetEntityCoords(myPed, 1)
	local frontOfPlayer = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 3.0, 0.0)
	local closeVehicle = GetEntityInDirection(myPos, frontOfPlayer, 2)
	local closeVehicleOnGround = GetEntityInDirectionOnGround(myPos, frontOfPlayer, 2)
    if DoesEntityExist(closeVehicle) then
        if (IsEntityAVehicle(closeVehicle)) then
            return closeVehicle
        end
    elseif DoesEntityExist(closeVehicleOnGround) then
        if (IsEntityAVehicle(closeVehicleOnGround)) then
            return closeVehicleOnGround
        end
	else
		return false
	end
end

function GetSeatPedIsIn(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    for i=-2,maxSeats do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i, maxSeats end
    end
    return -2
end

function GetEntityInDirection(coordFrom, coordTo, flag)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, flag, GetPlayerPed(-1), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end

function GetEntityInDirectionOnGround(coordFrom, coordTo, flag)
	local bool, groundZ = GetGroundZFor_3dCoord(coordTo.x, coordTo.y, coordTo.z, 0)
    local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z - 0.7, coordTo.x, coordTo.y, groundZ, flag, GetPlayerPed(-1), 0)
    local _, _, _, _, entity = GetShapeTestResult(rayHandle)
    return entity
end