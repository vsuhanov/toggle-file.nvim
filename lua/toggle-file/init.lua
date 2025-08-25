local M = {}
local default_opts = {
  tab_local = true
}

local data_path = vim.fn.stdpath('data') .. '/toggle-file'
vim.fn.mkdir(data_path, 'p')
function M.remember_file(filepath)
  if filepath == '' or filepath == nil then
    filepath = vim.api.nvim_buf_get_name(0)
  end

  local absolute_path = vim.fn.fnamemodify(filepath, ':p')
  local remember_file = data_path .. '/remembered-file-path'

  local file = io.open(remember_file, 'w')
  if file then
    file:write(absolute_path)
    file:close()
  end
end

function M.get_remembered_file()
  local remember_file = data_path .. '/remembered-file-path'
  local file = io.open(remember_file, 'r')
  if file then
    local filepath = file:read('*all')
    file:close()
    return filepath
  end
  return nil
end

function M.toggle_file_window(filename, opts)
  opts = vim.tbl_deep_extend('force', default_opts, opts or {})

  local absolute_path = vim.fn.fnamemodify(filename, ':p')
  local bufnr = vim.fn.bufnr(absolute_path)
  local win_found = false

  if vim.api.nvim_get_current_buf() == bufnr and #vim.api.nvim_list_wins() > 1 then
    vim.api.nvim_win_close(0, true)
    return
  end

  -- Search for the window that already has the buffer open
  local windows = (opts.tab_local and vim.api.nvim_tabpage_list_wins(0)) or vim.api.nvim_list_wins()
  for _, win_id in pairs(windows) do
    local win_bufnr = vim.api.nvim_win_get_buf(win_id)
    if win_bufnr == bufnr then
      win_found = true
      vim.api.nvim_set_current_win(win_id)
      break
    end
  end

  -- If window is not found, open it to the right
  if not win_found then
    vim.cmd('rightbelow vsplit ' .. filename)
  end
end

vim.api.nvim_create_user_command("ToggleFileMemorize", function()
  M.remember_file()
end, {})

vim.api.nvim_create_user_command("ToggleFileToggleMemorized", function()
  M.toggle_file_window(M.get_remembered_file())
end, {})
return M
