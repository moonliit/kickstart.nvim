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
      local lsp_references = '<cmd>Telescope lsp_references<CR>' -- todo:

      vim.keymap.set('n', '<CR>', find_files, { desc = 'Telescope: Find files' })
      vim.keymap.set('n', '<C-o>', builtin.live_grep, { desc = 'Telescope: Live grep' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope: Git files' })
      vim.keymap.set('n', '<C-l>', notifs, { desc = 'Telescope: Git files' })
      vim.keymap.set('n', '[', builtin.grep_string, { desc = 'Telescope: Grep string' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope: Find buffers' })

      -- Advanced examples you had
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          previewer = false,
        })
      end, { desc = '[/] Fuzzy search current buffer' })

      vim.keymap.set('n', '<leader>o', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search in [O]pen Files' })

      local theme = require 'utils.theme'
      local border = theme.link_target('ThemeFloatBorder', 'FloatBorder')
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { link = border })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { link = border })
      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { link = border })
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { link = border })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { link = theme.link_target('ThemeTelescopePromptTitle', 'Title') })
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { link = theme.link_target('ThemeTelescopeResultsTitle', 'Title') })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { link = theme.link_target('ThemeTelescopePreviewTitle', 'Title') })
    end,
  },
}
