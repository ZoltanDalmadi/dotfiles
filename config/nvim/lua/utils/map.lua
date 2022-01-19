function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function smap(shortcut, command)
  map('s', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
