{-# LANGUAGE LambdaCase #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask            = mod4Mask  -- Super key
    , terminal           = myTerminal
    , borderWidth        = 2
    , normalBorderColor  = "#282828"
    , focusedBorderColor = "#458588"
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , startupHook        = myStartupHook
    }
  `additionalKeysP`
    [ ("M-<Return>", spawn myTerminal)
    , ("M-p",        spawn "rofi -show drun")
    , ("M-S-p",      spawn "rofi -show run")
    , ("M-S-s",      unGrab *> spawn "scrot -s ~/Pictures/screenshot_%Y-%m-%d_%H-%M-%S.png")
    , ("M-S-l",      spawn "slock")
    , ("M-b",        spawn "firefox")
    , ("M-e",        spawn "pcmanfm")
    -- Audio controls
    , ("<XF86AudioMute>",        spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    -- Brightness controls
    , ("<XF86MonBrightnessUp>",   spawn "brightnessctl set +10%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
    ]

myTerminal :: String
myTerminal = "alacritty"

myLayout = avoidStruts $ smartBorders $ spacingWithEdge 4 $ tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "MPlayer"        --> doFloat
    , className =? "Pavucontrol"    --> doFloat
    , className =? "Nm-connection-editor" --> doFloat
    , isDialog                      --> doFloat
    , isFullscreen                  --> doFullFloat
    ]

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "picom"
    spawnOnce "dunst"
    spawnOnce "nm-applet"
    spawnOnce "pasystray"
    spawnOnce "nitrogen --restore"
    spawnOnce "xsetroot -cursor_name left_ptr"

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " | "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . white . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \case
                            (ws:l:_:wins:_) -> [ws, l, wins]
                            xs              -> xs
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
