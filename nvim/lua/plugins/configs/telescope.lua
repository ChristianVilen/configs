local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { 
      "node_modules",
      ".git",
      "dist", 
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes", "terms" },
  hidden = true,
  pickers = {
    find_files = {
      hidden = true,
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob", "!**/.git/*",
        "--glob", "!**/node_modules/*",
        "--glob", "!**/.idea/*",
        "--glob", "!**/.zed/*",
        "--glob", "!**/.mypy_cache/*",
        "--glob", "!**/.pytest_cache/*",
        "--glob", "!**/.next/*",
        "--glob", "!**/*.png",
        "--glob", "!**/*.jpg",
        "--glob", "!**/*.jpeg",
        "--glob", "!**/*.gif",
        "--glob", "!**/*.svg",
        "--glob", "!**/*.webp",
        "--glob", "!**/*.ico",
      },
    },
    live_grep = {
      additional_args = function()

      return {
      "--hidden",
      "--glob", "!**/.git/*",
      "--glob", "!**/node_modules/*",
      "--glob", "!**/*.png",
      "--glob", "!**/*.jpg",
      "--glob", "!**/*.jpeg",
      "--glob", "!**/*.gif",
      "--glob", "!**/*.svg",
    }
  end,
}
  }
}

return options
