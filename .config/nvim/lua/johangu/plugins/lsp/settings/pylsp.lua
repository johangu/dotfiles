return {
  pylsp = {
    plugins = {
      ruff = { enabled = true },
      pyflakes = { enabled = false },
      pylsp_mypy = { enabled = true },
      pyls_isort = { enabled = true },
    },
  },
}
