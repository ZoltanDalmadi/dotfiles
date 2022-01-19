require('utils/map')

-- Buffers and tabs
nmap('<F5>', ':bp<CR>')
nmap('<A-F5>', ':sbp<CR>')
nmap('<S-F5>', ':vert sbp<CR>')
nmap('<F6>', ':bn<CR>')
nmap('<A-F6>', ':sbn<CR>')
nmap('<S-F6>', ':vert sbn<CR>')
nmap('<F7>', ':tabprevious<CR>')
nmap('<F8>', ':tabnext<CR>')

-- Moving lines
nmap('<C-j>', ':m .+1<CR>==')
nmap('<A-DOWN>', ':m .+1<CR>==')
nmap('<C-k>', ':m .-2<CR>==')
nmap('<A-UP>', ':m .-2<CR>==')
imap('<C-j>', '<Esc>:m .+1<CR>==gi')
imap('<C-k>', '<Esc>:m .-2<CR>==gi')
vmap('<C-j>', ":m '>+1<CR>gv=gv")
vmap('<C-k>', ":m '<-2<CR>gv=gv")

-- Unbind Shift-Up and Shift-Down
nmap('<S-UP>', '<NOP>')
nmap('<S-DOWN>', '<NOP>')

-- Clear last search result (and highlight)
nmap('<C-L>', ':noh<CR>')
