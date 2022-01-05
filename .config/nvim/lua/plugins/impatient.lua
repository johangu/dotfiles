local log_error = require'utils'.log_error
local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  log_error('Plugin', 'Failed to load impatient')
  return
end

impatient.enable_profile()
