require('../utils/map')

nmap('<leader>bf', [[<cmd>lua require('telescope').extensions.file_browser.file_browser({ hidden = true })<cr>]])
nmap('<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
nmap('<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
nmap('<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
nmap('<leader>ft', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]])
nmap('<leader>fr', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    sorting_strategy = 'ascending',
    scroll_strategy = 'limit',
    mappings = {
      i = {
        ['<esc>'] = actions.close
      }
    },
    layout_config = {
      prompt_position = 'top',
      width = .95,
      height = .95
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer
        }
      }
    }
  }
})

telescope.load_extension('fzf')
telescope.load_extension('neoclip')
telescope.load_extension('file_browser')
