return {
  {
    'echasnovski/mini.splitjoin',
    version = false,
    keys = {
      {
        '<leader>g',
        function()
          require('mini.splitjoin').toggle()
        end,
        desc = 'Split/Join',
      },
    },
    config = function()
      require('mini.splitjoin').setup {
        mappings = {
          toggle = '<leader>g', -- split or join
          split = '', -- disable extra mappings
          join = '',
        },
      }
    end,
  },
}
