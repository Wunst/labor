return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  enabled = os.getenv('THEME') == 'solarized',
  config = function ()
    require('solarized').setup{
      variant = 'autumn',
    }

    vim.cmd.colorscheme 'solarized'
  end,
}
