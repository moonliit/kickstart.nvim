return {
  ---------------------------------------------------------------------------
  -- Copilot core (Lua version, replaces copilot.vim)
  ---------------------------------------------------------------------------
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = false,
          -- auto_trigger = true,
          -- keymap = {
          --   accept = false, -- disable accept
          --   next = false,
          --   prev = false,
          --   dismiss = false,
          -- },
        },
        panel = { enabled = false },
      }
    end,
  },

  ---------------------------------------------------------------------------
  -- Copilot → nvim-cmp bridge
  ---------------------------------------------------------------------------
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup {
        method = 'getCompletionsCycling', -- better UX
      }
    end,
  },

  ---------------------------------------------------------------------------
  -- Copilot as LSP (optional but powerful)
  ---------------------------------------------------------------------------
  {
    'copilotlsp-nvim/copilot-lsp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot-lsp').setup {
        -- optional config
      }

      -- Attach like a normal LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'copilot' then
            -- Example keymaps for Copilot LSP actions
            local map = vim.keymap.set
            local opts = { buffer = args.buf }

            map('n', '<leader>ce', vim.lsp.buf.code_action, opts) -- Copilot edits
          end
        end,
      })
    end,
  },
}
