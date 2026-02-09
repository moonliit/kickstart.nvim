return {
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = 'make install_jsregexp',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets', -- optional but recommended
    },

    config = function()
      local luasnip = require 'luasnip'

      --------------------------------------------------
      -- 🔧 CORE FIXES FOR CURSOR JUMP BUG
      --------------------------------------------------
      luasnip.config.set_config {
        history = true, -- allow snippet history
        updateevents = 'TextChanged,TextChangedI',

        -- 🧠 THESE TWO FIX THE RANDOM JUMP BUG
        region_check_events = 'CursorMoved,InsertEnter',
        delete_check_events = 'TextChanged,InsertLeave',

        enable_autosnippets = false,
        ext_opts = {
          [require('luasnip.util.types').choiceNode] = {
            active = { virt_text = { { '●', 'Operator' } } },
          },
        },
      }

      --------------------------------------------------
      -- Load snippets
      --------------------------------------------------
      require('luasnip.loaders.from_vscode').lazy_load()

      --------------------------------------------------
      -- 🧹 AUTO-UNLINK BROKEN SNIPPETS
      -- If you leave insert mode while in a snippet,
      -- LuaSnip drops the snippet instead of keeping
      -- ghost jump points.
      --------------------------------------------------
      vim.api.nvim_create_autocmd('InsertLeave', {
        callback = function()
          if
            luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
            --and not luasnip.session.jump_active
          then
            luasnip.unlink_current()
          end
        end,
      })

      --------------------------------------------------
      -- Emergency key: cancel snippet session
      --------------------------------------------------
      vim.keymap.set({ 'i', 's' }, '<C-k>', function()
        if luasnip.in_snippet() then
          luasnip.unlink_current()
        end
      end, { desc = 'Cancel current snippet' })
    end,
  },
}
