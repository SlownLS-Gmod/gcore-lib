--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local TABLE = {}

TABLE.colors = {
    background = Color(255,255,255,255),
    primary =  Color(200,200,200),
    secondary =  Color(150,150,150),
    valid = Color(30,134,74),
    checkBoxColor = {default = color_white, to = Color(210,68,68)},
    buttonColor = {default = Color(200,200,200), to = Color(150,150,150)},
    lightRed = Color(210,68,68),
    red = Color(134,45,30),
}

GCore.Lib.Themes:Add("light",TABLE)