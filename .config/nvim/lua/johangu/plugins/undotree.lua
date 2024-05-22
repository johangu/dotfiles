return {
  'jiaoshijie/undotree',
  keys = { { '<leader>u', function() require 'undotree'.toggle() end, desc = 'Toggle [U]ndotree' } },
  config = true
}
