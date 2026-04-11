return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        ------------------------------------------------------------------
        -- Cmdline & search ONLY
        ------------------------------------------------------------------
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
          format = {
            search_down = {
              icon = ' ↓',
            },
            search_up = {
              icon = ' ↑',
            },
          },
        },

        messages = {
          enabled = true,
          view = 'notify',
        },

        notify = {
          enabled = false,
          view = 'notify',
        },

        lsp = {
          progress = { enabled = false },
          hover = { enabled = false },
          signature = { enabled = false },
          message = { enabled = false },
        },

        ------------------------------------------------------------------
        -- Views
        ------------------------------------------------------------------
        views = {
          notify = {
            backend = 'notify',
            merge = true,
          },
        },

        ------------------------------------------------------------------
        -- Presets
        ------------------------------------------------------------------
        presets = {
          command_palette = false,
          bottom_search = false,
        },
      }
    end,
  },
}
