function isInteger(str)
    return not (str == "" or str:find("%D"))
end

function formatNumber(n)
    n = math.ceil(n * 100) / 100
    return n
end

function DrawText3D(x,y,z,text)
    SetTextFont(4)
    SetTextCentre(1)
    SetTextEntry("STRING")
    SetTextScale(0.35,0.35)
    SetTextColour(255,255,255,150)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z,0)
    DrawText(0.0,0.0)
    local factor = (string.len(text) / 450) + 0.01
    DrawRect(0.0,0.0125,factor,0.03,40,36,52,240)
    ClearDrawOrigin()
end

function DrawAdmin(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.3, 0.3)
        SetTextColour(255,255,255,255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropshadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end