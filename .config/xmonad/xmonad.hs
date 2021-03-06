import           System.IO
import 			 System.Exit (exitSuccess)
import           XMonad

-- Actions
import           XMonad.Actions.CycleWS
import           XMonad.Actions.SpawnOn
import           XMonad.Actions.UpdatePointer
import           XMonad.Actions.WindowGo
import 			 XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import 			 XMonad.Actions.Promote
import 			 XMonad.Actions.WithAll (sinkAll)
import 			 XMonad.Actions.MouseResize

-- Config
import           XMonad.Config.Azerty

-- Hooks
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.UrgencyHook

-- Layouts
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spiral
import           XMonad.Layout.Tabbed
import 			 XMonad.Layout.SimplestFloat
import 			 XMonad.Layout.ResizableTile
import 			 XMonad.Layout.GridVariants (Grid(Grid))

-- Layouts modifiers
import 			 XMonad.Layout.LayoutModifier
import 			 XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import 			 XMonad.Layout.Magnifier
import 			 XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import 			 XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import 			 XMonad.Layout.Renamed
import 			 XMonad.Layout.ShowWName
import 			 XMonad.Layout.Simplest
import 			 XMonad.Layout.Spacing
import 			 XMonad.Layout.SubLayouts
import 			 XMonad.Layout.WindowNavigation
import 			 XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import 			 qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import 			 qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- Utils
import           XMonad.Util.EZConfig
import           XMonad.Util.Paste
import           XMonad.Util.Run              (spawnPipe)
import           XMonad.Util.Scratchpad
import 			 XMonad.Util.SpawnOnce
import 			 XMonad.Util.Cursor

--import XMonad.Util.NamedScratchpad
import qualified XMonad.Layout.Fullscreen     as Fullscreen
import qualified XMonad.StackSet              as W


-- My stuff
myBrowser = "brave"
myTerminal = "alacritty"

audiocontrol :: String -> String
audiocontrol x
	| x == "lower"  = "pamixer --allow-boost -d 5"
	| x == "raise"  = "pamixer --allow-boost -i 5"
    | x == "toggle" = "pamixer -t"
    | otherwise     = ""
----------------------

myWorkspacesName = [":\xf269 ", ":\xf0c3 ", ":\xf07c ", ":\xf109 ", ":\xf03e ", ":\xf1cb ", ":\xf1fb ", ":\xf233 ", ":\xf2c6 "]

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ myWorkspacesName
  where
         clickable l = [ "<action=xdotool key Super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                             (i,ws) <- zip [1..9] l,
                            let n = i ]

-- Send applications to their dedicated Workspace
myManageHook = (composeAll
                [
                  manageSpawn,
                  className =? "Xmessage"    --> doFloat,
				  className =? "discord"     --> doShift (myWorkspaces !! 8),
				  className =? "Steam"       --> doShift (myWorkspaces !! 7),
                  isDialog                   --> doCenterFloat,
                  --className =? "zenity"      --> doFloat,
                  isFullscreen               --> (doF W.focusDown <+> doFullFloat)
                ]) <+> manageScratchPad

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.5     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 0       -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace workspace program = do
                                      spawn program
                                      windows $ W.greedyView workspace

--pads = [ NS "term" "urxvt -name scratchpad -e sh -l -c 'tmux has -t quake && tmux attach -t quake || tmux new -s quake'" (resource =? "scratchpad" <&&> className =? "URxvt") (customFloating $ W.RationalRect 0.2 0.6 0.6 0.4) ]

------------------------------------------------------------------------------
-- Layout stuff
myFont :: String
myFont = "xft:Mononoki Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myBorderWidth = 2

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
myWindowSpacing = 1

