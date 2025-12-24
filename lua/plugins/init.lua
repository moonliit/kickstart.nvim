-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- sleuth vim (auto indentation)
  {
    'tpope/vim-sleuth',
    event = 'BufReadPost',
  },

  -- Icons (web-devicons)
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },

  -- fzf-lua
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },

  -- trouble.nvim
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },

  -- aerial.nvim (code outline)
  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = true,
  },

  -- trim.nvim (auto trim whitespace)
  {
    'cappyzawa/trim.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- yanky.nvim
  {
    'gbprod/yanky.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },

  -- transparent.nvim
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = true,
  },

  -- cord.nvim (Discord Rich Presence)
  {
    'vyfor/cord.nvim',
    event = 'VeryLazy',
    config = true,
  },
}
