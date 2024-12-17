return {
  dir = '~/dev/kiwi.nvim',
  url = 'serenevoid/kiwi.nvim',
  keys = {
    { '<leader>ww', ':lua require(\'kiwi\').open_wiki_index()<cr>', desc = 'Open Wiki index' },
    { '<leader>tt', ':lua require(\'kiwi\').todo.toggle()<cr>', desc = 'Toggle Markdown Task' }
  },
  dev = true,
  lazy = true
}
