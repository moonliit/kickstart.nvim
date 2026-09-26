return {
  -- manages rust lsp and other cool tools
  {
    'mrcjkb/rustaceanvim',
    branch = 'main',
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                buildScripts = { enable = true },
              },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },
}
