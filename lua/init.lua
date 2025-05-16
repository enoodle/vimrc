require("config.lazy")

-- Set background to dark
vim.opt.background = "dark"
-- Allow backspacing over identation, end-of-line, and start-of-line
vim.opt.backspace = "2"
-- Enable working with hidden buffers
vim.opt.hidden = true
-- No beep
vim.opt.vb = true
-- Ignore case in search
vim.opt.ic = true
-- Case sensitive when upper case search pattern
vim.opt.scs = true
-- While typing search for pattern
vim.opt.incsearch = true
-- Set Pg Up/Dn to half screen size
vim.opt.scroll = 0
-- Set scrolloffset to 0
vim.opt.so = 0
-- Set horizontal scroll offset
vim.opt.sidescrolloff = 10
-- Cursor position
vim.opt.ru = true
-- Completion by all buffers, included files, etc
vim.opt.cpt = ".,w,b,u,t,i"
-- Allow backspacing over autoindent, line breaks, start of insert
vim.opt.bs = "eol,start,indent"
-- Always show status line
vim.opt.laststatus = 2
-- Option menu on the lower bar above the command line for vim options
vim.opt.wildmenu = true
-- No wrapping of long lines
vim.opt.wrap = false
-- For windows resizing
vim.opt.mouse = "a"
-- Set colorscheme
vim.cmd("colorscheme neodark")


-- Enable syntax highlighting
vim.cmd("syntax on")
-- Enable filetype detection
vim.cmd("filetype on")
-- Enable filetype-specific indenting
vim.cmd("filetype indent on")
-- Enable filetype-specific plugins
vim.cmd("filetype plugin on")


-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars = { tab = "✗ ", trail = "✗", extends = "»", precedes = "«" }

-- Unprintable chars mapping
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "javascript", "javascript.jsx", "css", "html", "ruby", "yaml", "vue", "xml" },
  command = "setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "python", "cython", "vala", "lua" },
  command = "setlocal expandtab sts=4 sw=4 ts=4"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "*" },
  command = "setlocal autoindent"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "vala" },
  command = "setlocal cindent"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "python" },
  command = "let python_highlight_all=1"
})
vim.cmd("filetype plugin indent on")

-- wildignore
-- python
vim.opt.wildignore:append({ "*.pyc", "*.pyo" })
-- c/cpp
vim.opt.wildignore:append({ "*.o", "*.obj" })
-- editors
vim.opt.wildignore:append({ "*.swp", "*.~" })
-- VCS
vim.opt.wildignore:append({ "*/.git/*", "*/.hg/*", "*/.svn/*" })

-- Open files from last known position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {  pattern = "*",
  callback = function()
    local last_line = vim.fn.line("'\"")
    local total_lines = vim.fn.line("$")

    if last_line > 1 and last_line <= total_lines then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Ctrl-j to take current line one line lower
vim.api.nvim_set_keymap('n', '<C-j>', 'O<C-[>j', { noremap = false })
vim.api.nvim_set_keymap('n', '<M-j>', ':m+<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-k>', ':m .-2<CR>', { noremap = true })

-- Quickly edit/reload the vimrc file
vim.api.nvim_set_keymap('n', '<leader>ev', ':e $MYVIMRC<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':so $MYVIMRC<CR>', { silent = true, noremap = true })

-- UltiSnips:
vim.g.UltiSnipsExpandTrigger = "*&"

-- Start with indent guides
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_color_change_percent = 30

vim.g.xml_syntax_folding = 1
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'xml',
    command = 'setlocal foldmethod=syntax'
})

vim.g.yml_syntax_folding = 1
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'yml',
    command = 'setlocal foldmethod=syntax'
})

-- Fzf:
-- ctrlp replacement
vim.api.nvim_set_keymap('n', '<C-p>', ':lua Snacks.picker.smart()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';', ':lua Snacks.picker.buffers()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F3>', ':lua Snacks.picker.explorer()<CR>', { silent = true, noremap = true })

vim.api.nvim_set_keymap('n', '<F8>', ':lua Snacks.picker.lsp_symbols()<CR>', {noremap = true, silent = true})

-- Ack: (ag)
if vim.fn.executable('ag') == 1 then
  vim.g.ackprg = 'ag --vimgrep'
end
vim.api.nvim_set_keymap('n', '<C-k>', ':Ack! "\\b<cword>\\b"<CR>', { noremap = true, silent = true })

-- Spell check git commit messages
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.spell = true
  end,
  once = true
})


-- vim-virtualenv
-- NOTICE: pylint, pyflake has to come from the venv as well
vim.g.virtualenv_auto_activate = 1


-- vim-illuminate
vim.api.nvim_set_hl(0, 'illuminatedWord', { link = 'Visual' })
vim.api.nvim_set_keymap('n', 'ta', ':IlluminateToggle<CR>', {})

-- gitgutter colors
vim.api.nvim_set_hl(0, 'GitGutterAdd', { fg='#009900', bg='#073642', ctermfg=2, ctermbg=0 })
vim.api.nvim_set_hl(0, 'GitGutterChange', { fg='#bbbb00', bg='#073642', ctermfg=3, ctermbg=0 })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { fg='#ff2222', bg='#073642', ctermfg=1, ctermbg=0 })

-- -- Coc Menu colors fix
-- vim.api.nvim_set_hl(0, 'CocMenuSel', { fg='#000000', bg='#C70039', ctermfg=1, ctermbg=0 })

vim.g.spelunker_highlight_type = 2

-- golang configuration
vim.g.go_fmt_command = "gofmt"
vim.g.go_fmt_options = {
  gofmt = '-s',
}

require('lualine').setup({
    sections = {
        lualine_c = {
            { 'filename', path = 1 }
        }
    }
})

-- DAP
require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('dap-go').setup()
require('dap-python').setup('python3')

vim.keymap.set('n', '<Leader>do', function() require('dapui').open() end)
vim.keymap.set('n', '<Leader>dc', function() require('dapui').close() end)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F9>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<C-w>gd', function() vim.lsp.buf.definition({ split = 'horizontal' }) end)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('x', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

require('dap-go').setup({
    dap_configurations = {
        type = "go",
        name = "Remote",
        mode = "remote",
        request = "attach",
        connect = {
            host = "127.0.0.1",
            port = "10000",
        },
    },
    delve = {
        port = "10000",
    },
})

vim.diagnostic.config({virtual_text=true})
