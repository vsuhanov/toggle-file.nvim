local M = {}
function M.toggle_file_window(filename)
  local absolute_path = vim.fn.fnamemodify(filename, ':p')
  local bufnr = vim.fn.bufnr(absolute_path)
  local win_found = false

  -- Convert full path to relative path to match window buffer names

  -- Close the window if the current buffer matches the filename and there's more than 1 window
  if vim.api.nvim_get_current_buf() == bufnr and #vim.api.nvim_list_wins() > 1 then
    vim.api.nvim_win_close(0, true)
    return
  end

  -- Search for the window that already has the buffer open
  for _, win_id in pairs(vim.api.nvim_list_wins()) do
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

return M
