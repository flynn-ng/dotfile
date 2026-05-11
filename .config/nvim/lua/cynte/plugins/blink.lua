return {
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
  },
  build = function()
    -- build the fuzzy matcher, wait up to 60 seconds
    -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
    require('blink.cmp').build():wait(60000)
  end,
  opts = {
    keymap = { preset = 'super-tab' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = "rust" }
  },
}
