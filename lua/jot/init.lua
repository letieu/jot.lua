local utils = require("jot.utils")

local M = {}

M.config = {
  quit_key = "q",
  notes_dir = vim.fn.stdpath("data") .. "/jot",
  win_opts = {
    split = "right",
    focusable = false,
  },
}

Jot_win_id = nil

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

  Jot_win_id = vim.api.nvim_get_current_win()
end

M.toggle = function()
  if Jot_win_id ~= nil and vim.api.nvim_win_is_valid(Jot_win_id) then
    vim.api.nvim_win_close(Jot_win_id, true)
    Jot_win_id = nil
  else
    M.open()
  end
end

M.setup = function(config)
  M.config = vim.tbl_extend("force", M.config, config or {})
end

return M
