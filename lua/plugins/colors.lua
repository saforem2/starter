if true then
  return {}
end

return {
  {
    "neko-night/nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- { "typicode/bg.nvim", lazy = false },
  -- { "navarasu/onedark.nvim.git", name="navarasu-onedark", lazy = false },
  -- { "saforem2/glitz", lazy = false, enabled = true },
  -- { "nyoom-engineering/oxocarbon.nvim" },
  {
    "kjssad/quantum.vim",
    lazy = false,
    enabled = true,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
  },
  -- {
  --   "LazyVim/LazyVim",
  --   -- opts = {
  --   --   colorscheme = "cyberdream",
  --   -- },
  -- },
  -- { "sainnhe/sonokai" },
  -- { "tanvirtin/monokai.nvim" },
}
