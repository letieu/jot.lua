local Path = require("plenary.path")

local M = {}

---@param file_path string
---@param config table
---@return number
M.view_file = function(file_path, config)
  local note_buf = vim.api.nvim_create_buf(false, true)

  if vim.version()["minor"] > 9 then
    vim.api.nvim_open_win(note_buf, true, config.win_opts)
    vim.cmd("edit " .. file_path)
  else
    vim.cmd("vsplit " .. file_path)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, note_buf)
  end

  -- close buffer when window is closed
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = note_buf })

  -- set buffer options to make it writable
  vim.api.nvim_set_option_value("buftype", "", { buf = note_buf })

  return note_buf
end

---@param path string
---@return string
M.path_to_filename = function(path)
  local sep = Path:new(path)._sep
  local new_sep = "_"
  local file_ext = ".md"
  local filename = path:gsub(sep, new_sep)
  return filename .. file_ext
end

---@param config table
---@return string | nil
M.provide_note_file = function(config)
  local notes_dir = Path:new(config.notes_dir)
  local cwd = vim.loop.cwd()
  if cwd == nil then
    return
  end

  local note_name = M.path_to_filename(cwd)
  local note_path = notes_dir:joinpath(note_name)

  if not note_path:is_file() then
    note_path:touch({ parents = true })
  end

  return note_path:normalize(cwd)
end

return M
