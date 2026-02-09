return {
  {
    'williamboman/mason.nvim',
    lazy = false, -- IMPORTANT: mason should load immediately
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-lspconfig').setup {
        automatic_installation = false, -- let tool-installer handle it
      }
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- LSPs
          'lua-language-server',
          'pyright',
          'ruff-lsp',
          'clangd',
          'gopls',
          'typescript-language-server',

          -- Formatters / linters
          'stylua',
          'ruff',

          -- Optional
          'bash-language-server',
          'json-lsp',
        },

        auto_update = false,
        run_on_start = true,
        start_delay = 3000, -- ms
        debounce_hours = 24,
      }
    end,
  },
}
