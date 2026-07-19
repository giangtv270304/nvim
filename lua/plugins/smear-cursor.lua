return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- Gruvbox-style: let the cursor pick up the current highlight color
    -- instead of a hardcoded one
    cursor_color = nil,
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,

    -- These used to be lowered to avoid stutter from WezTerm's background
    -- blur plus fast typing piling up render cost. Blur is now fully off
    -- (macos_window_background_blur = 0 in wezterm.lua), so these are back
    -- closer to the plugin defaults for a longer/smoother/more visible
    -- animation. If typing-fast stutter comes back, lower these again
    -- (raise time_interval, lower the rest).
    time_interval = 17, -- default: 60fps
    max_length = 20, -- default 25 — longer trail, more visible but still lighter than max
    stiffness = 0.6, -- default: trail "chases" the target more slowly -> clearer animation
    trailing_stiffness = 0.45, -- default
  },
}
