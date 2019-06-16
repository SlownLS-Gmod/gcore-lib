GCore.Lib.Colors = {
    lightBlack = Color(31,32,36),
    black = Color(22,23,25),
    red = Color(134,45,30),
    lightRed = Color(210,68,68),
    blue = Color(37,99,143),
    lightBlue = Color(45,150,168),
    green = Color(30,134,74),
    lightGreen = Color(32,179,168),
    yellow = Color(177,179,32),
    lightYellow = Color(187,210,68),
    orange = Color(157,122,30),
    lightOrange = Color(210,130,68),
    pink = Color(179,32,103),
    lightPink = Color(210,68,140),
}

function GCore.Lib:GetColor(col)
    return GCore.Lib.Colors[col]
end

function GCore.Lib:LerpColor(btn,strName,tblColor,boolHovered,intTimeFade)
    btn.tblLerps = btn.tblLerps or {}
    btn.tblLerps[strName] = btn.tblLerps[strName] or {}

    local intTimeLerp = FrameTime() * ( intTimeFade or 5 )
    local default = table.Copy(tblColor.default)
    local to = table.Copy(tblColor.to)

    btn.tblLerps[strName].actual = btn.tblLerps[strName].actual or default

    if !boolHovered then
        btn.tblLerps[strName].actual.r = Lerp(intTimeLerp,btn.tblLerps[strName].actual.r,default.r)
        btn.tblLerps[strName].actual.g = Lerp(intTimeLerp,btn.tblLerps[strName].actual.g,default.g)
        btn.tblLerps[strName].actual.b = Lerp(intTimeLerp,btn.tblLerps[strName].actual.b,default.b)
        btn.tblLerps[strName].actual.a = Lerp(intTimeLerp,btn.tblLerps[strName].actual.a,default.a)
    else
        btn.tblLerps[strName].actual.r = Lerp(intTimeLerp,btn.tblLerps[strName].actual.r,to.r)
        btn.tblLerps[strName].actual.g = Lerp(intTimeLerp,btn.tblLerps[strName].actual.g,to.g)
        btn.tblLerps[strName].actual.b = Lerp(intTimeLerp,btn.tblLerps[strName].actual.b,to.b)
        btn.tblLerps[strName].actual.a = Lerp(intTimeLerp,btn.tblLerps[strName].actual.a,to.a)
    end

    return btn.tblLerps[strName].actual
end