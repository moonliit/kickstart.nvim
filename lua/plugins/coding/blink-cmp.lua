return {
  {
    'saghen/blink.cmp',
    build = 'cargo +nightly build --release',
    version = '1.*',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'onsails/lspkind.nvim',
      'folke/lazydev.nvim',
    },
    config = function()
      local theme = require 'utils.theme'
      local luasnip = require 'luasnip'

      vim.api.nvim_set_hl(0, 'BlinkGhostText', { link = theme.link_target('ThemeCmpGhostText', 'Comment') })
      vim.api.nvim_set_hl(0, 'FloatBorder', { link = theme.link_target('ThemeFloatBorder', 'WinSeparator') })

      require('blink.cmp').setup {
        fuzzy = { implementation = 'rust' },
        appearance = { nerd_font_variant = 'normal' },
        completion = {
          menu = {
            border = 'rounded',
            max_height = 20,
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel',
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            treesitter_highlighting = true,
            window = {
              border = 'rounded',
              max_width = 90,
              max_height = 30,
              winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
            },
          },
          ghost_text = { enabled = true },
        },
        snippets = {
          expand = function(snippet)
            luasnip.lsp_expand(snippet)
          end,
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        keymap = {
          preset = 'default',
          ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
          ['<CR>'] = { 'accept', 'fallback' },
          ['<Esc>'] = {
            function(cmp)
              cmp.hide()
              vim.cmd 'stopinsert'
            end,
          },
          ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
          ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
        },
      }
    end,
  },
}
