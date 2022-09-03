local M = {}

if pcall(require, "notify") then
  function Notify(text, type, opts)
    Plugin = 'LiveServer.nvim'
    require("notify")(text, type, { title = Plugin, opts })
  end
else
  function Notify(msg)
    vim.notify_once(msg, vim.log.levels.WARN)
  end
end

M.verifi = false

function M.verif()
  if pcall(require, "toggleterm") then
   M.verifi = true
  else
    Notify('Core need ToogleTerm to work, pls install it ( https://github.com/akinsho/toggleterm.nvim )')
  end
end

M.verif()

M.current = nil

function M.server()
  if M.verifi == false then
    Notify('server = false')
  else
    local Terminal = require('toggleterm.terminal').Terminal
    if M.current == nil then
      M.current = Terminal:new({
        cmd = "live-server",
        dir = '%:p:h',
        hidden = true,
        on_open = function() Terminal:set_mode("n")  end,
        on_exit = function() Notify('Consola Cerrada', 'error') end
      })
      Notify('Consola Iniciada', 'info')
      M.current:toggle()
    else
      M.current:toggle()
    end
  end
end

function M.server_toggle()
if M.verifi == false then
  Notify('toggle == false')
else
  if M.current == nil then
    M.server()
  end
  M.current:toggle()
end
end

return M
