return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      -- Snippet engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },

      -- LazyDev source for Lua
      'folke/lazydev.nvim',
    },

    --- @module "blink.cmp"
    --- @type blink.cmp.Config
    opts = {
      ------------------------------------------------------------------
      -- Keymaps
      ------------------------------------------------------------------
      keymap = {
        ['<Tab>'] = {
          'snippet_forward',
          'select_next',
          'fallback',
        },
        ['<S-Tab>'] = {
          'snippet_backward',
          'select_prev',
          'fallback',
        },
        ['<CR>'] = {
          'select_and_accept',
          'fallback',
        },

        -- Disable arrow keys
        ['<Up>'] = { 'fallback' },
        ['<Down>'] = { 'fallback' },
        ['<Left>'] = { 'fallback' },
        ['<Right>'] = { 'fallback' },
      },

      ------------------------------------------------------------------
      -- Appearance
      ------------------------------------------------------------------
      appearance = {
        nerd_font_variant = 'mono',
      },

      ------------------------------------------------------------------
      -- Completion behavior
      ------------------------------------------------------------------
      completion = {
        menu = {
          --auto_select = false,
        },
        list = {
          cycle = {
            from_bottom = true,
            from_top = true,
          },
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
      },

      ------------------------------------------------------------------
      -- Sources and scoring
      ------------------------------------------------------------------
      sources = {
        default = {
          'lsp',
          'snippets',
          'path',
          'buffer',
          'lazydev',
        },

        providers = {
          lsp = {
            score_offset = 200,
          },
          snippets = {
            score_offset = 100,
          },
          path = {
            score_offset = 50,
          },
          buffer = {
            score_offset = -100,
            min_keyword_length = 3,
          },
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      ------------------------------------------------------------------
      -- Snippets
      ------------------------------------------------------------------
      snippets = {
        preset = 'luasnip',
      },

      ------------------------------------------------------------------
      -- Fuzzy matching
      ------------------------------------------------------------------
      fuzzy = {
        implementation = 'lua',
      },

      ------------------------------------------------------------------
      -- Signature help
      ------------------------------------------------------------------
      signature = {
        enabled = true,
      },
    },
  },
}
