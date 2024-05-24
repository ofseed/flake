vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("home_manager_switch", {}),
  desc = "Switch home-manager configuration on save",
  pattern = { vim.fs.joinpath(vim.env.HOME, ".config", "home-manager", "*") },
  callback = function()
    local success, overseer = pcall(require, "overseer")
    if not success then
      return true
    end

    if vim.tbl_isempty(vim.diagnostic.get(nil, {
      severity = vim.diagnostic.severity.ERROR,
    })) then
      overseer
        .new_task({
          cmd = "home-manager switch",
        })
        :start()
    end
  end,
})
