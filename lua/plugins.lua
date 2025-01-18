return {
    -- Telescope for file search and live grep
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Language support for Go, Java, and Lua
    { "neovim/nvim-lspconfig" },  -- Base LSP
    { "williamboman/mason.nvim", config = true },  -- LSP/DAP installer
    { "williamboman/mason-lspconfig.nvim", config = true },
    { "mfussenegger/nvim-dap" },  -- Debugging
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

    -- Test runner
    { "nvim-neotest/neotest", dependencies = { "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-neotest/nvim-nio"} },
    { "nvim-neotest/neotest-go" },

    -- Git blame
    { "lewis6991/gitsigns.nvim", config = true },

    -- Copilot
    { "github/copilot.vim" },

    -- WhichKey
    { "folke/which-key.nvim", lazy = true },

    -- Nvim-tree
    { 'nvim-tree/nvim-tree.lua' },
}



