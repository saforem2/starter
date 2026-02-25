return {
  "Rtarun3606k/TakaTime",
  lazy = true,
  event = "VeryLazy",
  config = function()
    -- Optional: Enable debug mode if you run into issues
    require("taka-time").setup({
      debug = false,
    })
  end,
}
