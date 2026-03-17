return {
    'plytophogy/vim-virtualenv',

    'tpope/vim-fugitive',

    -- #27: gitsigns replaces vim-gitgutter (lua-native, better performance)
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                },
            })
        end,
    },

    -- hop.nvim replaces vim-easymotion (lua-native, same workflow)
    {
        'smoka7/hop.nvim',
        version = '*',
        event = 'VeryLazy',
        opts = { keys = 'etovxqpdygfblzhckisuran' },
        keys = {
            { '<leader><leader>w', '<cmd>HopWord<cr>', desc = 'Hop to word' },
            { '<leader><leader>l', '<cmd>HopLine<cr>', desc = 'Hop to line' },
            { '<leader><leader>f', '<cmd>HopChar1<cr>', desc = 'Hop to char' },
            { '<leader><leader>s', '<cmd>HopChar2<cr>', desc = 'Hop to 2 chars' },
            { '<leader><leader>p', '<cmd>HopPattern<cr>', desc = 'Hop to pattern' },
        },
    },

    -- #29: nvim-surround replaces vim-surround (lua-native, same keybindings)
    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        opts = {},
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
    },

    -- Mason (must load before mason-lspconfig and mason-null-ls)
    {
        'mason-org/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },

    -- #33: Enforce mason dependency ordering
    -- Null-ls
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'mason-org/mason.nvim' },
        config = function()
            local null_ls = require('null-ls')

            null_ls.setup({
                debug = false,
                sources = {
                    null_ls.builtins.completion.spell,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.diagnostics.gitlint,
                },
            })
        end,
    },

    -- Mason-null-ls
    {
        'jay-babu/mason-null-ls.nvim',
        dependencies = { 'mason-org/mason.nvim', 'nvimtools/none-ls.nvim' },
        config = function()
            require('mason-null-ls').setup({
                ensure_installed = { 'prettierd', 'goimports', 'gitlint' },
            })
        end,
    },

    -- Mason-lspconfig
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = { 'mason-org/mason.nvim' },
        opts = {
            ensure_installed = {
                'pyright', 'ts_ls', 'vtsls', 'jsonls', 'yamlls', 'gopls', 'lua_ls', 'bashls',
            },
        },
    },

    -- LSP Kind
    {
        'onsails/lspkind.nvim',
        config = function()
            require('lspkind').init({
                mode = 'text',
                preset = 'codicons',
            })
        end,
    },

    -- completion plugin
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            completion = {
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" }
    },

    -- GO: (#22: disable vim-go LSP features, let gopls via lspconfig handle it)
    {
        'fatih/vim-go',
        build = ':GoInstallBinaries',
        config = function()
            vim.g.go_gopls_enabled = 0
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_diagnostics_enabled = 0
            vim.g.go_doc_keywordprg_enabled = 0
        end,
    },
    'tpope/vim-abolish',
    -- #23: vim-delve removed, nvim-dap-go handles Go debugging

    -- #24: bufexplorer removed, Snacks.picker.buffers() replaces it
    -- #25: vim-colorschemes replaced with just the neodark theme
    'KeitaNakamura/neodark.vim',

    -- #16 (from general): vim-indent-guides removed, Snacks indent handles this
    'jeetsukumaran/vim-indentwise',

    -- #21: vim-javascript, typescript-vim, vim-jsx-typescript removed
    -- treesitter handles JS/TS syntax highlighting now

    'mileszs/ack.vim',
    -- #28: vim-commentary removed, Neovim 0.10+ has built-in gc commenting
    'heavenshell/vim-jsdoc',
    -- #21: vim-polyglot removed, treesitter supersedes it
    'preservim/vimux',

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true } -- Wrap notifications
                }
            }
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- DAP (#19: consolidated into single nvim-dap declaration)
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'jbyuki/one-small-step-for-vimkind',
        },
        lazy = false,
        config = function()
            local dap = require('dap')
            dap.configurations.lua = {
                {
                    type = 'nlua',
                    request = 'attach',
                    name = "Attach to running Neovim instance",
                }
            }

            dap.adapters.nlua = function(callback, config)
                callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
            end
        end,
        keys = {
            {
                "<leader>ddl",
                "<cmd>lua require('osv').launch({port=8086})<cr>",
                desc = "start lua osv server",
            },
        },
    },
    { 'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'} },
    { 'theHamsta/nvim-dap-virtual-text', dependencies = {'mfussenegger/nvim-dap',} },
    { 'mfussenegger/nvim-dap-python', dependencies = {'mfussenegger/nvim-dap',} },
    { 'leoluz/nvim-dap-go', dependencies = {'mfussenegger/nvim-dap',}},

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                -- #20: removed duplicate "lua" entry
                ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "go", "typescript", "tsx" },
                sync_install = false,
                highlight = { enable = true },
                illuminate = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
