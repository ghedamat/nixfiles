{
home.file.".config/i3/config".text = ''
# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout somewhen, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below. ISO 10646 = Unicode
#font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, if you need a lot of unicode glyphs or
# right-to-left text rendering, you should instead use pango for rendering and
# chose a FreeType font, such as:
# font pango:DejaVu Sans Mono 10

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
set $term alacritty
bindsym $mod+x exec $term

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
#bindsym $mod+p exec dmenu_run
bindsym $mod+p exec rofi -show run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+semicolon split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1: main
bindsym $mod+2 workspace 2: web
bindsym $mod+3 workspace 3: chat
bindsym $mod+4 workspace 4: misc
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1: main
bindsym $mod+Shift+2 move container to workspace 2: web
bindsym $mod+Shift+3 move container to workspace 3: chat
bindsym $mod+Shift+4 move container to workspace 4: misc
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

workspace X1 output DP-2
workspace X2 output HDMI-0
workspace X3 output HDMI-1
bindsym $mod+Shift+f exec focus.sh

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym h resize shrink width 10 px or 10 ppt
        bindsym j resize grow height 10 px or 10 ppt
        bindsym k resize shrink height 10 px or 10 ppt
        bindsym l resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)


# default settings layout
workspace_layout tabbed
#font pango:Sans 8
font -*-terminus-*-*-normal-*-12-*-*-*-*-*-*-*
#new_window pixel 1

for_window [class="Pidgin"] layout splith
for_window [class="Skype"] split vertical
for_window [class="Pidgin"] split vertical

#for_window [class="Telegram"] split vertical
#for_window [class="Slack"] split vertical

assign [class="Firefox"] 2: web
assign [title="Google Chrome"] 1: main
assign [class="Skype"] 3: chat
assign [class="Telegram"] 3: chat
assign [title="Slack"] 3: chat
assign [title="Discord"] 5: discord

bindsym $mod+n workspace next
bindsym $mod+b workspace prev
bindsym $mod+d move container to workspace |
bindsym $mod+m mark focused
bindsym $mod+t [con_mark="focused"] focus

# Make the currently focused window a scratchpad
bindsym $mod+Shift+comma move scratchpad
#
# # Show the first scratchpad window
bindsym $mod+comma scratchpad show

bindsym $mod+Control+n focus output up
bindsym $mod+Control+b focus output down
bindsym $mod+Shift+n move workspace to output up
bindsym $mod+Shift+b move workspace to output down

bindsym XF86AudioMute exec amixer sset Master toggle
bindsym XF86AudioLowerVolume exec amixer sset Master 5%-
bindsym XF86AudioRaiseVolume exec amixer sset Master 5%+
bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness

#exec btsync
#exec polybar i3wmthemer_bar
exec --no-startup-id nitrogen --restore #; sleep 1; compton -b

exec $term
exec google-chrome-beta
exec firefox
exec telegram-desktop
exec slack

client.background #1E272B
client.focused #EAD49B #EAD49B #1E272B #9D6A47 #9D6A47
client.unfocused #EAD49B #1E272B #EAD49B #78824B #78824B
client.focused_inactive #EAD49B #1E272B #EAD49B #78824B #78824B
client.urgent #EAD49B #1E272B #EAD49B #78824B #78824B
client.placeholder #EAD49B #1E272B #EAD49B #78824B #78824B

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
      tray_output primary
      font pango:DejaVu Sans Mono, FontAwesome 12
      position top
      status_command i3status-rs ~/.config/i3/status.toml
      colors {
            separator #666666
            background #222222
            statusline #dddddd
            focused_workspace #0088CC #0088CC #ffffff
            active_workspace #333333 #333333 #ffffff
            inactive_workspace #333333 #333333 #888888
            urgent_workspace #2f343a #900000 #ffffff
      }
}
'';
}
