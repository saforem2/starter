return {
  {
    "Kurama622/profile.nvim",
    dependencies = { "3rd/image.nvim" },
    config = function()
      local comp = require("profile.components")
      local win_width = vim.o.columns
      require("profile").setup({
        avatar_path = "/home/arch/Github/profile.nvim/resources/profile.png",
        -- avatar position options
        avatar_opts = {
          avatar_width = 20,
          avatar_height = 20,
          avatar_x = math.floor((win_width - 20) / 2),
          avatar_y = 7,
          force_blank = true, -- if true, will create some blank lines (avatar_height + avatar_y)
        },

        -- git user
        user = "Kurama622",
        git_contributions = {
          start_week = 1, -- The minimum is 1
          end_week = 53, -- The maximum is 53
          empty_char = " ",
          full_char = { "", "󰧞", "", "", "" },
          fake_contributions = nil,
          cache_path = "/tmp/profile.nvim/", -- Cache the data of git contributions locally.
          cache_duration = 24 * 60 * 60, -- seconds, The cache validity period is 1 day.

          --[[
          -- If you want to fake git's contribution information,
          -- you can pass a function to fake_contributions.
          fake_contributions = function()
            local ret = {}
            for i = 1, 53 do
              ret[tostring(i)] = {}
              for j = 1, 7 do
                ret[tostring(i)][j] = math.random(0, 5)
              end
            end
            return ret
          end,
          ]]

          -- if you want to use a third-party API to fetch git contributions
          -- non_official_api_cmd = [[ curl -s "https://github-contributions-api.jogruber.de/v4/%s?y=$(date -d "1 year ago" +%%Y)&y=$(date +%%Y)" \
          --    | jq --arg start $(date -d "1 year ago" +%%Y-%%m-%%d) --arg end $(date +%%Y-%%m-%%d) \
          --    '.contributions | [ .[] | select((.date >= $start) and (.date <= $end)) ] | sort_by(.date) | (.[0].date | strptime("%%Y-%%m-%%d") | strftime("%%w") | tonumber) as $wd | map(.count) | ([range(0, $wd) ] | map(0)) + . | . as $array | reduce range(0; length; 7) as $i ({}; . + {($i/7+1 | tostring): $array[$i:$i+7] })' ]],
        },
        hide = {
          statusline = true,
          tabline = true,
        },

        disable_keys = { "h", "j", "k", "<Left>", "<Right>", "<Up>", "<Down>", "<C-f>" }, -- disable some mappings. (You can use it to disable cursor movement)
        cursor_pos = { 0, 0 }, -- set cursor position

        -- Customize the content to render
        format = function()
          -- render avatar
          comp:avatar()
          -- customize text component
          comp:text_component_render({
            comp:text_component("git@github.com:Kurama622/profile.nvim", "center", "ProfileRed"),
            comp:text_component("──── By Kurama622", "right", "ProfileBlue"),
          })
          comp:separator_render()

          -- Custom card component, render git repository by default
          comp:card_component_render({
            type = "table",
            content = function()
              return {
                {
                  title = "kurama622/llm.nvim",
                  description = [[LLM Neovim Plugin: Effortless Natural Language Generation with LLM's API]],
                },
                {
                  title = "kurama622/profile.nvim",
                  description = [[A Neovim plugin: Your Personal Homepage]],
                },
              }
            end,
            hl = {
              border = "ProfileYellow",
              text = "ProfileYellow",
            },
          })
          comp:separator_render()

          -- git contributions, Considering network latency, the module will render asynchronously.
          -- you can also configure `fake_contributions`, so it won't fetch data from the Github
          comp:git_contributions_render("ProfileGreen")
        end,
      })
      vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Profile<cr>", { silent = true })
    end,
  },
  {
    "3rd/image.nvim",
    dependencies = {
      "leafo/magick",
    },
    config = function()
      require("image").setup({
        backend = "ueberzug",
        -- backend = "kitty",
        kitty_method = "normal",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = true,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        -- window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      })
    end,
  },
}
