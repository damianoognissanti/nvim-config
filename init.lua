vim.cmd.colorscheme('gruvbox')
vim.opt.ignorecase      = true
vim.opt.number          = true
vim.opt.cursorline      = true
vim.opt.expandtab       = true
vim.opt.clipboard       = 'unnamedplus'
vim.opt.termguicolors   = true
vim.opt.wildmode        = 'longest,list'
vim.opt.tabstop         = 4
vim.opt.softtabstop     = 4
vim.opt.shiftwidth      = 4
vim.opt.termguicolors   = true
vim.opt.number          = true
vim.g.mapleader         = ' '
vim.g.VM_leader         = '<space>v'
vim.o.timeout           = true
vim.o.timeoutlen        = 200
vim.opt.whichwrap       = vim.opt.whichwrap+'<,>,h,l,[,]'
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])
require('mini.surround').setup()
require('fzf-lua').setup()
require('nvim-treesitter').setup()
require('nvim-treesitter.configs').setup({
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'vm',
            scope_incremental = false,
            node_incremental = 'm',
            node_decremental = 'n',
        },
    },
    highlight  = { enable = true }, 
})
local wk = require('which-key')

wk.setup()
wk.register({
    ['<leader>'] = {
        f = { name = 'Fold search'},
        p = { name = 'Pick (fzf)'},
        v = { name = 'Vim Visual Multi'},
    },
})
vim.keymap.set({'n','v'}, 'gl',               '$',                          {desc = 'Move to the end of the line' ,noremap=false})
vim.keymap.set({'n','v'}, 'gj',               'G',                          {desc = 'Move to the end of the file' ,noremap=false})
vim.keymap.set({'n','v'}, 'gk',               'gg',                         {desc = 'Move to the start of the file' ,noremap=false})
vim.keymap.set({'n','v'}, 'gh',               '0',                          {desc = 'Move to the start of the line' ,noremap=false})
vim.keymap.set({'n','v'}, 'U',                '<C-r>',                      {desc= 'Redo with U' })
vim.keymap.set({'n','v'}, 'ö',                ':',                          {desc= 'Run command (:)', silent = false})
vim.keymap.set({'n','v'}, 'ä',                '/',                          {desc= 'Search', silent = false})
vim.keymap.set({'n','v'}, '<tab>',            '<cmd>bnext<cr>',             {desc= 'Switch to next buffer', silent = false})
vim.keymap.set({'n','v'}, '<leader>pd',       '<cmd>FzfLua grep_cword<cr>', {desc = 'Word under cursor'  ,noremap=false})
vim.keymap.set({'n','v'}, '<leader>ps',       '<cmd>FzfLua live_grep<cr>',  {desc = 'String you type'  ,noremap=false})
vim.keymap.set({'n','v'}, '<leader>pf',       '<cmd>FzfLua files<cr>',      {desc = 'Filename'  ,noremap=false})
vim.keymap.set({'n','v'}, '<leader>w',        '<cmd>w<cr>',                 {desc = 'Write file'  ,noremap=false})
vim.keymap.set({'n','v'}, '<leader>q',        '<cmd>bd!<cr>',               {desc = 'Buffer Delete'  ,noremap=false})
vim.keymap.set({'n','v'}, '<leader>g',        '<cmd>Gvdiffsplit<cr>',       {desc = 'Git diff split'  ,noremap=false})
vim.keymap.set({'n','v'}, '<leader><leader>', '<cmd>nohlsearch<cr>',        {desc = 'Clear search highlight'  ,noremap=false})
vim.keymap.set('n',       '<leader>r',        ':%s///g<Left><Left>',        {desc = 'Replace'  ,noremap=false, silent=false})
vim.keymap.set('v',       '<leader>r',        ':s///g<Left><Left>',         {desc = 'Replace'  ,noremap=false, silent=false})

vim.keymap.set('n', '<leader>s', [[':<C-u>/\<' . expand('<cword>') . '\><cr>:Fs<cr>']], { desc = 'Search highlight', noremap = true, silent = false, expr = true })

vim.keymap.set('n', 'vv',       'V',                        {desc = 'Visual line'})
vim.keymap.set('n', 'vc',       '<C-v>',                    {desc = 'Visual column'})
vim.keymap.set('n', '<cr>',     ':call ToggleFold()<cr>zz', {noremap=true})
vim.keymap.set('v', 'sa',       '<Nop>',                    {noremap=false})
vim.keymap.set('v', 's',        ':VMSearch ',               {desc='Multicursor search', noremap=false,silent=false})

vim.keymap.set('c', 'qq',       'q!',                                                                    {noremap=false})
vim.keymap.set('c', '<leader>', [[getcmdtype() == "/" || getcmdtype() == "?" ? ".\\{-}" : "<space>"]],   {expr=true})
vim.keymap.set('c', '<cr>',     [[getcmdtype() == "/" || getcmdtype() == "?" ? "<cr>:Fs<cr>" : "<cr>"]], {expr=true})

vim.cmd([[
function! ToggleFold()
  let view = winsaveview()
  exec 'keepjumps normal! zj'
  if foldclosed('.') > -1 
      exec 'normal! zR' 
  else
      exec 'keepjumps normal! zk'
      if foldclosed('.') > -1 
          exec 'normal! zR' 
      else 
          exec 'normal! zM' 
      endif
  endif
  call winrestview(view)
endfunction
]])
