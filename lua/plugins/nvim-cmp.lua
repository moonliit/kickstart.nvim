-- return {
--   {
--     'saghen/blink.cmp',
--     build = 'cargo build --release',
--     version = '1.*',
--     event = 'InsertEnter',
--
--     dependencies = {
--       'L3MON4D3/LuaSnip',
--       'onsails/lspkind.nvim',
--     },
--
--     config = function()
--       local luasnip = require 'luasnip'
--
--       -------------------------------------------------
--       -- highlights (ported cleanly)
--       -------------------------------------------------
--       vim.api.nvim_set_hl(0, 'BlinkGhostText', {
--         fg = '#5c6370',
--         italic = true,
--       })
--
--       vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
--       vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#5c6370' })
--
--       -------------------------------------------------
--       -- blink setup
--       -------------------------------------------------
--       require('blink.cmp').setup {
--         fuzzy = {
--           -- implementation = 'prefer_rust_with_warning'
--           implementation = 'lua',
--         },
--         -------------------------------------------------
--         -- appearance
--         -------------------------------------------------
--         appearance = {
--           nerd_font_variant = 'normal',
--         },
--
--         -------------------------------------------------
--         -- completion window
--         -------------------------------------------------
--         completion = {
--           menu = {
--             border = 'rounded',
--             winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel',
--             max_height = 20,
--           },
--
--           documentation = {
--             auto_show = true,
--             auto_show_delay_ms = 0,
--
--             window = {
--               border = 'rounded',
--               max_width = 90,
--               max_height = 30,
--               winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
--             },
--
--             -- IMPORTANT: this fixes your Treesitter issue correctly
--             treesitter_highlighting = true,
--           },
--
--           -------------------------------------------------
--           -- ghost text (VALID FORMAT)
--           -------------------------------------------------
--           ghost_text = {
--             enabled = true,
--           },
--         },
--
--         -------------------------------------------------
--         -- snippets
--         -------------------------------------------------
--         snippets = {
--           expand = function(snippet)
--             luasnip.lsp_expand(snippet)
--           end,
--         },
--
--         -------------------------------------------------
--         -- sources (Blink-native)
--         -------------------------------------------------
--         sources = {
--           default = {
--             'lsp',
--             'path',
--             'snippets',
--             'buffer',
--           },
--         },
--
--         -------------------------------------------------
--         -- keymap (VALID Blink schema)
--         -------------------------------------------------
--         keymap = {
--           preset = 'default',
--
--           ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
--           ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
--
--           ['<CR>'] = { 'accept', 'fallback' },
--           ['<Esc>'] = { 'hide', 'fallback' },
--
--           ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
--           ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
--         },
--       }
--     end,
--   },
-- }

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',

    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
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
      vim.api.nvim_set_hl(0, 'CmpItemSel', { link = 'PmenuSel' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { link = 'Pmenu' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'Pmenu' })
      vim.api.nvim_set_hl(0, 'CmpGhostText', {
        fg = '#5c6370', -- subtle gray
        bg = 'none',
        italic = true,
        blend = 0,
      })
      vim.api.nvim_set_hl(0, 'CmpFloatNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'CmpDocNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'CmpFloatBorder', {
        bg = 'NONE',
        fg = vim.g.nonbinary_dark_palette and vim.g.nonbinary_dark_palette.border or '#5c6370',
      })
      vim.api.nvim_set_hl(0, 'CmpDocBorder', {
        bg = 'NONE',
        fg = vim.g.nonbinary_dark_palette and vim.g.nonbinary_dark_palette.border or '#5c6370',
      })

      -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#5c6370' })
      vim.opt.winblend = 0
      vim.opt.pumblend = 0

      -- events for colors
      cmp.event:on('menu_opened', function()
        vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = 'NONE' })
      end)

      cmp.event:on('menu_closed', function()
        local c = vim.g.nonbinary_dark_palette

        vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = c.selection })
        vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = c.selection })
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = c.selection })
      end)

      -------------------------------------------------
      -- Window style options
      -------------------------------------------------
      local win_opt = {
        border = 'rounded',
        col_offset = 0,
        side_padding = 1,
        max_height = 20,
        -- winhighlight = 'Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
        winhighlight = 'Normal:CmpFloatNormal,FloatBorder:CmpFloatBorder,CursorLine:PmenuSel',
      }

      local doc_opt = {
        border = 'rounded',
        col_offset = 0,
        side_padding = 1,
        -- core sizing controls
        max_height = 30,
        max_width = 90,
        -- IMPORTANT: enforce minimum size too (not always respected but helps)
        min_width = 50,
        min_height = 10,
        -- winhighlight = 'Normal:PopMenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        winhighlight = 'Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:Visual',
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

        -- experimental
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },

        -------------------------------------------------
        -- Windows
        -------------------------------------------------
        window = {
          completion = cmp.config.window.bordered(win_opt),
          documentation = cmp.config.window.bordered(doc_opt),
        },

        -------------------------------------------------
        -- Formatting
        -------------------------------------------------
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '…',
          },
        },

        -------------------------------------------------
        -- Smarter Tab Logic (KEY FIX)
        -------------------------------------------------
        mapping = cmp.mapping.preset.insert {

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- Always prioritize completion navigation
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              -- Only jump if actually in snippet placeholder
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<CR>'] = cmp.mapping.confirm { select = false },
          ['<Esc>'] = function(fallback)
            cmp.abort()
            fallback()
          end,

          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
        },

        -------------------------------------------------
        -- Sources
        -------------------------------------------------
        sources = cmp.config.sources {
          { name = 'copilot', priority = 1100 },
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'path', priority = 500 },
          { name = 'buffer', priority = 250, keyword_length = 3 },
        },
      }

      -- Command mode completion (:)
      cmp.setup.cmdline(':', {
        window = {
          completion = cmp.config.window.bordered(win_opt),
        },

        mapping = {
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              cmp.confirm { select = false }
            else
              fallback()
            end
          end, { 'c' }),

          ['<Tab>'] = cmp.mapping(function()
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          end, { 'c' }),

          ['<S-Tab>'] = cmp.mapping(function()
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
          end, { 'c' }),
        },

        completion = {
          autocomplete = { cmp.TriggerEvent.TextChanged },
        },

        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    dependencies = { 'nvim-cmp' },
    config = function()
      require('tailwindcss-colorizer-cmp').setup()
    end,
  },
}
