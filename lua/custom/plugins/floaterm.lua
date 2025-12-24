return {
  {
    'voldikss/vim-floaterm',
    cmd = {
      'FloatermToggle',
      'FloatermNew',
      'FloatermNext',
      'FloatermPrev',
      'FloatermKill',
    },
    keys = {
      { '<C-/>', '<cmd>FloatermToggle<CR>', desc = 'Toggle Floaterm' },
      -- Uncomment if you want these back
      -- { "<leader>t", "<cmd>FloatermNew<CR>",  desc = "New Floaterm" },
      -- { "<leader>l", "<cmd>FloatermNext<CR>", desc = "Next Floaterm" },
      -- { "<leader>h", "<cmd>FloatermPrev<CR>", desc = "Prev Floaterm" },
      -- { "<leader>x", "<cmd>FloatermKill<CR>", desc = "Kill Floaterm" },
    },

    init = function()
      -- Core Floaterm settings (from your Nix config)
      vim.g.floaterm_width = 0.75
      vim.g.floaterm_height = 0.75
      vim.g.floaterm_position = 'center'
      vim.g.floaterm_wintype = 'float'
      vim.g.floaterm_autoinsert = true
      vim.g.floaterm_autoclose = 1

      vim.g.floaterm_borderchars = '─│─│┌┐┘└'
      vim.g.floaterm_wintitle = true
      vim.g.floaterm_title = 'Floaterm ($1/$2)'
      vim.g.floaterm_titleposition = 'center'

      -- Floaterm internal keymaps
      vim.g.floaterm_keymap_toggle = '<C-/>'
    end,

    config = function()
      -- Highlight overrides (Lazy-compatible replacement for highlightOverride)

      -- inactive statusline
      vim.api.nvim_set_hl(0, 'StatusLineNC', {
        fg = '#c0caf5',
        bg = '#1f2335',
      })

      -- active statusline
      vim.api.nvim_set_hl(0, 'StatusLine', {
        fg = '#ffffff',
        bg = '#222235',
      })

      -- vertical split
      vim.api.nvim_set_hl(0, 'VertSplit', {
        fg = '#4b5266',
        bg = '#1f2335',
      })

      -- Neovim 0.11+ separator
      vim.api.nvim_set_hl(0, 'WinSeparator', {
        fg = '#9a59cf',
        bg = 'NONE',
      })
    end,
  },
}
