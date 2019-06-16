# GCore-Lib
Librairie Garry's Mod pour développer vos addons plus facilement et rapidement 

# Font Awesome
Cette librairie inclu tous les icons font awesome
```
  GCore.Lib:GetIcon( string type ( fas, fas ou far ), int taille, str codeUnicode, array tableauFont)
```
# Chaining
Cette librairie inclu le système de chaining sur les panels
```
    local frame = vgui.Create("GCore:DFrame")
        :SetSize(700,250)
        :SetHeader("G-Core Lib",50,{marginRight = 10})
        :Center()
        :SetDraggable(true)
        :MakePopup()
```
# Fonctions utiles 
Cette librairie à été conçu pour réunir plusieurs type de fonctions comme le blur, lerp
```
GCore.Lib:DrawBlur( panel, int amount, int densité )
GCore.Lib:LerpColor(panel btn, string nomUnique,array { default = Color(x,x,x,x), to = Color(x,x,x,x),boolean hovered? ( use btn:IsHovered() ), int Temps du lerp)
```

# Exemple 
![exemple](https://image.prntscr.com/image/TtjohLwmTgK_jjlttu6YRQ.png)

Code : [Sample.lua](https://github.com/SlownLS/gcore-lib/blob/master/gcore_lib/lua/gcore_lib/client/sample.lua)

# Informations

Cette librairie est loin d'être parfaite, si vous avez des suggestions n'hésitez pas à me les données 

Vous pouvez également faire des "Pull requests" pour modifié le code ( en mieux si possible :x )

Amusez-vous bien :)
