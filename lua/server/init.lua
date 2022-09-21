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

M.verifi = true
local tog = pcall(require, "toggleterm")
local lv = vim.fn.executable("live-server")

function M.verif()
  if not tog then
    Notify('Core need ToogleTerm to work, pls install it ( https://github.com/akinsho/toggleterm.nvim )', 'error')
    M.verifi = false
  end
  if lv == 0 then
    Notify('Core need Live Server to work, pls install it ( npm install -g live-server )', 'error')
    M.verifi = false
  end
end

M.verif()

M.current = nil
local liveServer = "live-server "
local No_browser = ""
local Port = ""
local Pconf = false
local default = {
  port = '8080',
  no_browser = false,
}

function M.setup(opts)
  if opts then
    opts = opts
    Pconf = true
  else
    opts = default
  end

  local function getOpts()
    if Pconf == true then
      if opts.port == "" then
        Port = ""
      elseif opts.port == nil then
        Port = ""
      else
        Port = "--port=" .. opts.port .. " "
      end
      if opts.no_browser == true then
        No_browser = "--no-browser" .. " "
      else
        No_browser = ""
      end
      Command = liveServer .. No_browser .. Port
    else
      Command = liveServer
    end
  end
  getOpts()
  ComandoFinal = Command
end

function M.run()
  local Terminal = require('toggleterm.terminal').Terminal
  if M.current == nil then
    M.current = Terminal:new({
      dir = "%:p:h",
      cmd = ComandoFinal,
      hidden = true,
      on_open = function() Terminal:set_mode("n") end,
      on_exit = function() Notify('Server Closed', 'error') end
    })
    Notify('Server Start', 'info')
    M.current:toggle()
  else
    M.current:toggle()
  end
end
function M.server_toggle()
  if M.verifi == false then
    Notify('Please check dependencies in README.md', 'warn')
  else
    if M.current == nil then
      M.setup()
    end
    M.current:toggle()
  end
end

return M
