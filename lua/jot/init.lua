local utils = require("jot.utils")

local M = {}

M.config = {
  quit_key = "q",
  notes_dir = vim.fn.stdpath("data") .. "/jot",
  win_opts = {
    split = "right",
    focusable = true,
  },
}

Jot_win_id = nil

M.open = function(win_opts)
  local note_path = utils.provide_note_file(M.config)
  if note_path == nil then
    vim.api.nvim_err_writeln("Failed to create note file")
    return
  end

  if win_opts ~= nil then
    M.config.win_opts = win_opts
  end

  local buf = utils.view_file(note_path, M.config)

  if M.config.quit_key ~= nil then
    vim.api.nvim_buf_set_keymap(buf, "n", M.config.quit_key, ":q<CR>", { noremap = true, silent = true })
  end

  Jot_win_id = vim.api.nvim_get_current_win()
end

M.toggle = function(win_opts)
  if Jot_win_id ~= nil and vim.api.nvim_win_is_valid(Jot_win_id) then
    vim.api.nvim_win_close(Jot_win_id, true)
    Jot_win_id = nil
  else
    M.open(win_opts)
  end
end

M.setup = function(config)
  M.config = vim.tbl_extend("force", M.config, config or {})
end

return M
