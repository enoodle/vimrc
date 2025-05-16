return {
    'plytophogy/vim-virtualenv',

    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',
    'easymotion/vim-easymotion',
    'tpope/vim-surround',

    -- Completion plugin of the week
    -- {'neoclide/coc.nvim', branch = 'release', build = ':CocInstall coc-yaml coc-go coc-json coc-tsserver coc-pyright coc-sh @yaegassy/coc-volar coc-snippets'},
    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            local lspconfig = require('lspconfig')

            -- Enable some LSPs
            local servers = { 'pyright', 'ts_ls', 'volar', 'jsonls', 'yamlls', 'gopls', 'lua_ls' }
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {}
            end
        end,
    },

    -- Mason
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },

    -- Null-ls
    {
        'nvimtools/none-ls.nvim',
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
        config = function()
            require('mason-null-ls').setup({
                ensure_installed = { 'prettierd', 'goimports', 'gitlint' },
            })
        end,
    },

    -- Mason-lspconfig
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { 'pyright', 'ts_ls', 'volar', 'jsonls', 'yamlls', 'gopls', 'lua_ls' },
            })
        end,
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

    -- GO:
    { 'fatih/vim-go', build = ':GoInstallBinaries' },
    -- 'charlespascoe/vim-go-syntax',
    'tpope/vim-abolish',
    'sebdah/vim-delve',

    'jlanzarotta/bufexplorer',
    'flazz/vim-colorschemes',

    'nathanaelkane/vim-indent-guides',
    'jeetsukumaran/vim-indentwise',

    -- javascript support
    'pangloss/vim-javascript',
    'leafgarland/typescript-vim',
    'peitalin/vim-jsx-typescript',

    'mileszs/ack.vim',
    -- 'RRethy/vim-illuminate',
    'tpope/vim-commentary',
    'heavenshell/vim-jsdoc',
    'sheerun/vim-polyglot',
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

    -- DAP
    'mfussenegger/nvim-dap',
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
                ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "go", "lua" },
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
