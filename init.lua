-- download plugins with plugins.sh
vim.cmd.colorscheme('gruvbox')
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
vim.g.foldsearch_highlight = 1
vim.opt.timeoutlen         = 200
vim.opt.whichwrap          = vim.opt.whichwrap+'<,>,h,l,[,]'
-- Open buffer at cursor location when last closed.
vim.cmd([[ au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif ]])

if vim.fn.has("wsl") then
    vim.g.clipboard = {
        name = "win_clipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
    vim.keymap.set({"n", "v"}, "y", '"+y', { noremap = true, silent = true })
    vim.keymap.set({"n", "v"}, "p", '"+p', { noremap = true, silent = true })
end

require('mini.surround').setup()
require('fzf-lua').setup()
require('nvim-treesitter.configs').setup({ incremental_selection = { enable = true, keymaps = { init_selection = 'vm', scope_incremental = false, node_incremental = 'm', node_decremental = 'n', }, }, highlight  = { enable = true }, })
local wk = require('which-key')
wk.setup()
wk.add({
        {"<leader>f", name = 'Fold search'},
        {"<leader>p", name = 'Pick (fzf)'},
        {"<leader>v", name = 'Vim Visual Multi'},
})
vim.keymap.set({'n','v'}, 'gl',               '$',                          {desc = 'Move to the end of the line', noremap=false})
vim.keymap.set({'n','v'}, 'gj',               'G',                          {desc = 'Move to the end of the file', noremap=false})
vim.keymap.set({'n','v'}, 'gk',               'gg',                         {desc = 'Move to the start of the file', noremap=false})
vim.keymap.set({'n','v'}, 'gh',               '0',                          {desc = 'Move to the start of the line', noremap=false})
vim.keymap.set({'n','v'}, 'U',                '<C-r>',                      {desc = 'Redo with U' })
vim.keymap.set({'n','v'}, 'ö',                ':',                          {desc = 'Run command (:)', silent = false})
vim.keymap.set({'n','v'}, 'ä',                '/',                          {desc = 'Search', silent = false})
vim.keymap.set('n',       'vv',               'V',                          {desc = 'Visual line'})
vim.keymap.set({'n','v'}, '<tab>',            '<cmd>bnext<cr>',             {desc = 'Switch to next buffer', silent = false})
vim.keymap.set({'n','v'}, '<leader>pd',       '<cmd>FzfLua grep_cword<cr>', {desc = 'Word under cursor'})
vim.keymap.set({'n','v'}, '<leader>ps',       '<cmd>FzfLua live_grep<cr>',  {desc = 'String you type'})
vim.keymap.set({'n','v'}, '<leader>pf',       '<cmd>FzfLua files<cr>',      {desc = 'Filename'})
vim.keymap.set({'n','v'}, '<leader>w',        '<cmd>w<cr>',                 {desc = 'Write file'})
vim.keymap.set({'n','v'}, '<leader>q',        '<cmd>bd!<cr>',               {desc = 'Buffer Delete'})
vim.keymap.set({'n','v'}, '<leader>g',        '<cmd>Gvdiffsplit<cr>',       {desc = 'Git diff split'})
vim.keymap.set({'n','v'}, '<leader><leader>', '<cmd>nohlsearch<cr>',        {desc = 'Clear search highlight'})
vim.keymap.set('v',       'sa',               '<Nop>',                      {desc = 'No visual surround add: s is used for multicursors.'})
vim.keymap.set('v',       's',                ':VMSearch ',                 {desc = 'Multicursor search', silent=false})
vim.keymap.set('c',       'qq',               'q!',                         {desc = 'Rage quit'})
vim.keymap.set('c',       'ww',               ':SudaWrite<cr>',             {desc = 'Write as Sudo'})
vim.keymap.set('n',       '<cr>',             ':call ToggleFold()<cr>zz',   {desc = 'Toggle folds'})
vim.keymap.set('n',       '<leader>ff',       ':call ToggleFold()<cr>zz',   {desc = 'Toggle folds'})
vim.keymap.set('n',       '<leader>o',       '0iOK - <esc>$bbb',    {desc = 'OK Villkor'})
vim.keymap.set('n',       '<leader>n',       '0iNEJ - <esc>$bbb',    {desc = 'NEJ Villkor'})
-- Always fold seaches using Fold search.
-- Space adds .\\{-} instead of space for fuzzy search.
vim.keymap.set('c', '<cr>',     [[getcmdtype() == '/' || getcmdtype() == '?' ? '<cr>:Fs<cr>' : '<cr>']], {expr=true})
vim.keymap.set('c', '<space>', [[getcmdtype() == '/' || getcmdtype() == '?' ? '.\{-}' : '<space>']],   {expr=true})

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
          exec 'Fl'
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

