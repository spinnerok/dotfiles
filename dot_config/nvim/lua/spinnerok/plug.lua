-- Bootstrap vim-plug plugin manager
local function bootstrap_plug()
  -- Construct path to vim-plug autoload file
  local plug_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"

  -- Check if vim-plug is already installed
  if not (vim.uv or vim.loop).fs_stat(plug_path) then
    -- Download vim-plug if not present
    vim.fn.system({
      "curl",
      "-fLo",
      plug_path,
      "--create-dirs",
      "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
    })
  end

  -- Add vim-plug to runtime path
  vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")
end

-- Initialize vim-plug
bootstrap_plug()

-- Create shorthand for vim-plug's Plug command
local Plug = vim.fn["plug#"]

-- Begin plugin declarations
vim.call("plug#begin")

-- Plenary: Lua utility functions used by other plugins, required by Telescope
Plug("nvim-lua/plenary.nvim")
-- Telescope: Fuzzy finder for files, buffers, etc.
Plug("nvim-telescope/telescope.nvim", { tag = "0.2.0" })
-- Color schemes: Various theme options for syntax highlighting and UI
Plug 'ellisonleao/gruvbox.nvim'        -- Gruvbox theme (Lua port)
Plug 'darianmorat/gruvdark.nvim'       -- Gruvbox dark variant
Plug 'sainnhe/everforest'              -- Everforest theme with multiple palettes
Plug 'sainnhe/gruvbox-material'        -- Gruvbox Material theme variant

-- Treesitter: Advanced syntax highlighting and code understanding
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Undotree: Visualize and navigate undo history as a tree
Plug 'mbbill/undotree'

-- Finalize plugin declarations
vim.call("plug#end")
