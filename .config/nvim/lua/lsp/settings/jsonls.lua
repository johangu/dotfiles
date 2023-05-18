local u = require 'utils'
local status_ok, schemastore = pcall(require, 'schemastore')
if not status_ok then
  u.log_error('Require', 'Failed to load schemastore')
  return
end

return {
  settings = {
    json = {
      format = { enable = false },
      schemas = schemastore.json.schemas()
    }
  }
}
