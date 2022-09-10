## core.nvim

![screenshot](https://user-images.githubusercontent.com/56775416/189454870-8135684a-c97f-4476-aa95-dd9ca4843cdb.gif)

## Requirements

- [ToggleTerm](https://github.com/akinsho/toggleterm.nvim)
- Live-server `npm install live-server`

## Instalation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use 'dylanfierro/core.nvim'
```

Using [plug](https://github.com/junegunn/vim-plug)
```lua
Plug 'dylanfierro/core.nvim'
```

## Usage
```lua
require('server').setup()
```
- `:ServerRun` Start Server
- `:ServerToggle` Show/Hide console

**Avaliable options**
```lua
require('server').setup({
  port = 'number', -- select port to use, default: PORT env var or 8080
  no_browser = boolean, -- true = suppress automatic web browser launching
})
```

**Example setup**

```lua
require('server').setup({
  port = '5555', -- open server in port 5555
  no_browser = true, -- No open browser
 })
 ```
 
 ### ToDo

- [x] Custom Port
- [x] Enable/disable auto open browser
- [ ] Select Browser
- [ ] Custom Host
- [ ] Enable/Disable log message
