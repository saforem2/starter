if true then
  return {}
end

return {
  {
    "beeender/richclip.nvim",
    config = function()
      require("richclip").setup()
    end,
  },
}
