function GCore.Lib:GetColor(col, theme)
    if !theme then
        theme = GCore.Lib.Themes.Selected
    end

    local colors = GCore.Lib.Themes.List[GCore.Lib.Themes.Selected].colors

    return colors[col]
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