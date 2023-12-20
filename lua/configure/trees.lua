local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('Up'))
end


local opts = { noremap = true, silent = true }


return {
    require("symbols-outline").setup(),
    require("nvim-tree").setup{
       on_attach = my_on_attach,
    },
    vim.api.nvim_set_keymap("n", '<S-F1>', ':NvimTreeToggle<Enter>', opts),
    vim.api.nvim_set_keymap("n", '<S-F2>', ':SymbolsOutline<Enter>', opts),
}
