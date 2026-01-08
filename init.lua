-- You download plugins with plugins.sh
vim.cmd.colorscheme('dracula')
vim.opt.ignorecase         = true
vim.opt.number             = true
vim.opt.cursorline         = true
vim.opt.expandtab          = true
vim.opt.clipboard          = 'unnamedplus'
vim.opt.termguicolors      = true
vim.opt.wildmode           = 'longest:full,full'
vim.opt.tabstop            = 4
vim.opt.softtabstop        = 4
vim.opt.shiftwidth         = 4
vim.g.mapleader            = ' '
vim.g.VM_leader            = '<space>v'
vim.g.VM_theme             = 'iceblue'
vim.g.foldsearch_highlight = 1
vim.opt.timeoutlen         = 200
vim.opt.whichwrap          = vim.opt.whichwrap+'<,>,h,l,[,]'
-- Open buffer at cursor location when last closed.
vim.cmd([[ au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif ]])
-- Plugins
require('mini.surround').setup()
require('fzf-lua').setup()
require('nvim-treesitter.configs').setup({ incremental_selection = { enable = true, keymaps = { init_selection = 'vm', scope_incremental = false, node_incremental = 'm', node_decremental = 'n', }, }, highlight = { enable = true }, })
local wk = require('which-key')
wk.setup()
wk.add({
        {"<leader>f", name = 'Fold search'},
        {"<leader>v", name = 'Vim Visual Multi'},
})
-- Keymaps
vim.keymap.set({'n','v'}, 'gh', '0', {desc = 'Move to the start of the line', noremap=false})
vim.keymap.set({'n','v'}, 'gl', '$', {desc = 'Move to the end of the line', noremap=false})
vim.keymap.set({'n','v'}, 'gk', 'gg', {desc = 'Move to the start of the file', noremap=false})
vim.keymap.set({'n','v'}, 'gj', 'G', {desc = 'Move to the end of the file', noremap=false})
vim.keymap.set({'n','v'}, 'U', '<C-r>', {desc = 'Redo with U' })
vim.keymap.set({'n','v'}, '<tab>', '<cmd>bnext<cr>', {desc = 'Switch to next buffer', silent = false})
vim.keymap.set({'n','v'}, '<leader>p', '<cmd>FzfLua files<cr>', {desc = 'Pick file'})
vim.keymap.set({'n','v'}, '<leader>g', '<cmd>Gvdiffsplit<cr>', {desc = 'Git diff split'})
vim.keymap.set({'n','v'}, '<leader>s', '<cmd>SudaWrite<cr>', {desc = 'Write as Sudo'})
vim.keymap.set({'n','v'}, '<leader><leader>', '<cmd>nohlsearch<cr>', {desc = 'Clear search highlight'})
vim.keymap.set('n', '<cr>', ':call ToggleFold()<cr>zz', {desc = 'Toggle folds'})
vim.keymap.set('n', 'vv', 'V', {desc = 'Visual line'})
vim.keymap.set('n', '<leader>a', ':%VMSearch<cr>:Fe<cr>:Fs<cr>zz', {desc = 'Cursor on each last search'})
vim.keymap.set('v', '<leader>a', ':VMSearch<cr>:Fe<cr>:Fs<cr>zz', {desc = 'Cursor on each last search in visual selection'})
vim.keymap.set('c', '<C-Space>', [[.\{-}]], {desc = 'Add lazy regex space'}, {expr=true})
-- Jobb
vim.keymap.set('n', '<leader>o', '0iOK - <esc>$bbb', {desc = 'OK Villkor'})
vim.keymap.set('n', '<leader>n', '0iNEJ - <esc>$bbb', {desc = 'NEJ Villkor'})
vim.keymap.set('n', '<leader>l', '0iANNAN LP - <esc>$bbb', {desc = 'ANNAN LP Villkor'})
-- Functions
vim.cmd([[
function! ToggleFold()
  let view = winsaveview()
  exec 'keepjumps normal! zj'
  if foldclosed('.') > -1
      exec 'Fe'
  else
      exec 'keepjumps normal! zk'
      if foldclosed('.') > -1
          exec 'Fe'
      else
          exec 'Fs'
      endif
  endif
  call winrestview(view)
endfunction
]])
vim.cmd([[
function! YankShift()
  for i in range(9, 1, -1)
    call setreg(i, getreg(i - 1))
  endfor
endfunction
function! DeleteShift()
  call setreg(0, getreg(1))
endfunction
au TextYankPost * if v:event.operator == 'y' | call YankShift() | endif
au TextYankPost * if v:event.operator == 'd' | call DeleteShift() | endif
]])
