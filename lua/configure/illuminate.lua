



return {
  require('illuminate').configure({
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
          -- 'lsp',
          'treesitter',
      },
      -- delay: delay in milliseconds
      delay = 200,
      filetype_overrides = {},
      filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
      },
      filetypes_allowlist = {},
      modes_denylist = {},
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = false,
      large_file_cutoff = 1000,
      large_file_overrides = nil,
      min_count_to_highlight = 1,
      should_enable = function(bufnr) return true end,
      case_insensitive_regex = false,
  }),
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" }),
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" }),
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" }),
    vim.cmd("hi IlluminatedWordRead guibg=#525252"),
}
