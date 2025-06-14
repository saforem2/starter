return {
  -- For `plugins/markview.lua` users.
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,

    -- For blink.cmp's completion
    -- source
    dependencies = {
      "saghen/blink.cmp",
    },
  },
}
