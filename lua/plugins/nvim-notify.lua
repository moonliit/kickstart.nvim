return {
  {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()
      local notify = require 'notify'

      notify.setup {
        stages = 'slide',
        timeout = 3000,
        render = 'default',
        background_colour = '#000000',
        max_width = 50,
        minimum_width = 50,
        merge_duplicates = true,
        fps = 60,
      }

      vim.notify = notify
    end,
  },
  {
    'mrded/nvim-lsp-notify',
    dependencies = {
      'rcarriga/nvim-notify',
      'neovim/nvim-lspconfig',
    },
    lazy = false,
    config = function()
      require('lsp-notify').setup {}
    end,
  },
}
