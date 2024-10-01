local opts = {
  ensure_installed = {
    'c',
    'lua',
    'vim',
    'vimdoc',
    'javascript',
    'typescript',
    'json',
    'html',
    'css',
    'scss',
    'yaml',
    'python',
    'rust',
    'go',
    'bash',
    'dockerfile',
    'graphql',
    'apex',
    'java',
    'c_sharp',
    'angular',
    'sql',
    'query',
    'markdown',
    'markdown_inline',
  },
}

local function config()
  require('nvim-treesitter.configs').setup(opts)
end
return {
  'nvim-treesitter/nvim-treesitter',
  config = config,
  build = ':TSUpdate',
}
