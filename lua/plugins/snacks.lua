return {
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    config = function()
      require('neoscroll').setup()
    end,
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      -------------------------------------------------------------------------
      -- Snacks setup
      -------------------------------------------------------------------------
      require('snacks').setup {
        -----------------------------------------------------------------------
        -- Core features
        -----------------------------------------------------------------------
        bigfile = { enabled = true },
        scroll = { enabled = false },
        quickfile = { enabled = true },
        indent = { enabled = true },
        words = { enabled = true },
        statuscolumn = { enabled = true },

        -----------------------------------------------------------------------
        -- Lazygit integration
        -----------------------------------------------------------------------
        lazygit = {
          config = {
            os = {
              edit = [[
[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})
              ]],
            },
          },
        },

        -----------------------------------------------------------------------
        -- Picker
        -----------------------------------------------------------------------
        picker = {
          enabled = true,

          sources = {
            explorer = {
              on_show = function(picker)
                local show = false
                local gap = 1

                local clamp_width = function(value)
                  return math.max(20, math.min(100, value))
                end

                local position = picker.resolved_layout.layout.position
                local rel = picker.layout.root

                local update = function(win)
                  local border = win:border_size().left + win:border_size().right
                  win.opts.row = vim.api.nvim_win_get_position(rel.win)[1]
                  win.opts.height = 0.8

                  if position == 'left' then
                    win.opts.col = vim.api.nvim_win_get_width(rel.win) + gap
                    win.opts.width = clamp_width(vim.o.columns - border - win.opts.col)
                  end

                  if position == 'right' then
                    win.opts.col = -vim.api.nvim_win_get_width(rel.win) - gap
                    win.opts.width = clamp_width(vim.o.columns - border + win.opts.col)
                  end

                  win:update()
                end

                local preview_win = Snacks.win.new {
                  relative = 'editor',
                  external = false,
                  focusable = false,
                  border = 'rounded',
                  backdrop = false,
                  show = show,
                  bo = {
                    filetype = 'snacks_float_preview',
                    buftype = 'nofile',
                    buflisted = false,
                    swapfile = false,
                    undofile = false,
                  },
                  on_win = function(win)
                    update(win)
                    picker:show_preview()
                  end,
                }

                rel:on('WinLeave', function()
                  vim.schedule(function()
                    if not picker:is_focused() then
                      picker.preview.win:close()
                    end
                  end)
                end)

                rel:on('WinResized', function()
                  update(preview_win)
                end)

                picker.preview.win = preview_win
                picker.main = preview_win.win
              end,

              on_close = function(picker)
                picker.preview.win:close()
              end,

              layout = {
                preset = 'sidebar',
                layout = {
                  backdrop = false,
                  width = 40,
                  min_width = 40,
                  height = 0,
                  position = 'right',
                  border = 'none',
                  box = 'vertical',
                  { win = 'list', border = 'none' },
                  { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
                },
                preview = false,
              },

              actions = {
                toggle_preview = function(picker)
                  picker.preview.win:toggle()
                end,
              },
            },
          },

          win = {
            input = {
              keys = {
                ['<C-d>'] = { 'preview_scroll_down', mode = 'n' },
                ['<C-u>'] = { 'preview_scroll_up', mode = 'n' },
                ['-'] = { 'edit_split', mode = 'n' },
                ['|'] = { 'edit_vsplit', mode = 'n' },
              },
            },
            list = {
              keys = {
                ['<C-d>'] = { 'preview_scroll_down', mode = 'n' },
                ['<C-u>'] = { 'preview_scroll_up', mode = 'n' },
                ['-'] = { 'edit_split', mode = 'n' },
                ['|'] = { 'edit_vsplit', mode = 'n' },
              },
            },
          },
        },

        -----------------------------------------------------------------------
        -- Image support
        -----------------------------------------------------------------------
        image = {
          enabled = true,
          border = 'none',
          doc = {
            inline = false,
          },
        },

        -----------------------------------------------------------------------
        -- Notifications
        -----------------------------------------------------------------------
        notifier = {
          enabled = true,
          style = 'minimal',
          top_down = false,
        },
      }

      -------------------------------------------------------------------------
      -- VimEnter autocmd (ported verbatim)
      -------------------------------------------------------------------------
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end

          _G.bt = function()
            Snacks.debug.backtrace()
          end

          vim.print = _G.dd

          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.inlay_hints():map '<leader>uh'
          Snacks.toggle.treesitter():map '<leader>uT'

          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'

          Snacks.toggle
            .option('conceallevel', {
              off = 0,
              on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
            })
            :map '<leader>uc'

          Snacks.toggle
            .option('background', {
              off = 'light',
              on = 'dark',
              name = 'Dark Background',
            })
            :map '<leader>ub'
        end,
      })
    end,
  },
}
