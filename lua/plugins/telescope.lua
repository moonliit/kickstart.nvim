return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',

      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      'nvim-telescope/telescope-ui-select.nvim',

      -- Icons (only if nerd font is present, Kickstart-style)
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

      -- Extra extensions
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-media-files.nvim',
    },

    config = function()
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        defaults = {
          file_ignore_patterns = {
            'node_modules',
            '^.git/*',
            '.venv/',
            '__pycache__/',
            'target',
          },
          hidden = true,
          no_ignore = true,
        },
        extensions = {
          ['ui-select'] = require('telescope.themes').get_dropdown(),
        },
      }

      -- Load extensions safely
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'frecency')
      pcall(telescope.load_extension, 'file_browser')
      pcall(telescope.load_extension, 'media_files')

      ------------------------------------------------------------------
      -- Keymaps
      ------------------------------------------------------------------

      local find_files = '<cmd>Telescope find_files hidden=true no_ignore=true<CR>'
      local notifs = '<cmd>Telescope notify<CR>'

      vim.keymap.set('n', '<CR>', find_files, { desc = 'Telescope: Find files' })
      vim.keymap.set('n', '<C-o>', builtin.live_grep, { desc = 'Telescope: Live grep' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope: Git files' })
      vim.keymap.set('n', '<C-l>', notifs, { desc = 'Telescope: Git files' })

      -- Kickstart defaults
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find buffers' })

      -- Advanced examples you had
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzy search current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      ------------------------------------------------------------------
      -- Highlight overrides
      ------------------------------------------------------------------
      local hl = vim.api.nvim_set_hl
      hl(0, 'TelescopeBorder', { fg = '#7aa2f7', bg = 'NONE' })
      hl(0, 'TelescopePromptBorder', { fg = '#7aa2f7', bg = 'NONE' })
      hl(0, 'TelescopeResultsBorder', { fg = '#7aa2f7', bg = 'NONE' })
      hl(0, 'TelescopePreviewBorder', { fg = '#7aa2f7', bg = 'NONE' })

      hl(0, 'TelescopePromptTitle', { fg = '#1abc9c', bg = 'NONE' })
      hl(0, 'TelescopeResultsTitle', { fg = '#b390d6', bg = 'NONE' })
      hl(0, 'TelescopePreviewTitle', { fg = '#f7768e', bg = 'NONE' })
    end,
  },
}
