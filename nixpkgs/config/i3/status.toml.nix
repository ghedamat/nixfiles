{
  home.file.".config/i3/status.toml".text = ''
    theme = "solarized-dark"

    [icons]
    name = "awesome"
    #name = "material"

    #[[block]]
    #block = "focused_window"

    #[[block]]
    #block = "net"
    #device = "wlp59s0"
    #ssid = true
    #ip = true
    #interval = 30
    #bitrate = true
    #speed_up = false
    #speed_down = false

    [[block]]
    block = "disk_space"
    path = "/"
    alias = "/"
    info_type = "available"
    unit = "GB"
    interval = 120
    warning = 20.0
    alert = 10.0

    [[block]]
    block = "memory"
    display_type = "memory"
    format_mem = "{Mup}%"
    format_swap = "{SUp}%"
    #format_mem = "{Mum}MB/{MTm}MB({Mup}%)"
    #format_swap = "{SUm}MB/{STm}MB({SUp}%)"
    interval = 5
    clickable = true
    warning_mem = 80
    warning_swap = 80
    critical_mem = 95
    critical_swap = 95

    [[block]]
    block = "cpu"
    interval = 2
    frequency = true

    #[[block]]
    #block = "load"
    #interval = 5
    #format = "{1m}"

    [[block]]
    block = "temperature"
    collapsed = false
    interval = 20
    format = "{min}~{max}°"

    [[block]]
    block = "battery"
    interval = 10
    show = "both"

    [[block]]
    block = "backlight"

    [[block]]
    block = "toggle"
    command_state = "systemctl --user -q is-active redshift && echo on"
    command_on = "systemctl --user start redshift"
    command_off = "systemctl --user stop redshift"
    #icon_on = "backlight_empty"
    #icon_off = "backlight_full"
    text = "R"
    interval = 60

    [[block]]
    block = "sound"

    [[block]]
    block = "pomodoro"
    length = 25
    message = "Take a break!"
    use_nag = true

    [[block]]
    block = "time"
    interval = 10
    format = "%a %Y-%m-%d %l:%M%p"
  '';
}
