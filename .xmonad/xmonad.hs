import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar"

myPP = xmobarPP
  { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
  }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = desktopConfig
  { terminal = "urxvt"
  , modMask  = mod4Mask
  , startupHook   = myStartupHook
  , focusedBorderColor = "#5e8d87"
  , normalBorderColor = "#282a2e"
  }

myStartupHook =
  spawn "picom --config ~/.xmonad/picom.conf"
  <+> spawn "feh --bg-scale ~/.xmonad/mont-saint-michel.jpg"
