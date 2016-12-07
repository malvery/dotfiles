import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Layout.IndependentScreens
import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops


conf = gnomeConfig {
        workspaces = myWorkspaces
        , modMask = mod4Mask
        , terminal = "urxvt"
				, normalBorderColor = "#383838"
				, focusedBorderColor = "#7eb53c"
	      , manageHook = myManageHook <+> manageDocks
        , layoutHook  = smartBorders (layoutHook gnomeConfig)
				, startupHook = setWMName "LG3D" <+> ewmhDesktopsStartup
				, handleEventHook = fullscreenEventHook <+> ewmhDesktopsEventHook

	} `additionalKeys` myKeys `removeKeys` [(mod4Mask  .|. shiftMask, xK_p)]
  {-} `additionalKeys` myKeys -}

myWorkspaces = withScreens 2 ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myKeys =
         [
         -- workspaces are distinct by screen
          ((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
               | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
               , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]
         ++
         [
         -- swap screen order
         ((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f)) | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,1,2], (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]
         ++
         [
           ((mod4Mask, xK_r), spawn "gmrun")

         , ((mod4Mask, xK_Escape), toggleWS)
				 
				 , ((mod4Mask, xK_w), nextScreen)
				 , ((mod4Mask, xK_e), prevScreen)
	 
				 {-, ((mod4Mask, xK_s), raise (className =? "Skype"))-}
				 , ((mod4Mask, xK_s), raise (className =? "skypeforlinux"))
         , ((mod4Mask, xK_g), raise (className =? "Thunderbird"))

				 , ((mod4Mask  .|. shiftMask, xK_q), spawn "~/bin/xmonad-restart.sh")

				 {-, ((mod4Mask  .|. shiftMask, xK_p), spawn "thunar")-}

				 {-, ((mod4Mask  .|. shiftMask, xK_F12), spawn "/usr/local/bin/xscreensaver-command"-}
				 {-, ((mod4Mask  .|. shiftMask, xK_F12), spawn "slimlock")-}
				 {-, ((mod4Mask  .|. shiftMask, xK_Delete), spawn "xfce4-session-logout")-}
         ]


myManageHook = composeAll 
	[ 
	  resource =? "realplay.bin"    --> doFloat

		, isFullscreen --> doFullFloat

    , className =? "Wrapper-1.0"     --> doFloat
		, className =? "VirtualBox"      --> doFloat
                
    , className =? "Firefox"     --> doShift "0_2"
    , className =? "Chromium"    --> doShift "0_2"
		, className =? "Google-chrome"    --> doShift "0_3"
		, className =? "Thunderbird" --> doShift "0_9"

    , className =? "tmux-main"   --> doShift "1_1"
    , className =? "Clementine"  --> doShift "1_8"
		, className =? "Skype"       --> doShift "1_9"
		, className =? "skypeforlinux"  --> doShift "1_9"

  ]

main = xmonad conf
