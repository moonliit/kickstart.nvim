return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',

    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'onsails/lspkind.nvim',
      'folke/lazydev.nvim',
    },

    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      -------------------------------------------------
      -- Define a custom popup highlight group
      -------------------------------------------------
      vim.api.nvim_set_hl(0, 'PopMenu', { bg = 'none', blend = 0 })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', blend = 0 })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none', blend = 0 })
      vim.opt.winblend = 0
      vim.opt.pumblend = 0

      -------------------------------------------------
      -- Window style options
      -------------------------------------------------
      local win_opt = {
        border = 'rounded',
        col_offset = 0,
        side_padding = 1,
        max_height = 20,
        winhighlight = 'Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      }

      local doc_opt = {
        border = 'rounded',
        col_offset = 0,
        side_padding = 1,
        max_height = 15,
        winhighlight = 'Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
      }

      cmp.setup {
        -------------------------------------------------
        -- Snippets
        -------------------------------------------------
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -------------------------------------------------
        -- Windows
        -------------------------------------------------
        window = {
          completion = cmp.config.window.bordered(win_opt),
          documentation = cmp.config.window.bordered(doc_opt),
        },

        -------------------------------------------------
        -- Formatting (icons + kind)
        -------------------------------------------------
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '…',
          },
        },

        -------------------------------------------------
        -- Keymaps
        -------------------------------------------------
        mapping = cmp.mapping.preset.insert {
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<CR>'] = cmp.mapping.confirm { select = true },

          ['<Up>'] = cmp.mapping(function(fallback)
            fallback()
          end, { 'i' }),
          ['<Down>'] = cmp.mapping(function(fallback)
            fallback()
          end, { 'i' }),
          ['<Left>'] = cmp.mapping(function(fallback)
            fallback()
          end, { 'i' }),
          ['<Right>'] = cmp.mapping(function(fallback)
            fallback()
          end, { 'i' }),

          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
        },

        -------------------------------------------------
        -- Sources
        -------------------------------------------------
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'path', priority = 500 },
          { name = 'buffer', priority = 250, keyword_length = 3 },
        },
      }
    end,
  },
}
