hl.on("hyprland.start", function () 
    -- Export variables to systemd
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Restart portals so they catch the environment
    hl.exec_cmd("systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland xdg-desktop-portal")

    -- awww daemon
    -- hl.exec_cmd("awww-daemon")

    -- Load cursor
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")

    -- Start waybar
    -- hl.exec_cmd(HOME .. "/.config/waybar/launch.sh")

    -- Start polkit daemon
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Start noctalia-shell
    -- hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("noctalia")

    -- USB automount daemon
    hl.exec_cmd("udiskie &")
end)
