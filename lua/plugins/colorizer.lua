return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = function()
      require('colorizer').setup {
        user_default_options = {
          mode = 'virtualtext',
          virtualtext = '■',
          virtualtext_inline = false,
          virtualtext_mode = 'foreground',
        },
      }
    end,
  },
}
