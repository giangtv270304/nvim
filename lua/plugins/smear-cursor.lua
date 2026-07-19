return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- kiểu Gruvbox: để cursor tự lấy màu highlight hiện tại thay vì set cứng
    cursor_color = nil,
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,

    -- Trước đây giảm các số này để né giật do WezTerm bật blur nền + gõ
    -- nhanh cộng dồn chi phí render. Blur đã tắt hẳn trong wezterm.lua
    -- (macos_window_background_blur = 0) nên đưa lại gần mặc định của
    -- plugin để animation dài/mượt/rõ hơn. Nếu sau này thấy giật khi gõ
    -- nhanh trở lại, hạ dần các số này xuống (time_interval tăng, các số
    -- còn lại giảm).
    time_interval = 17, -- mặc định: 60fps
    max_length = 20, -- mặc định 25 - vệt dài, dễ thấy hơn nhưng vẫn nhẹ hơn max
    stiffness = 0.6, -- mặc định: vệt "đuổi" đích chậm hơn -> animation rõ hơn
    trailing_stiffness = 0.45, -- mặc định
  },
}
