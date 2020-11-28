import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Azerty
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import Data.Ratio ((%))
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)
import XMonad.Actions.WorkspaceNames
import System.IO

main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myWorkspaces = ["1:console", "2:web", "3:im", "4:code", "5", "6", "7", "8:coopnet", "9:misc"]

toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

myPP = xmobarPP
  { ppCurrent = xmobarColor "#5e8d87" "" . wrap "[" "]"
  , ppOrder   = \(ws:l:t:_)   -> [ws,l]
  , ppSep     = " <fn=1>\xf2d2</fn> "
  }

myConfig = azertyConfig
  { terminal = "urxvt"
  , workspaces = myWorkspaces
  , manageHook = myManageHook <+> manageHook defaultConfig
  , modMask  = mod4Mask
  , startupHook   = myStartupHook
  , layoutHook   = myLayout
  , logHook   = myLogHook
  , focusedBorderColor = "#5e8d87"
  , normalBorderColor = "#282a2e"
  } `additionalKeys` myAdditionalKeys `additionalKeysP` myKeys

myStartupHook =
  -- Hack to have java guis work within xmonad
  setWMName "LG3D"
  <+> spawn "picom --config ~/.xmonad/picom.conf"
  <+> spawn "feh --bg-scale ~/.xmonad/wallpapers/blurred.jpg"
  <+> spawn "xautolock -time 10 -locker slock"

myLogHook = 
  workspaceNamesPP xmobarPP >>= dynamicLogString >>= xmonadPropLog

myAdditionalKeys =
  [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
    , ((mod4Mask .|. shiftMask, xK_r      ), renameWorkspace def)
  ]

myKeys =
  [ ("<XF86MonBrightnessUp>", spawn "~/.xmonad/brightness.sh +5")
  , ("<XF86MonBrightnessDown>", spawn "~/.xmonad/brightness.sh -5")
  , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 2%-")
  , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 2%+")
  , ("<XF86AudioMute>", spawn "amixer set Speaker+LO toggle")
  ]

myLayout = avoidStruts $ workspaceLayouts

defaultLayouts = Tall 1 (2/100) (2/3) ||| Mirror (Tall 1 (2/100) (2/3)) ||| Full ||| Grid

workspaceLayouts =
  onWorkspace "1:console" Grid $
  onWorkspace "2:web" Full $
  onWorkspace "3:im" imLayout $
  onWorkspace "4:code" Full $
  onWorkspace "8:coopnet" Full $
  onWorkspace "9:misc" Grid $
  defaultLayouts
  where
    imLayout = withIM (1%6) (Title "Liste de contacts") Grid

myManageHook = composeAll
   [ className =? "Pidgin"         --> doShift "3:im"
   , className =? "firefox"        --> doShift "2:web"
   , className =? "jetbrains-idea" --> doShift "4:code"
   , className =? "MultimediaConference" --> doShift "8:coopnet"
   ]
