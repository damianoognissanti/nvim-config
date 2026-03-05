-- You download plugins with plugins.sh
vim.cmd.colorscheme('dracula')
vim.opt.number=true; vim.opt.cursorline=true; vim.opt.termguicolors=true
vim.opt.ignorecase=true; vim.opt.expandtab=true
vim.opt.clipboard='unnamedplus'
vim.opt.wildmode='longest:full,full'
vim.opt.tabstop=4; vim.opt.softtabstop=4; vim.opt.shiftwidth=4
vim.opt.whichwrap=vim.opt.whichwrap+'<,>,h,l,[,]'
vim.g.mapleader=' '
vim.g.VM_leader='<leader>'; vim.g.VM_theme='iceblue'; vim.g.foldsearch_highlight=1
-- Open buffer at cursor location when last closed.
vim.cmd([[ au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif ]])
-- Keymaps
local wk = require("which-key")
wk.setup({ icons = { mappings = false, breadcrumb = "", separator = "", group = "" }, replace = { key = { function(k) return k end } } })
wk.add({ {"<leader>f", group = 'Fold search'}, })
vim.keymap.set({'n','v'}, 'U', '<C-r>', {desc = 'Redo with U' })
vim.keymap.set({'n','v'}, '<tab>', '<cmd>bnext<cr>', {desc = 'Switch to next buffer', silent = false})
vim.keymap.set({'n','v'}, '<S-tab>', '<cmd>bprev<cr>', {desc = 'Switch to previous buffer', silent = false})
vim.keymap.set({'n','v'}, '<leader>s', '<cmd>SudaWrite<cr>', {desc = 'Write as Sudo'})
vim.keymap.set({'n','v'}, '<leader><leader>', '<cmd>nohlsearch<cr>', {desc = 'Clear search highlight'})
vim.keymap.set('n', '<cr>', ':call ToggleFold()<cr>zz', {desc = 'Toggle folds'})
vim.keymap.set('n', 'vv', 'V', {desc = 'Visual line'})
vim.keymap.set('n', '<leader>o', '0iOK - <esc>$bbb', {desc = 'OK Villkor'})
vim.keymap.set('n', '<leader>n', '0iNEJ - <esc>$bbb', {desc = 'NEJ Villkor'})
vim.keymap.set('n', '<leader>l', '0iANNAN LP - <esc>$bbb', {desc = 'ANNAN LP Villkor'})
vim.keymap.set('n', '<leader>d', ':%d<cr>', {desc = 'Deletal'})
vim.keymap.set('n', '<leader>w', ':g/^$/d<cr>', {desc = 'Deletal whitespace'})
-- Functions
vim.cmd([[
function! ToggleFold()
  let view = winsaveview()
  keepjumps normal! zj
  if foldclosed('.') == -1
    keepjumps normal! zk
  endif
  exec foldclosed('.') > -1 ? 'Fe' : 'Fs'
  call winrestview(view)
endfunction

function! YankShift()
  for i in range(9, 1, -1)
    call setreg(i, getreg(i - 1))
  endfor
endfunction
function! DeleteShift()
  call setreg(0, getreg(1))
endfunction
au TextYankPost * if v:event.operator == 'y' | call YankShift() | elseif v:event.operator == 'd' | call DeleteShift() | endif
]])
