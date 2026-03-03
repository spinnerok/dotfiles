return {
  {
    "ellisonleao/gruvbox.nvim",
  },
  {
    "sainnhe/gruvbox-material",        -- Gruvbox Material theme variant
  },
  {
    "Mofiqul/vscode.nvim",             -- VSCode theme with light and dark variants
  },
  {
    "folke/tokyonight.nvim",        -- Tokyo Night theme with multiple styles
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme "vscode"
    end
  },
}
