return {
  -- {
  --"dmtrKovalenko/fff.nvim",
  --  build = "cargo build --release",
  --  opts = {
  --    prompt = '> ',
  --  },
  --  keys = {
  --    {
  --      "<space>f",
  --      function()
  --        require("fff").find_files()
  --      end,
  --      desc = "Open file picker",
  --    },
  --  },
  --},
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').setup({})
          require('telescope').load_extension('fzf')
        end,
      },
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>g/', builtin.git_status, { desc = 'Telescope git status' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>m', builtin.keymaps, { desc = 'Telescope keymaps' })
      vim.keymap.set('n', '<leader>E', builtin.diagnostics, { desc = 'Telescope diagnostics' })
      vim.keymap.set('n', 'grr', builtin.lsp_references, { desc = 'Telescope LSP references' })
    end
  },
  --{
  --  'renerocksai/telekasten.nvim',
  --  config = function()
  --    require('telekasten').setup({
  --      home = vim.fn.expand("~/zkast"),
  --    })
  --    vim.keymap.set('n', '<Space>rr', '<cmd>Telekasten panel<CR>', { desc = 'telekasten panel' })
  --    vim.keymap.set('n', '<Space>rf', '<cmd>Telekasten find_notes<CR>', { desc = 'telekasten find notes' })
  --  end
  --},
}

