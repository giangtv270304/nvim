-- Recolor nvim-web-devicons to match VSCode's Material Icon Theme palette,
-- keeping each extension's own icon glyph (only the color changes).
local material_ext_colors = {
  js = "#f4d03f",
  mjs = "#f4d03f",
  cjs = "#f4d03f",
  jsx = "#61dafb",
  ts = "#3178c6",
  tsx = "#61dafb",
  json = "#cbcb41",
  jsonc = "#cbcb41",
  html = "#e37933",
  css = "#1572b6",
  scss = "#cf649a",
  md = "#dddddd",
  py = "#ffd43b",
  go = "#00add8",
  rs = "#dea584",
  lua = "#51a0cf",
  yml = "#f34b7d",
  yaml = "#f34b7d",
  tf = "#844fba",
  tfvars = "#844fba",
  sql = "#f29111",
  sh = "#89e051",
  bash = "#89e051",
  zsh = "#89e051",
  env = "#faf743",
}

local material_filename_colors = {
  ["dockerfile"] = "#458ee6",
  ["docker-compose.yml"] = "#458ee6",
  ["docker-compose.yaml"] = "#458ee6",
  [".gitignore"] = "#f34f29",
  ["package.json"] = "#cb3837",
}

return {
  "nvim-tree/nvim-web-devicons",
  opts = function(_, opts)
    local devicons = require("nvim-web-devicons")
    local default_ext_icons = devicons.get_icons_by_extension()
    local default_filename_icons = devicons.get_icons_by_filename()

    local override_by_extension = opts.override_by_extension or {}
    for ext, color in pairs(material_ext_colors) do
      local base = default_ext_icons[ext]
      if base then
        override_by_extension[ext] = vim.tbl_extend("force", base, { color = color })
      end
    end

    local override_by_filename = opts.override_by_filename or {}
    for filename, color in pairs(material_filename_colors) do
      local base = default_filename_icons[filename]
      if base then
        override_by_filename[filename] = vim.tbl_extend("force", base, { color = color })
      end
    end

    opts.color_icons = true
    opts.default = true
    opts.override_by_extension = override_by_extension
    opts.override_by_filename = override_by_filename
    return opts
  end,
}
