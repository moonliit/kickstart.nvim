return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },

    config = function()
      require('mason').setup()
      require('mason-null-ls').setup {
        ensure_installed = {
          'prettier',
          'stylua',
        },
        automatic_installation = true,
        handlers = {},
      }

      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier.with {
            filetypes = {
              'javascript',
              'javascriptreact',
              'typescript',
              'typescriptreact',
              'json',
              'jsonc',
              'yaml',
              'markdown',
              'css',
              'scss',
              'html',
            },
          },
        },
      }
    end,
  },
}
