require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      scope_decremental = 'grm',
    }
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    'tsx',
    'json',
    'yaml',
    'html',
    'scss',
  }
})
