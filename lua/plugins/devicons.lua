-- mini.icons: broader coverage (780 filetypes) than nvim-web-devicons, and
-- defaults to the Material Design Nerd Font glyph set (nf-md-*) instead of
-- Devicons (nf-dev-*) - closer to VSCode's Material Icon Theme out of the box.
-- mock_nvim_web_devicons() makes Neo-tree/bufferline/telescope (which still
-- call the nvim-web-devicons API) use mini.icons transparently, no native
-- Neo-tree support needed.
return {
  "echasnovski/mini.icons",
  lazy = false,
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()

    -- mini.icons uses 9 fixed highlight groups (not per-icon hex) for easy
    -- bulk recoloring; point them at VSCode's actual Material Icon Theme tones.
    local material_hl = {
      MiniIconsRed = "#f34f29",
      MiniIconsOrange = "#e37933",
      MiniIconsYellow = "#f4d03f",
      MiniIconsGreen = "#89e051",
      MiniIconsCyan = "#61dafb",
      MiniIconsAzure = "#458ee6",
      MiniIconsBlue = "#3178c6",
      MiniIconsPurple = "#844fba",
      MiniIconsGrey = "#9e9e9e",
    }
    local function apply_material_colors()
      for group, color in pairs(material_hl) do
        vim.api.nvim_set_hl(0, group, { fg = color })
      end
    end
    apply_material_colors()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_material_colors })
  end,
}
