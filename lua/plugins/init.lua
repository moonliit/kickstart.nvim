return {
  { 'tpope/vim-sleuth', event = 'BufReadPost' },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },
  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = true,
  },
  { 'cappyzawa/trim.nvim', event = { 'BufReadPre', 'BufNewFile' }, config = true },
  { 'gbprod/yanky.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = true },
  { 'vyfor/cord.nvim', event = 'VeryLazy', config = true },
  { 'windwp/nvim-ts-autotag', event = 'InsertEnter', opts = {} },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  { import = 'plugins.coding' },
  { import = 'plugins.editor' },
  { import = 'plugins.lsp' },
  { import = 'plugins.syntax' },
  { import = 'plugins.tools' },
  { import = 'plugins.ui' },
}
