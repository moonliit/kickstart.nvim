return {
  -- 1. El motor de Copilot Oficial (Requisito)
  {
    'github/copilot.vim',
    config = function()
      -- Configura tus atajos preferidos para el autocompletado inline
    end,
  },

  -- 2. El Agente de Chat y Herramientas del Workspace
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'github/copilot.vim' }, -- O zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim' }, -- Utilidades de Lua
    },
    opts = {
      debug = false, -- Cambiar a true si hay errores
      model = 'gpt-4o',
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)
    end,
    keys = {
      -- Atajo para abrir el chat del agente
      { '<leader>cc', '<cmd>CopilotChatOpen<cr>', desc = 'CopilotChat - Abrir' },
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', mode = 'v', desc = 'CopilotChat - Explicar código' },
    },
  },
}
