return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = false,
        },
        panel = { enabled = false },
      }
    end,
  },
  {
    'copilotlsp-nvim/copilot-lsp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot-lsp').setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'copilot' then
            vim.keymap.set('n', '<leader>ce', vim.lsp.buf.code_action, { buffer = args.buf })
          end
        end,
      })
    end,
  },
}
