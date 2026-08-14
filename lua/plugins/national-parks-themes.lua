return {
  "pjhamera/national-parks-themes",
  lazy = false,
  priority = 1000,
  config = function()
    require("parks").setup()
    vim.cmd.colorscheme("parks-crater-lake")
  end,
}
