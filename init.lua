require "keymaps"
require "options"
require "lazy-config"

-- Disable unnecessary built-ins to improve startup time
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
  vim.keymap.set("n", "<C-n>", api.tree.toggle, opts("Toggle"))
end

-- Nvim-tree setup
require("nvim-tree").setup({
  on_attach = my_on_attach
})
