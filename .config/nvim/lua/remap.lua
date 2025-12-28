-- Disable space key in normal mode to prevent default behavior
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })

-- Set space as the leader key
vim.g.mapleader = " "

-- Map <leader>pv to open netrw file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

