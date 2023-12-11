local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'awk',
    'bash',
    'c',
    'cmake',
    'cpp',
    'csv',
    'diff',
    'dot',
    'fish',
    'git_config',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'gosum',
    'html',
    'java',
    'javascript',
    'jq',
    'lua',
    'json',
    'jsonnet',
    'make',
    'markdown',
    'markdown_inline',
    'mermaid',
    'php',
    'python',
    'ruby',
    'rust',
    'scala',
    'sql',
    'toml',
    'tsv',
    'typescript',
    'vim',
    'twig',
    'xml',
    'yaml',
    'zig'
  },
  autotag = {
    enable = true,
  }
}
