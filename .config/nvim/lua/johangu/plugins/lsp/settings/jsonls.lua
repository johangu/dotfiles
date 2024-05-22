return {
  settings = {
    json = {
      format = { enable = false },
      validate = { enable = true },
      schemas = require 'schemastore'.json.schemas()
    }
  }
}
