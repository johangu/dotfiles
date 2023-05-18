local keymap = require'utils'.map

keymap('n', '<leader>aa', ' :A<CR>')
keymap('n', '<leader>as', ' :Emock<CR>')

vim.g.projectionist_heuristics = {
    -- nodejs
    ['package.json'] = {['package.json'] = {type = 'config'}},
    ['jest.config.js'] = {['jest.config.js'] = {type = 'config'}},
    ['*.js'] = {
        ['*.js'] = {
            alternate = {'__tests__/{}.test.js', '__mocks__/{}.js'},
            console = 'node {file}',
            type = 'src'
        },
        ['__tests__/*.test.js'] = {
            alternate = '{}.js',
            console = 'jest {file}',
            type = 'test'
        },
        ['__mocks__/*.js'] = {
            alternate = '{}.js',
            type = 'mock',
            related = '{}.js'
        }
    },

    -- python
    ['*.py'] = {
        ['*.py'] = {
            alternate = 'test_{basename}.py',
            console = 'python {file}',
            type = 'source'
        },
        ['test_*.py'] = {
            alternate = '{basename}.py',
            console = 'pytest {file}',
            type = 'test'
        }
    }
}
