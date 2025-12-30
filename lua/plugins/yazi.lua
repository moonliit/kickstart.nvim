return {
  {
    'mikavilpas/yazi.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '\\',
        function()
          require('yazi').yazi()
        end,
        desc = 'Open Yazi file manager',
        mode = 'n',
      },
    },

    opts = {
      open_for_directories = false,
      use_ya_for_events_reading = true,
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_border = 'rounded',
    },
  },
}
