-- Configure lua_ls with enhanced settings
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }, -- Recognize 'vim' global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Enable lua_ls if available
if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.enable('lua_ls')
else
  vim.notify('lua-language-server not found', vim.log.levels.WARN)
end