tall     = renamed [Replace "tall"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing myWindowSpacing
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing myWindowSpacing
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 0
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' myWindowSpacing
           $ spiral (6/7)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme

-- The layout hook
myLayout = mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| grid
                                 ||| spirals

-- myLayout = (
--     Tall 1 (3/100) (1/2) |||
--     Mirror (Tall 1 (3/100) (1/2)) |||
--     Full |||
-- 	floats |||
--     spiral (6/7)) |||
--     Fullscreen.fullscreenFull Full

------------------------------------------------------------------------------

myStartupHook = do
	spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 22 &"
	spawnOnce "picom --experimental-backends --backend glx --xrender-sync-fence"
	setDefaultCursor xC_left_ptr


myFocusedBorderColor = "#7F7F7F"
myNormalBorderColor = "#3F3F3F"
monokaiGreen = "#A6E22E"
monokaiBlue = "#66D9EF"

myKeys scratchPad =
	[
	-- Xmonad session
	  ("M-S-r", spawn "killall xmobar; xmonad --recompile && xmonad --restart")
	, ("M-S-q", io exitSuccess)
	, ("M-x", spawn "slock")
	, ("M-b", sendMessage ToggleStruts)
    , ("M-<Backspace>", spawn "sysact xmonad")

	-- Utils
	, ("<Insert>", pasteSelection)
	, ("M-o", spawn "notify-send foo; sleep 1")
    , ("<Print>", spawn "maimauto full")
	, ("S-<Print>", spawn "maimauto fullcopy")
    , ("M-p", spawn "maimpick")
	, ("M-S-p", spawn "maimauto selectcopy")
	, ("M-C-p", spawn "dmenurecord")
	, ("M-<Print>", spawn "dmenurecord")
    , ("M-<Delete>", spawn "dmenurecord kill")

	-- Media
	, ("<XF86AudioRaiseVolume>", spawn (audiocontrol "raise"))
	, ("<XF86AudioLowerVolume>", spawn (audiocontrol "lower"))
	, ("<XF86AudioMute>",        spawn (audiocontrol "toggle"))

	--, ("M-z", namedScratchpadAction pads "term")
	, ("M-z", scratchPad)
	, ("M-u", focusUrgent)
	, ("C-M-<Left>", prevWS )
	, ("C-M-<Right>", nextWS )

    -- Launch
	, ("M-d", 		   spawn "dmenu_run")
	, ("M-w", 		   spawn myBrowser)
	, ("M-<Return>",   spawn myTerminal)
	, ("M-S-<Return>", spawn ("samedir-"++myTerminal))
	, ("M-S-e",        spawn "thunar")
	, ("M-e",          spawn (myTerminal ++ " -e ranger"))

	-- Layouts
	, ("M-<Tab>",       toggleWS)           -- Switch to next layout
	, ("M-C-M1-<Up>",   sendMessage Arrange)
	, ("M-C-M1-<Down>", sendMessage DeArrange)
	, ("M-<Space>",     sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
	, ("M-S-<Space>",   sendMessage ToggleStruts)     -- Toggles struts
	, ("M-S-n", 		sendMessage $ MT.Toggle NOBORDERS)  -- Toggles noborder
    , ("M-C-j",         sendMessage NextLayout)           -- Switch to next layout
	, ("M-C-k",         sendMessage FirstLayout)

    -- Increase/decrease spacing (gaps)
	, ("M-C-s j", decWindowSpacing 4)           -- Decrease window spacing
	, ("M-C-s k", incWindowSpacing 4)           -- Increase window spacing
	, ("M-S-d",   decScreenSpacing 4)           -- Decrease screen spacing
	, ("M-S-i",   incScreenSpacing 4)           -- Increase screen spacing

	-- Floating windows
	, ("M-f", 		 	sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
	, ("M-t", 			withFocused $ windows . W.sink)  -- Push floating window back to tile
	, ("M-S-t", 		sinkAll)                         -- Push ALL floating windows to tile

 	-- Windows navigation
	, ("M-q", kill)
	, ("M-m", windows W.focusMaster)  -- Move focus to the master window
	, ("M-j", windows W.focusDown)    -- Move focus to the next window
	, ("M-k", windows W.focusUp)      -- Move focus to the prev window
	, ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
	, ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
	, ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
	, ("M-C-<Return>", promote)
	, ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
	, ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

	-- Master stack
	, ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase number of clients in master pane
    , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease number of clients in master pane
	]

main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"

    xmonad $ withUrgencyHook NoUrgencyHook $ ewmh $ docks azertyConfig {
    terminal            = myTerminal,
    workspaces          = myWorkspaces,
    normalBorderColor   = myNormalBorderColor,
    focusedBorderColor  = myFocusedBorderColor,
    manageHook 			= ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks, -- manageHook          = myManageHook,
    startupHook         = myStartupHook,
    layoutHook          = avoidStruts $ myLayout,
    logHook             = dynamicLogWithPP $ xmobarPP
      { ppOutput          = hPutStrLn xmproc
      , ppTitle           = xmobarColor monokaiBlue "" . shorten 100
      , ppHiddenNoWindows = xmobarColor "grey" "" . wrap "" "" . noScratchPad
      , ppUrgent          = xmobarColor "black" "#FD971F" . wrap " "  " "
      , ppHidden          = xmobarColor "grey" "" . wrap "+" "" -- noScratchPad
	  , ppCurrent         = xmobarColor "black" monokaiBlue . wrap "[" "]"
      , ppVisible         = xmobarColor monokaiBlue ""
      , ppLayout          = xmobarColor "#999" "" . wrap "|" "|"
      , ppSep             = " ?? "
      },
    modMask = mod4Mask, -- Win key as modkey
    handleEventHook = fullscreenEventHook <+> docksEventHook
} `additionalKeysP` myKeys scratchPad
	where
	  scratchPad = scratchpadSpawnActionTerminal myTerminal
	  noScratchPad ws = if ws == "NSP" then "" else ws
