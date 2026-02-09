return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }

      -- Normal mode: <C-n> behaves like gc
      vim.keymap.set('n', '<C-n>', 'gcc', { remap = true, desc = 'Comment line' })

      -- Visual mode: <C-n> behaves like gc
      vim.keymap.set('v', '<C-n>', 'gc', { remap = true, desc = 'Comment selection' })
    end,
  },
}
