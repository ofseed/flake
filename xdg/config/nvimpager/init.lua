---@diagnostic disable-next-line: undefined-global
local nvimpager = nvimpager

nvimpager.maps = false

vim.keymap.set("n", "q", function()
  vim.cmd.quitall { bang = true }
end)
