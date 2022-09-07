local M = {}

if pcall(require, "notifyy") then
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

local default = {
  port = 'auto',
  host = 'auto',
  browser = 'auto',
  no_browser = false,
}

local liveServer = "live-server "
local Port = nil
local Host = nil
local Browser = nil
local No_browser = ""
-- local Pconf = false



-- P(default)

-- file = vim.fn.expand("%:p")
function M.setup(opts)
  if opts then
    opts = opts
    -- Pconf = true
  else
    opts = default
  end

  P(opts)

  local function getOpts()
    -- if Pconf == true then
    if opts.browser == 'auto' then
      print("Browser default")
      Browser = ""
    elseif opts.browser ==  nil then
      print("Browser default 0.0.0.0")
      -- return
    else
      Browser = "--browser=" .. opts.browser .. " "
    end
    if opts.port == nil then
      print("Port default")
      Port = ""
    elseif opts.port == '8080' or "auto" then
      print("Port Default 8080")
      Port = ""
    else
      Port = "--port=" .. opts.port .. " "
    end
    if opts.no_browser == true then
      No_browser = "--no-browser "
    else
      print("No browser")
      No_browser = ""
    end
    if Host == nil then
      print("nil host")
      if opts.host == 'auto' then
        print('auto host')
        Host = ""
      elseif opts.host == '0.0.0.0' then
        print("0 host")
        Host = ""
      else
        Host = "--host=" .. opts.host .. " "
      end
    end

    Prueba = liveServer .. Host .. No_browser .. Port .. Browser
    -- else
    -- Prueba = liveServer
    -- print("Pconf: False")
    -- end
  end

  getOpts()

  ComandoFinal = Prueba
  -- print("a"..Host)
  print("comando final " .. "'" .. ComandoFinal .. "'")

  -- local Terminal = require('toggleterm.terminal').Terminal
  -- if M.current == nil then
  --   M.current = Terminal:new({
  --     dir = "%:p:h",
  --     cmd = ComandoFinal,
  --     hidden = true,
  --     on_open = function() Terminal:set_mode("n") end,
  --     on_exit = function() Notify('Server Closed', 'error') end
  --   })
  --   Notify('Server Start', 'info')
  --   M.current:toggle()
  -- else
  --   M.current:toggle()
  -- end
end

M.setup()

function M.server_toggle()
  if M.verifi == false then
    Notify('toggle == false')
  else
    if M.current == nil then
      M.setup()
    end
    M.current:toggle()
  end
end

return M
