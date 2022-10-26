import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.Dwindle
import XMonad.Layout.Spacing
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import System.IO

-- My Variables --
myModKey = mod4Mask
myTerminal = "alacritty"
myBrowser = "firefox"

 -- Toggle Struts Key --
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myKeys = [ ((myModKey, xK_p), spawn "rofi -show run")
         , ((0, xK_Print), spawn "shotgun")
         , ((myModKey, xK_d), spawn "discord")
         , ((myModKey, xK_b), sendMessage ToggleStruts)
         , ((myModKey, xK_e), spawn "emacsclient -c -a 'emacs'")
         , ((myModKey, xK_f), spawn myBrowser)
         , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 2%-")
         , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 2%+") 
         , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
         , ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
         , ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%") ]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "eww open bar"
  spawnOnce "feh --bg-fill ~/Images/background"
  spawnOnce "picom --experimental-backends -b"
  setWMName "LG3D"

-- Window Spacing --
mySpacing = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True

 -- My Layouts --
myLayout = avoidStruts $ mySpacing $ Dwindle R  CCW 1 1 ||| Mirror tiled ||| Full
            where tiled = Tall 1 0.03 0.5

main = do
  xmonad $ docks $ ewmh $ def
              { manageHook = manageDocks <+> manageHook def
              , layoutHook = myLayout
              , startupHook = myStartupHook
              , modMask = myModKey
              , borderWidth = 0
              , terminal = myTerminal 
              }`additionalKeys` myKeys
