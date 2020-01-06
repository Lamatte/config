import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Azerty
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig (additionalKeys)

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar"

myPP = xmobarPP
  { ppCurrent = xmobarColor "#429942" ""
  . wrap "<" ">"
  }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = azertyConfig
  { terminal = "urxvt"
  , modMask  = mod4Mask
  , startupHook   = myStartupHook
  , focusedBorderColor = "#5e8d87"
  , normalBorderColor = "#282a2e"
  } `additionalKeys` myKeys

myStartupHook =
  -- Hack to have java guis work within xmonad
  setWMName "LG3D"
  <+> spawn "picom --config ~/.xmonad/picom.conf"
  <+> spawn "feh --bg-scale ~/.xmonad/wallpapers/blurred.jpg"
  <+> spawn "xautolock -time 5 -locker slock"

myKeys =
  [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
  ]
