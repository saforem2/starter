return {
  {
    "ptdewey/yankbank-nvim",
    dependencies = "kkharji/sqlite.lua",
    keys = {
      { "<leader>Y", "<cmd>YankBank<cr>", desc = "Yank Bank" },
    },
    opts = {
      persist_type = "sqlite",
    },
  },
}
