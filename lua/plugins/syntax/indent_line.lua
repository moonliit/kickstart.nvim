return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',

    init = function()
      -- Disable list symbols globally (prevents >> / » markers)
      vim.opt.list = false

      -- Optional: sane listchars if you ever re-enable `list`
      vim.opt.listchars = {
        tab = '  ',
        trail = '·',
      }
    end,

    opts = {
      indent = {
        char = '│',
      },

      whitespace = {
        remove_blankline_trail = true,
      },

      scope = {
        enabled = false, -- equivalent to show_current_context = false
        show_start = false,
        show_end = false,
      },
    },
  },
}
