return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify', -- optional but strongly recommended
    },
    config = function()
      require('noice').setup {
        ------------------------------------------------------------------
        -- LSP integration
        ------------------------------------------------------------------
        lsp = {
          progress = { enabled = true },
          hover = { enabled = true },
          signature = { enabled = true },
        },

        ------------------------------------------------------------------
        -- Presets
        -- command_palette intentionally disabled (matches your comment)
        ------------------------------------------------------------------
        presets = {
          command_palette = false,
          bottom_search = false,
          long_message_to_split = true,
        },

        ------------------------------------------------------------------
        -- Cmdline configuration
        ------------------------------------------------------------------
        cmdline = {
          view = 'cmdline_popup',
        },

        ------------------------------------------------------------------
        -- View overrides
        ------------------------------------------------------------------
        views = {
          -- Popup cmdline (anchored near bottom)
          cmdline_popup = {
            position = {
              row = '90%',
              col = '50%',
            },
            size = {
              width = 70,
              height = 'auto',
            },
            border = {
              style = 'rounded',
            },
          },

          -- Completion popup positioned under cmdline popup
          popupmenu = {
            relative = 'editor',
            position = {
              row = '120%',
              col = '50%',
            },
            size = {
              width = 70,
              height = 10,
            },
            border = {
              style = 'rounded',
              padding = { 0, 1 },
            },
          },
        },
      }
    end,
  },
}
