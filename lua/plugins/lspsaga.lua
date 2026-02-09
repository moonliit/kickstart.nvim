return {
  {
    {
      'glepnir/lspsaga.nvim',
      branch = 'main',
      event = 'LspAttach',
      dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        { 'nvim-treesitter/nvim-treesitter' },
      },
      config = function()
        require('lspsaga').setup {
          ui = {
            border = 'rounded',
            winblend = 0,
            title = true,
          },
          lightbulb = {
            enable = false,
          },
          hover = {
            max_height = 0.5,
            max_width = 0.5,
            auto_focus = false,
          },
        }

        vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', { desc = 'Show current line diagnostics' })
        vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = 'Jump to next diagnostic' })
        vim.keymap.set('n', '<leader>R', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = 'Jump to prev diagnostic' })

        vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', { desc = 'Go to hover help doc' })
        vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', { desc = 'Go to definition' })
      end,
    },
  },
}
