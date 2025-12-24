return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWinEnter' },
    main = 'nvim-treesitter.config',

    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'rust',
        'python',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'json',
        'css',
        'toml',
      },

      auto_install = true,
      highlight = {
        enable = true,
        -- keep ruby regex fallback as you had it; others use treesitter
        additional_vim_regex_highlighting = { 'ruby' },
      },

      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },

    config = function(_, opts)
      -- correct module name and setup
      require('nvim-treesitter.config').setup(opts)

      -- Helper: attempt to ensure treesitter is running for a buffer
      local function ensure_treesitter_for_buf(bufnr)
        if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
        if not ft or ft == '' then
          return
        end

        -- Check if a parser exists for this filetype
        local ok_parser = pcall(vim.treesitter.get_parser, bufnr, ft)
        if not ok_parser then
          -- no parser installed for this ft
          return
        end

        -- If a highlighter is already active, nothing to do
        local ok_active, active = pcall(function()
          return vim.treesitter.highlighter.active and vim.treesitter.highlighter.active[bufnr]
        end)
        if ok_active and active then
          return
        end

        -- Try to start the highlighter for this buffer
        pcall(vim.treesitter.start, bufnr, ft)

        -- schedule a redraw and re-run FileType autocommands to be safe
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_call(bufnr, function()
              -- do not call removed :TSEnable; re-run FileType to trigger any ft-specific autocommands
              pcall(vim.cmd, 'doautocmd FileType')
              pcall(vim.cmd, 'redraw')
            end)
          end
        end)
      end

      -- Attach on a set of buffer events to cover Telescope/Alpha flows
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWinEnter', 'BufEnter' }, {
        callback = function(ev)
          -- use ev.buf when available (BufNewFile sometimes doesn't provide ev.buf)
          local bufnr = ev and ev.buf or vim.api.nvim_get_current_buf()
          ensure_treesitter_for_buf(bufnr)
        end,
      })

      -- Telescope-specific extra hook: ensure treesitter after telescope opens selection / previewer
      -- Telescope user events can be "TelescopePreviewerLoaded", "TelescopePreviewerLoaded", or others depending on extension;
      -- this is extra insurance and harmless if the user doesn't have Telescope.
      vim.api.nvim_create_autocmd('User', {
        pattern = { 'TelescopePreviewerLoaded', 'TelescopeOpen' },
        callback = function()
          ensure_treesitter_for_buf(vim.api.nvim_get_current_buf())
        end,
      })

      -- If you previously added a BufAdd -> filetype detect autocmd, it's usually not necessary;
      -- but keep a lightweight safeguard: when a buffer is added, ensure `filetype detect` and try attach.
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function(ev)
          -- Attempt a filetype detection for newly added buffers (safe, fast)
          pcall(vim.cmd, 'filetype detect')
          local bufnr = ev and ev.buf or vim.api.nvim_get_current_buf()
          ensure_treesitter_for_buf(bufnr)
        end,
      })
    end,
  },
}
