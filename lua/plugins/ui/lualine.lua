return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local c = require('utils.theme').palette()

      local fg = c.black
      local normal = c.yellow
      local insert = c.green
      local visual = c.nord_blue
      local command = c.blue
      local terminal = c.purple
      local replace = c.red
      local inactive = c.grey

      local function get_options(color)
        return {
          a = { bg = color, fg = fg, gui = 'bold' },
          b = { bg = c.black2, fg = color },
          c = { bg = c.black, fg = color },
        }
      end

      require('lualine').setup {
        options = {
          theme = {
            normal = get_options(normal),
            insert = get_options(insert),
            visual = get_options(visual),
            command = get_options(command),
            terminal = get_options(terminal),
            replace = get_options(replace),
            inactive = get_options(inactive),
          },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { 'diff' },
          lualine_x = { 'diagnostics', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
