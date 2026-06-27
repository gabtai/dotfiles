hl.config({
    misc = {
        disable_hyprland_logo           = true, -- If true disables the random hyprland logo / anime girl background. :(
        vrr                             = 3,
        disable_splash_rendering        = true,
        mouse_move_enables_dpms         = false,
        key_press_enables_dpms          = true,
        layers_hog_keyboard_focus       = true,
        focus_on_activate               = false,
        mouse_move_focuses_monitor      = true,
    },

    render = {
        direct_scanout                  = 2,
        new_render_scheduling           = true,
        cm_enabled                      = false, -- Set to true only, if there any ICC profile or HDR used.
    },
})
