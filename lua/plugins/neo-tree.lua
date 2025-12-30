-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,

  keys = {
    --{ '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<C-n>', '<cmd>Neotree toggle<cr>', desc = 'Toggle NeoTree', silent = true },
  },

  opts = {
    sources = {
      'filesystem',
      'buffers',
      'git_status',
    },

    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        visible = true,
      },

      follow_current_file = {
        enabled = false,
      },

      window = {
        mappings = {
          ['\\'] = 'close_window',

          ['F'] = 'fuzzy_finder',
          ['.'] = 'set_root',
          [','] = 'navigate_up',
        },
      },
    },

    source_selector = {
      winbar = false,
      sources = {
        { source = 'filesystem', display_name = '󰉓 Files' },
        { source = 'buffers', display_name = '󰈙 Buffers' },
        { source = 'git_status', display_name = '󰊢 Git' },
      },
    },

    hide_root_node = true,
    close_if_last_window = true,
  },

  config = function(_, opts)
    require('neo-tree').setup(opts)

    -- Highlight overrides
    vim.api.nvim_set_hl(0, 'NeoTreeNormal', {
      fg = '#cdd6f4',
      bg = '#15151a',
    })

    vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', {
      fg = '#cdd6f4',
      bg = '#15151a',
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = function()
        vim.opt_local.cursorline = true
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.wrap = false
      end,
    })

    vim.api.nvim_set_hl(0, 'NeoTreeCursorLine', {
      bg = '#2a2f4a',
    })
  end,
}
