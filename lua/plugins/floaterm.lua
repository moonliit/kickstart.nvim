return {
  {
    'nvzone/floaterm',
    dependencies = 'nvzone/volt',
    cmd = {
      'FloatermToggle',
    },

    keys = {
      { '<C-/>', '<cmd>FloatermToggle<CR>', desc = 'Toggle Floaterm', mode = { 'n', 't' } },
    },

    opts = {
      border = true,
      size = { h = 80, w = 80 },
      terminals = {
        { name = 'Terminal' },
      },
    },
  },
}
