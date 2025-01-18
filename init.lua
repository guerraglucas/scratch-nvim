-- Disable unnecessary built-ins to improve startup time
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- Leader key
vim.g.mapleader = " "  -- Space as leader key

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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
    { "folke/which-key.nvim", config = true },

    -- Nvim-tree
    { 'nvim-tree/nvim-tree.lua',},
})

-- Telescope keybindings
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
        },
    },
})
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>")

-- Mason (LSP/DAP installer)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "gopls", "jdtls", "lua_ls" },
})

-- Neotest
require("neotest").setup({
    adapters = {
        require("neotest-go"),
 --       require("neotest-java"),
    },
})
vim.keymap.set("n", "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>")

-- DAP and DAP UI
require("dapui").setup()
vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>")
vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>")

-- Git signs
require("gitsigns").setup()

-- WhichKey
require("which-key").setup()

-- Define the on_attach function first
local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "?",     api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "<leader>tog", api.tree.toggle, opts("Toggle"))
end

-- Nvim-tree setup
require("nvim-tree").setup({
  on_attach = my_on_attach
})

-- Check if running in WSL
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'win32yank',
        copy = {
            ["+"] = "win32yank -i --crlf",  -- Copy to clipboard
            ["*"] = "win32yank -i --crlf",  -- Also copy to clipboard
        },
        paste = {
            ["+"] = "win32yank -o --lf",   -- Paste from clipboard
            ["*"] = "win32yank -o --lf",   -- Also paste from clipboard
        },
        cache_enabled = 0,
    }
end


