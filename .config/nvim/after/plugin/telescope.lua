local builtin = require('telescope.builtin')

-- File finding
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find git files' })

-- Search
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Grep search' })

vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Live grep' })

-- Buffers and help
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'Help tags' })
