return {
    'plytophogy/vim-virtualenv',

    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',
    'easymotion/vim-easymotion',
    'tpope/vim-surround',
    'majutsushi/tagbar',

    -- Completion plugin of the week
    {'neoclide/coc.nvim', branch = 'release', build = ':CocInstall coc-yaml coc-go coc-json coc-tsserver coc-pyright coc-sh @yaegassy/coc-volar coc-snippets'},

    -- GO:
    { 'fatih/vim-go', build = 'GoInstallBinaries' },
    -- 'charlespascoe/vim-go-syntax',
    'tpope/vim-abolish',
    'sebdah/vim-delve',

    -- Snippets Plugin: ( + dependencies )
    'SirVer/ultisnips',
    'honza/vim-snippets',
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
    'kamykn/spelunker.vim',
    'kamykn/popup-menu.nvim',

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
    { 'leoluz/nvim-dap-go', dependencies = {'mfussenegger/nvim-dap',} },
    { 'mfussenegger/nvim-dap-python', dependencies = {'mfussenegger/nvim-dap',} },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                illuminate = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
