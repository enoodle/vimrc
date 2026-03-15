require("config.lazy")

-- Set background to dark
vim.opt.background = "dark"
-- Allow backspacing over autoindent, line breaks, start of insert
vim.opt.backspace = "eol,start,indent"
-- Enable working with hidden buffers
vim.opt.hidden = true
-- No beep
vim.opt.visualbell = true
-- Ignore case in search
vim.opt.ignorecase = true
-- Case sensitive when upper case search pattern
vim.opt.smartcase = true
-- While typing search for pattern
vim.opt.incsearch = true
-- Set scrolloffset to 0
vim.opt.scrolloff = 0
-- Set horizontal scroll offset
vim.opt.sidescrolloff = 10
-- Cursor position
vim.opt.ruler = true
-- Completion by all buffers, included files, etc
vim.opt.complete = ".,w,b,u,t,i"
-- No wrapping of long lines
vim.opt.wrap = false
-- For windows resizing
vim.opt.mouse = "a"
-- True color support
vim.opt.termguicolors = true
-- Persistent undo
vim.opt.undofile = true
-- Faster CursorHold and swap file write
vim.opt.updatetime = 250
-- Set colorscheme
vim.cmd("colorscheme neodark")


-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars = { tab = "✗ ", trail = "✗", extends = "»", precedes = "«" }

-- Filetype-specific indentation
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "javascript", "javascript.jsx", "css", "html", "ruby", "yaml", "vue", "xml", "json" },
  command = "setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "python", "cython", "vala", "lua" },
  command = "setlocal expandtab sts=4 sw=4 ts=4"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "vala" },
  command = "setlocal cindent"
})
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "python" },
  command = "let python_highlight_all=1"
})

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
vim.keymap.set('n', '<C-j>', 'O<C-[>j', { remap = true })
vim.keymap.set('n', '<M-j>', ':m+<CR>')
vim.keymap.set('n', '<M-k>', ':m .-2<CR>')

-- Quickly edit/reload the vimrc file
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { silent = true })

vim.g.xml_syntax_folding = 1
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'xml',
    command = 'setlocal foldmethod=syntax'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'yaml',
    command = 'setlocal foldmethod=syntax'
})

-- Snacks picker
vim.keymap.set('n', '<C-p>', ':lua Snacks.picker.smart()<CR>', { silent = true })
vim.keymap.set('n', ';', ':lua Snacks.picker.buffers()<CR>', { silent = true })
vim.keymap.set('n', '<F3>', ':lua Snacks.picker.explorer()<CR>', { silent = true })
vim.keymap.set('n', '<F8>', ':lua Snacks.picker.lsp_symbols()<CR>', { silent = true })

-- Ack: prefer rg over ag
if vim.fn.executable('rg') == 1 then
  vim.g.ackprg = 'rg --vimgrep --smart-case'
elseif vim.fn.executable('ag') == 1 then
  vim.g.ackprg = 'ag --vimgrep'
end
vim.keymap.set('n', '<C-k>', ':Ack! "\\b<cword>\\b"<CR>', { silent = true })

vim.opt.spell = true
vim.keymap.set('n', 'z=', ':lua Snacks.picker.spelling()<CR>', { silent = true })

-- vim-virtualenv
-- NOTICE: pylint, pyflake has to come from the venv as well
vim.g.virtualenv_auto_activate = 1

-- vim-illuminate
vim.api.nvim_set_hl(0, 'illuminatedWord', { link = 'Visual' })
vim.keymap.set('n', 'ta', ':IlluminateToggle<CR>')

-- gitgutter colors
vim.api.nvim_set_hl(0, 'GitGutterAdd', { fg='#009900', bg='#073642', ctermfg=2, ctermbg=0 })
vim.api.nvim_set_hl(0, 'GitGutterChange', { fg='#bbbb00', bg='#073642', ctermfg=3, ctermbg=0 })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { fg='#ff2222', bg='#073642', ctermfg=1, ctermbg=0 })

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
        {
            type = "go",
            name = "Remote",
            mode = "remote",
            request = "attach",
            connect = {
                host = "127.0.0.1",
                port = "10000",
            },
        },
    },
    delve = {
        port = "10000",
    },
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.keymap.set('n', '<Leader>tf', function() require('dap-go').debug_test() end, {
      noremap = false,
      buffer = true
    })
  end
})

vim.diagnostic.config({virtual_text=true})
