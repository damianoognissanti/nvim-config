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
        ['<space>'] = {'<cmd>nohlsearch<cr>' ,'Clear search highlighting'},
        p = { name = 'Pick (fzf)',
            d = {'<cmd>FzfLua grep_cword<cr>','Word under cursor'},
            s = {'<cmd>FzfLua live_grep<cr>','String you type'},
            f = {'<cmd>FzfLua files<cr>','Filename'},
        },
        w = {'<cmd>w<cr>','Write file'},
        q = {'<cmd>bd<cr>','Kill buffer'},
        g = { name = 'Git',
            d = {'<cmd>Gvdiffsplit<cr>', 'Git diff split'},
            --g = {'<cmd>LazyGit<cr>', 'LazyGit', mode = {'n','v','t'}},
        },
        r = {':%s///g<Left><Left><Left>', 'Replace', mode = {'n'}, silent=false },
    },
    r = {':s///g<Left><Left><Left>', 'Replace', mode = {'v'}, silent=false },
    s = {':VMSearch<space>', 'Multicursor search', mode = {'v'}, silent=false},
    ['<tab>'] = {'<cmd>bnext<cr>','Switch to next buffer'},
    U = {'<C-r>', 'Redo with U', mode = {'n','v'}},
    ö = {':', 'Run command (:)', mode = {'n','v'}, silent = false},
    ä = {'/', 'Search', mode = {'n','v'}, silent = false},
    v = { 
        v = {'V', 'Visual Line'},
        c = {'<C-v>', 'Visual column'},
    },
})
vim.keymap.set({'n','v'}, 'gl', '$',  { desc = 'Move to the end of the line'    ,noremap=false})
vim.keymap.set({'n','v'}, 'gj', 'G',  { desc = 'Move to the end of the file'    ,noremap=false})
vim.keymap.set({'n','v'}, 'gk', 'gg', { desc = 'Move to the start of the file'  ,noremap=false})
vim.keymap.set({'n','v'}, 'gh', '0',  { desc = 'Move to the start of the line'  ,noremap=false})

vim.keymap.set('v', 'sa', '<Nop>', {noremap=false})
vim.keymap.set('c', 'qq', 'q!', {noremap=false})
vim.keymap.set('c', '<leader>', [[getcmdtype() == "/" || getcmdtype() == "?" ? ".\\{-}" : "<space>"]], {expr=true})
vim.keymap.set('c', '<cr>', [[getcmdtype() == "/" || getcmdtype() == "?" ? "<cr>:Fs<cr>" : "<cr>"]], {expr=true})

vim.cmd([[function ToggleFold()
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
