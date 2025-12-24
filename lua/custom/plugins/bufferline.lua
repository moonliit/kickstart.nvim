return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    ---------------------------------------------------------------------------
    -- Color definitions (ported 1:1)
    ---------------------------------------------------------------------------
    local selected = {
      bg = '#1e1e1e',
      fg = '#ffffff',
    }

    local other = {
      bg = '#0f1014',
      fg = '#9b9ea4',
    }

    ---------------------------------------------------------------------------
    -- Bufferline setup
    ---------------------------------------------------------------------------
    require('bufferline').setup {
      options = {
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',

        show_buffer_close_icons = true,
        show_close_icon = true,

        separator_style = 'thin',
        always_show_bufferline = true,
        enforce_regular_tabs = false,

        indicator = {
          style = 'underline',
        },

        offsets = {
          {
            filetype = 'neo-tree',
            highlight = 'Directory',
            padding = 1,
          },
        },
      },

      highlights = {
        background = {
          bg = other.bg,
          fg = other.fg,
        },

        buffer_selected = {
          fg = selected.fg,
          bg = selected.bg,
          sp = selected.fg,
        },

        tab_selected = {
          fg = selected.fg,
          bg = selected.bg,
        },

        separator_selected = {
          fg = selected.fg,
          bg = selected.bg,
        },

        fill = {
          bg = selected.bg,
        },

        numbers_selected = {
          fg = selected.fg,
          bg = selected.bg,
        },

        modified_selected = {
          fg = selected.fg,
          bg = selected.bg,
          sp = selected.fg,
          underline = true,
        },

        close_button_selected = {
          fg = selected.fg,
          bg = selected.bg,
        },

        indicator_selected = {
          fg = selected.fg,
          bg = selected.bg,
          sp = selected.fg,
        },
      },
    }

    ---------------------------------------------------------------------------
    -- Keymaps
    ---------------------------------------------------------------------------
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Alt-h / Alt-l: cycle buffers
    map('n', '<A-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
    map('n', '<A-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })

    -- Ctrl-t: new buffer (with floaterm guard)
    map('n', '<C-t>', function()
      if vim.api.nvim_get_mode().mode == 't' then
        return
      end

      local name = vim.api.nvim_buf_get_name(0)
      local ft = vim.bo.filetype

      if not (ft == 'floaterm' or name:match 'term://.*floaterm' or vim.b.floaterm_index) then
        vim.cmd 'enew'
      else
        vim.notify('In Floaterm — skipping :enew', vim.log.levels.DEBUG)
      end
    end, vim.tbl_extend('force', opts, { desc = 'New tab' }))

    -- Ctrl-Tab: toggle last two tabs (TODO placeholder)
    map('n', '<C-Tab>', function()
      vim.notify('TODO', vim.log.levels.WARN)
    end, vim.tbl_extend('force', opts, { desc = 'Toggle last two tabs' }))

    -- Leader-Tab fallback
    map('n', '<leader><Tab>', function()
      vim.notify('TODO', vim.log.levels.WARN)
    end, vim.tbl_extend('force', opts, { desc = 'Toggle last two tabs (fallback)' }))

    -- Ctrl-w: close buffer via Snacks
    map('n', '<C-w>', function()
      Snacks.bufdelete()
    end, { noremap = true, silent = true, nowait = true, desc = 'Close current buffer' })

    -- Ctrl-s: save buffer (normal / insert / visual)
    map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save current buffer' })

    ---------------------------------------------------------------------------
    -- Alt-1 .. Alt-9: jump to buffer index
    ---------------------------------------------------------------------------
    local bufferline = require 'bufferline'

    for i = 1, 9 do
      map('n', '<A-' .. i .. '>', function()
        bufferline.go_to(i, true)
      end, {
        noremap = true,
        silent = true,
        desc = 'Goto buffer ' .. i,
      })
    end
  end,
}
