return {
  {
    'ray-x/lsp_signature.nvim',
    event = 'LspAttach',
    config = function()
      -------------------------------------------------
      -- Setup plugin
      -------------------------------------------------
      require('lsp_signature').setup {
        hint_enable = false,
        floating_window = true,
        border = 'rounded',

        doc_lines = 10,
        max_height = 12,
        max_width = 80,
        wrap = true,

        handler_opts = {
          border = 'rounded',
        },

        extra_trigger_chars = {},
        hi_parameter = 'Search', -- highlight active parameter
      }

      -------------------------------------------------
      -- Transparency to match cmp floats
      -------------------------------------------------
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })

      -------------------------------------------------
      -- Keybind to toggle signature window
      -------------------------------------------------
      vim.keymap.set('n', '<leader>d', function()
        require('lsp_signature').toggle_float_win()
      end, { desc = 'Toggle Signature Help' })
    end,
  },
}
