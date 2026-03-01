return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    enabled = true,
    lazy = true,
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        buftypes = {},
        user_commands = true,
        lazy_load = false,
        options = {
          parsers = {
            css = true, -- enables names, hex, rgb, hsl, oklch
            hex = {
              rrggbbaa = true, -- #RRGGBBAA hex codes (not included in css preset)
              aarrggbb = true, -- 0xAARRGGBB hex codes (not included in css preset)
            },
            names = {
              lowercase = true, -- highlight `blue` and `red`
              camelcase = true, -- highlight `Blue` and `Red`
              uppercase = false, -- don't highlight `BLUE` and `RED`
              strip_digits = false, -- include `blue3` and `red4`
              custom = false,
            },
            tailwind = {
              enable = true,
              update_names = false,
            },
            sass = { enable = true, parsers = { css = true } },
          },
          display = {
            mode = "background",
            virtualtext = {
              char = "■",
              position = "eol",
              hl_mode = "foreground",
            },
          },
          always_update = false,
        },
      })
    end,
  },
}
