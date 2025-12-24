return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local utils = require 'alpha.utils'

    math.randomseed(os.time() + (vim.loop.hrtime() % 1000))

    ---------------------------------------------------------------------------
    -- Greeting helpers
    ---------------------------------------------------------------------------
    local function getGreeting(name)
      local hour = tonumber(os.date '%H')
      local greetings = {
        [1] = '  Sleep well',
        [2] = '  Good morning',
        [3] = '  Good afternoon',
        [4] = '  Good evening',
        [5] = '󰖔  Good night',
      }

      local idx
      if hour == 23 or hour < 7 then
        idx = 1
      elseif hour < 12 then
        idx = 2
      elseif hour < 18 then
        idx = 3
      elseif hour < 21 then
        idx = 4
      else
        idx = 5
      end

      return greetings[idx] .. ', ' .. name .. '!'
    end

    local function getUsername()
      local names = { 'lua', 'moon', 'mint' }
      return names[math.random(#names)]
    end

    local greeting = getGreeting(getUsername())

    ---------------------------------------------------------------------------
    -- Logo
    ---------------------------------------------------------------------------
    local logo = [[










                                             
      ███████████           █████      ██
     ███████████             █████ 
     █████████ ███████ ███████████ ███   ███████
    ████████████████ ████████████ █████ ██████████████
   █████████████████████████████ █████ █████ ████ █████
 ██████████████████████████████████ █████ █████ ████ █████
██████  ███ █████████████████ ████ █████ █████ ████ ██████
██████   ██  ███████████████   ██ █████████████████

      ]]

    local header_val = vim.split(logo, '\n')

    ---------------------------------------------------------------------------
    -- Header highlight map (ported 1:1)
    ---------------------------------------------------------------------------
    local header_hl = {
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },
      { { 'Red', 1, 1 } },

      { { 'AlphaHeader0_0', 45, 47 } },

      {
        { 'AlphaHeader1_0', 6, 21 },
        { 'AlphaHeader1_1', 32, 39 },
        { 'AlphaHeader1_2', 39, 49 },
      },
      {
        { 'AlphaHeader2_0', 5, 20 },
        { 'AlphaHeader2_1', 32, 44 },
        { 'AlphaHeader1_2', 45, 60 },
      },
      {
        { 'AlphaHeader3_0', 5, 18 },
        { 'AlphaHeader3_1', 18, 19 },
        { 'AlphaHeader3_2', 19, 34 },
        { 'AlphaHeader3_3', 34, 44 },
        { 'AlphaHeader3_4', 44, 89 },
      },
      {
        { 'AlphaHeader4_0', 4, 17 },
        { 'AlphaHeader4_1', 17, 35 },
        { 'AlphaHeader4_2', 35, 44 },
        { 'AlphaHeader4_3', 44, 89 },
      },
      {
        { 'AlphaHeader5_0', 3, 16 },
        { 'AlphaHeader5_1', 16, 23 },
        { 'AlphaHeader5_2', 23, 27 },
        { 'AlphaHeader5_3', 27, 36 },
        { 'AlphaHeader5_4', 36, 45 },
        { 'AlphaHeader5_5', 45, 89 },
      },
      {
        { 'AlphaHeader6_0', 1, 16 },
        { 'AlphaHeader6_1', 16, 37 },
        { 'AlphaHeader6_2', 37, 44 },
        { 'AlphaHeader6_3', 45, 89 },
      },
      {
        { 'AlphaHeader7_0', 0, 16 },
        { 'AlphaHeader7_1', 16, 37 },
        { 'AlphaHeader7_2', 37, 44 },
        { 'AlphaHeader7_3', 45, 89 },
      },
      {
        { 'AlphaHeader8_0', 0, 36 },
        { 'AlphaHeader8_1', 36, 90 },
      },
    }

    ---------------------------------------------------------------------------
    -- Color palette + highlight application
    ---------------------------------------------------------------------------
    local nb = {
      yellow1 = '#fff238',
      yellow2 = '#fff04b',
      yellow3 = '#ffee5d',
      yellow4 = '#ffec70',
      yellow5 = '#ffea82',
      yellow6 = '#ffe894',
      yellow7 = '#ffe6a7',

      purple1 = '#5318c2',
      purple2 = '#622ac6',
      purple3 = '#6c37c9',
      purple4 = '#7643cc',
      purple5 = '#804fcf',
      purple6 = '#8959d1',
      purple7 = '#9467d5',

      white3 = '#d4d4d4',
      white4 = '#dddddd',
      white5 = '#e7e7e7',
      white6 = '#f0f0f0',
      white7 = '#fafafa',

      black = '#1A0F18',
    }

    local header_colors = {
      AlphaHeader0_0 = nb.purple1,
      AlphaHeader1_0 = nb.yellow1,
      AlphaHeader1_1 = nb.purple1,
      AlphaHeader1_2 = nb.purple1,
      AlphaHeader2_0 = nb.yellow2,
      AlphaHeader2_1 = nb.purple2,
      AlphaHeader3_0 = nb.yellow3,
      AlphaHeader3_1 = nb.white3,
      AlphaHeader3_2 = nb.white3,
      AlphaHeader3_3 = nb.purple3,
      AlphaHeader3_4 = nb.purple3,
      AlphaHeader4_0 = nb.yellow4,
      AlphaHeader4_1 = nb.white4,
      AlphaHeader4_2 = nb.purple4,
      AlphaHeader4_3 = nb.purple4,
      AlphaHeader5_0 = nb.yellow5,
      AlphaHeader5_1 = nb.white5,
      AlphaHeader5_2 = nb.black,
      AlphaHeader5_3 = nb.white5,
      AlphaHeader5_4 = nb.purple5,
      AlphaHeader5_5 = nb.purple5,
      AlphaHeader6_0 = nb.yellow6,
      AlphaHeader6_1 = nb.white6,
      AlphaHeader6_2 = nb.purple6,
      AlphaHeader6_3 = nb.purple6,
      AlphaHeader7_0 = nb.yellow7,
      AlphaHeader7_1 = nb.white7,
      AlphaHeader7_2 = nb.purple7,
      AlphaHeader7_3 = nb.purple7,
      AlphaHeader8_0 = nb.black,
      AlphaHeader8_1 = nb.black,
    }

    for name, hex in pairs(header_colors) do
      vim.api.nvim_set_hl(0, name, { fg = hex })
    end

    header_hl = utils.charhl_to_bytehl(header_hl, header_val, false)

    dashboard.section.header.val = header_val
    dashboard.section.header.opts.hl = header_hl

    ---------------------------------------------------------------------------
    -- Greeting + buttons
    ---------------------------------------------------------------------------
    dashboard.section.greeting = {
      type = 'text',
      val = greeting,
      opts = { position = 'center', hl = 'MatchParen' },
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', '󰮗  Find file', '<cmd>Telescope find_files hidden=true no_ignore=true<CR>'),
      dashboard.button('n', '  New file', '<cmd>ene | startinsert<CR>'),
      dashboard.button('r', '󰄉  Recent files', '<cmd>Telescope oldfiles<CR>'),
      dashboard.button('g', '󰊢  Git files', '<cmd>Telescope git_files<CR>'),
      dashboard.button('q', '󰿅  Quit', '<cmd>qa<CR>'),
    }
    dashboard.section.buttons.opts.hl = 'AlphaHeader1_0'

    ---------------------------------------------------------------------------
    -- Footer after Lazy startup
    ---------------------------------------------------------------------------
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      once = true,
      callback = function()
        local stats = require('lazy').stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        dashboard.section.footer.val = { ' ', ' Loaded ' .. stats.count .. ' plugins in ' .. ms .. ' ms' }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    ---------------------------------------------------------------------------
    -- Clean UI while dashboard is active
    ---------------------------------------------------------------------------
    local group = vim.api.nvim_create_augroup('CleanDashboard', {})

    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'AlphaReady',
      callback = function()
        vim.opt.showcmd = false
        vim.opt.ruler = false
      end,
    })

    vim.api.nvim_create_autocmd('BufUnload', {
      group = group,
      pattern = '<buffer>',
      callback = function()
        vim.opt.showcmd = true
        vim.opt.ruler = true
      end,
    })

    dashboard.opts.opts.noautocmd = true
    dashboard.opts.layout = {
      { type = 'padding', val = 2 },
      dashboard.section.header,
      dashboard.section.greeting,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
  end,
}
