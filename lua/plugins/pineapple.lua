if true then
  return {}
end
return {
  {
    "CWood-sdf/pineapple",
    dependencies = require("colors.pineapple"),
    opts = {
      installedRegistry = "YOUR_LUA_DIRECTORY.pineapple",
      colorschemeFile = "after/plugin/theme.lua",
    },
    cmd = "Pineapple",
  },
}
