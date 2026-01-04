local treesitter = require('nvim-treesitter')

local parsers = {
  'bash',
  'diff',
  'git_rebase',
  'gitcommit',
  'hcl',
  'java',
  'javascript',
  'json',
  'kotlin',
  'lua',
  'markdown_inline',
  'markdown',
  'python',
  'query',
  'regex',
  'rust',
  'swift',
  'toml',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

treesitter.install(parsers)
