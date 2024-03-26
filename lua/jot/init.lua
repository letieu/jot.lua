local utils = require("jot.utils")

local M = {}

M.config = {
  quit_key = "q",
  notes_dir = vim.fn.stdpath("cache") .. "/jot",
  win_opts = {
    split = "right",
    focusable = false,
  },
}

M.open = function()
  local note_path = utils.provide_note_file(M.config)
  if note_path == nil then
    vim.api.nvim_err_writeln("Failed to create note file")
    return
  end

  local buf = utils.view_file(note_path, M.config)

  if M.config.quit_key ~= nil then
    vim.api.nvim_buf_set_keymap(buf, "n", M.config.quit_key, ":q<CR>", { noremap = true, silent = true })
  end
end

M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

return M
