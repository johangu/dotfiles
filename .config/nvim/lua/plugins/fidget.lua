vim.pack.add {
  {
    src = "https://github.com/j-hui/fidget.nvim.git",
    name = "fidget"
  }
}

require('fidget').setup({
  progress = {
    display = {
      progress_icon = {
        pattern = "arc",
        period = 1,
      },
    },
  },
  notification = {
    window = {
      winblend = 0,
    },
  },
})

