return {
  -- Autopairs plugin for handling automatic insertion of closing braces, etc.
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {
      check_ts = true, -- Enable Treesitter integration for better context-based pairing
    }

    -- Integrating with nvim-cmp if you are using it (for completion)
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
