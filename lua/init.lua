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

-- Tag bar
-- Map F8 to toggle Tagbar
vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", {noremap = true, silent = true})
-- Auto focus on Tagbar when it opens
vim.g.tagbar_autofocus = 1
-- Tagbar settings for CSS
vim.g.tagbar_type_css = {
  ctagstype = "Css",
  kinds = {
    "c:classes",
    "s:selectors",
    "i:identities"
  }
}

-- Quickly edit/reload the vimrc file
vim.api.nvim_set_keymap('n', '<leader>ev', ':e $MYVIMRC<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':so $MYVIMRC<CR>', { silent = true, noremap = true })

-- FuzzyFinder to find files in current directory
vim.api.nvim_set_keymap('n', '<F3>', ':FufFileWithCurrentBufferDir<CR>', { silent = true, noremap = true })

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
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':Tags<CR>', { noremap = true, silent = true })
-- Customize fzf colors to match your color scheme
vim.g.fzf_colors = {
  fg      = { 'fg', 'Normal' },
  bg      = { 'bg', 'Normal' },
  hl      = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { 'fg', 'Statement' },
  info    = { 'fg', 'PreProc' },
  border  = { 'fg', 'LineNr' },
  prompt  = { 'fg', 'Conditional' },
  pointer = { 'fg', 'Exception' },
  marker  = { 'fg', 'Keyword' },
  spinner = { 'fg', 'Label' },
  header  = { 'fg', 'Comment' }
}

vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'

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

vim.g.spelunker_highlight_type = 2

-- golang configuration
vim.g.go_fmt_command = "gofmt"
vim.g.go_fmt_options = {
  gofmt = '-s',
}

require('lualine').setup()

-- DAP
require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('dap-go').setup()
require('dap-python').setup('python3')

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

  -- AI completions

-- require("copilot").setup({})

-- local prompts = require('CopilotChat.prompts')
-- local select = require('CopilotChat.select')

-- require("CopilotChat").setup {
--   debug = false, -- Enable debug logging
--   proxy = nil, -- [protocol://]host[:port] Use this proxy
--   allow_insecure = false, -- Allow insecure server connections

--   -- default prompts
--   prompts = {
--     Explain = {
--       prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
--     },
--     Review = {
--       prompt = '/COPILOT_REVIEW Review the selected code.',
--       callback = function(response, source)
--         -- see config.lua for implementation
--       end,
--     },
--     Fix = {
--       prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
--     },
--     Optimize = {
--       prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
--     },
--     Docs = {
--       prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
--     },
--     Tests = {
--       prompt = '/COPILOT_GENERATE Please generate tests for my code.',
--     },
--     FixDiagnostic = {
--       prompt = 'Please assist with the following diagnostic issue in file:',
--       selection = select.diagnostics,
--     },
--     Commit = {
--       prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
--       selection = select.gitdiff,
--     },
--     CommitStaged = {
--       prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
--       selection = function(source)
--         return select.gitdiff(source, true)
--       end,
--     },
--   },

--   system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
--   model = 'gpt-4o', -- GPT model to use, see ':CopilotChatModels' for available models
--   temperature = 0.1, -- GPT temperature

--   question_header = '## User ', -- Header to use for user questions
--   answer_header = '## Copilot ', -- Header to use for AI answers
--   error_header = '## Error ', -- Header to use for errors
--   separator = '───', -- Separator to use in chat

--   show_folds = true, -- Shows folds for sections in chat
--   show_help = true, -- Shows help message as virtual lines when waiting for user input
--   auto_follow_cursor = true, -- Auto-follow cursor in chat
--   auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
--   insert_at_end = false, -- Move cursor to end of buffer when inserting text
--   clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
--   highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

--   context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
--   history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
--   callback = nil, -- Callback to use when ask response is received

--   -- default selection (visual or line)
--   selection = function(source)
--     return select.visual(source) or select.line(source)
--   end,

--   -- default window options
--   window = {
--     layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
--     width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
--     height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
--     -- Options below only apply to floating windows
--     relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
--     border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
--     row = nil, -- row position of the window, default is centered
--     col = nil, -- column position of the window, default is centered
--     title = 'Copilot Chat', -- title of chat window
--     footer = nil, -- footer of chat window
--     zindex = 1, -- determines if window is on top or below other floating windows
--   },

--   -- default mappings
--   mappings = {
--     complete = {
--       detail = 'Use @<Tab> or /<Tab> for options.',
--       insert ='<Tab>',
--     },
--     close = {
--       normal = 'q',
--       insert = '<C-c>'
--     },
--     reset = {
--       normal ='<C-l>',
--       insert = '<C-l>'
--     },
--     submit_prompt = {
--       normal = '<CR>',
--       insert = '<C-s>'
--     },
--     accept_diff = {
--       normal = '<C-y>',
--       insert = '<C-y>'
--     },
--     yank_diff = {
--       normal = 'gy',
--       register = '"',
--     },
--     show_diff = {
--       normal = 'gd'
--     },
--     show_info = {
--       normal = 'gp'
--     },
--     show_context = {
--       normal = 'gs'
--     },
--   },
-- }

-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<Tab>",
--   dismiss_keymap = "<C-]>",
--   debounce_ms = 300,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   execlude_filetypes = {"TelescopePrompt"}
-- })

-- local llm = require('llm')

-- llm.setup({
--   api_token = nil, -- cf Install paragraph
--   model = "bigcode/starcoder2-7b", -- the model ID, behavior depends on backend
--   backend = "openai", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
--   url = "http://localhost:8800", -- the http url of the backend
--   tokens_to_clear = { "<|endoftext|>" }, -- tokens to remove from the model's output
--   -- parameters that are added to the request body, values are arbitrary, you can set any field:value pair here it will be passed as is to the backend
--   request_body = {
--       temperature = 0.2,
--       top_p = 0.95,
--   },
--   -- set this if the model supports fill in the middle
--   fim = {
--     enabled = true,
--     prefix = "<fim_prefix>",
--     middle = "<fim_middle>",
--     suffix = "<fim_suffix>",
--   },
--   debounce_ms = 150,
--   accept_keymap = "<Tab>",
--   dismiss_keymap = "<S-Tab>",
--   tls_skip_verify_insecure = false,
--   -- llm-ls configuration, cf llm-ls section
--   lsp = {
--     bin_path = nil,
--     host = nil,
--     port = nil,
--     cmd_env = nil, -- or { LLM_LOG_LEVEL = "DEBUG" } to set the log level of llm-ls
--     version = "0.5.3",
--   },
--   tokenizer = {
--       repository = "bigcode/starcoder2-7b",
--   },
--   context_window = 4096, -- max number of tokens for the context window
--   enable_suggestions_on_startup = true,
--   enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
--   disable_url_path_completion = false, -- cf Backend
-- })
