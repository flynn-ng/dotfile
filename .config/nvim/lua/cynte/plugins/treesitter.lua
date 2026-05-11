return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = 'TSUpdate',
  opts = function()
    require('nvim-treesitter').install { 'typescript', 'javascript', 'lua', 'go', 'rust', 'jq', 'yaml', 'toml', 'zsh', 'bash', 'dockerfile', 'json', 'markdown', 'sql' }
  end
}
