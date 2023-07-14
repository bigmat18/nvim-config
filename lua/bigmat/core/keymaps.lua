vim.g.mapleader = ' '

local km = vim.keymap

km.set("n", "<leader>pv", vim.cmd.Ex)

-- exit from insert mode
km.set("i", "jk", "<ESC>")

km.set("n", "n", "nzzzv")
km.set("n", "N", "Nzzzv")

-- clear search highlights
km.set("n", "<leader>nh", ":nohl<CR>")

km.set("n", "x", '_x')

-- Telescope
km.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
km.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
km.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
km.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
km.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
km.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>") -- list available help tags
