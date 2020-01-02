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
  }

myStartupHook =
  spawn "xsetroot -solid '#333333'"
  --spawn
  --    "compton --backend glx --xrender-sync --xrender-sync-fence -fcCz -l -17 -t -17"
  --  <+> spawn "xsetroot -solid '#333333'"

