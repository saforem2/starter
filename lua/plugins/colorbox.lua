return {
{
    "linrongbin16/colorbox.nvim",
    -- don't lazy load
    lazy = false,
    -- load with highest priority
    enabled = false,
    priority = 1000,

    build = function()
      require("colorbox").update()
    end,
    config = function()
      require("colorbox").setup()
    end,
    -- load with highest priority
    -- build = function()
    --   require("colorbox").update()
    -- end,
    -- config = function()
    --   require("colorbox").setup({ filter = false })
    -- end,
  },
}
