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

        vim.keymap.set('n', '<leader>h', '<cmd>Lspsaga hover_doc<CR>')
        vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
      end,
    },
  },
}
