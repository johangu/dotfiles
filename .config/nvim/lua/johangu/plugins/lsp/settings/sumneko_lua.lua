local opts = {
  settings = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of Neovim
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      completion = {
        keywordSnippet = "Replace",
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = { 'vim' } -- Get the language server to recognize the `vim` global
      },
      telemetry = { enable = false },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true
        }
      }
    }
  }
}

return opts
