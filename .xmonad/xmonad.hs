import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Azerty
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)
import System.IO

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

myPP = xmobarPP
  { ppCurrent = xmobarColor "#429942" ""
  . wrap "[" "]"
  }

myConfig = azertyConfig
  { terminal = "urxvt"
  , modMask  = mod4Mask
  , startupHook   = myStartupHook
  , layoutHook   = myLayout
  , focusedBorderColor = "#5e8d87"
  , normalBorderColor = "#282a2e"
  } `additionalKeys` myAdditionalKeys `additionalKeysP` myKeys

myStartupHook =
  -- Hack to have java guis work within xmonad
  setWMName "LG3D"
  <+> spawn "picom --config ~/.xmonad/picom.conf"
  <+> spawn "feh --bg-scale ~/.xmonad/wallpapers/blurred.jpg"
  <+> spawn "xautolock -time 5 -locker slock"

myAdditionalKeys =
  [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
  ]

myKeys =
  [ ("<XF86MonBrightnessUp>", spawn "~/.xmonad/brightness.sh +5")
  , ("<XF86MonBrightnessDown>", spawn "~/.xmonad/brightness.sh -5")
  ]

myLayout = avoidStruts $
  Tall 1 (10/100) (2/3)
  ||| Grid
  ||| Full
