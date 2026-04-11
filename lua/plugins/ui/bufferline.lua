return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require 'utils.theme'
    local c = theme.palette()

    local selected = {
      bg = c.black,
      fg = c.white,
    }

    local other = {
      bg = c.darker_black,
      fg = c.grey_fg2,
    }

    require('bufferline').setup {
      options = {
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = true,
        show_close_icon = true,
        separator_style = 'thin',
        always_show_bufferline = true,
        enforce_regular_tabs = false,
        indicator = { style = 'underline' },
        offsets = {
          { filetype = 'neo-tree', highlight = 'Directory', padding = 1 },
        },
      },
      highlights = {
        background = { bg = other.bg, fg = other.fg },
        buffer_selected = { fg = selected.fg, bg = selected.bg, sp = selected.fg },
        tab_selected = { fg = selected.fg, bg = selected.bg },
        separator_selected = { fg = selected.fg, bg = selected.bg },
        fill = { bg = selected.bg },
        numbers_selected = { fg = selected.fg, bg = selected.bg },
        modified_selected = { fg = selected.fg, bg = selected.bg, sp = selected.fg, underline = true },
        close_button_selected = { fg = selected.fg, bg = selected.bg },
        indicator_selected = { fg = selected.fg, bg = selected.bg, sp = selected.fg },
      },
    }

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<A-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
    map('n', '<A-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })

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

    map('n', '<C-Tab>', function()
      vim.notify('TODO', vim.log.levels.WARN)
    end, vim.tbl_extend('force', opts, { desc = 'Toggle last two tabs' }))

    map('n', '<leader><Tab>', function()
      vim.notify('TODO', vim.log.levels.WARN)
    end, vim.tbl_extend('force', opts, { desc = 'Toggle last two tabs (fallback)' }))

    map('n', '<C-w>', function()
      Snacks.bufdelete()
    end, { noremap = true, silent = true, nowait = true, desc = 'Close current buffer' })

    map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save current buffer' })

    local bufferline = require 'bufferline'
    for i = 1, 9 do
      map('n', '<A-' .. i .. '>', function()
        bufferline.go_to(i, true)
      end, { noremap = true, silent = true, desc = 'Goto buffer ' .. i })
    end
  end,
}
