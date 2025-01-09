local function load_config(path)
  local ok, config = pcall(dofile, path)
  if ok then
    return config
  else
    print("Nie udało się załadować pliku: " .. path)
    return {}
  end
end

-- Ładujemy konfigurację domyślną
local default_config = load_config(vim.fn.stdpath("config") .. "/config/default.lua")

-- Ładujemy konfigurację użytkownika (jeśli istnieje)
local user_config = load_config(vim.fn.stdpath("config") .. "/config/user.lua")

-- Scalamy konfigurację użytkownika z domyślną, dając priorytet użytkownikowi
local config = vim.tbl_deep_extend("force", default_config, user_config or {})

-- Ustawienia Neovim (przykład)
vim.opt.number = config.number or true
vim.opt.relativenumber = config.relativenumber or false
vim.opt.tabstop = config.tabstop or 4
vim.opt.shiftwidth = config.shiftwidth or 4

-- Mapowania klawiszy
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Zapisz plik" })

-- Ładowanie pluginów
local function load_plugins()
  local plugins = {}
  local plugins_path = vim.fn.stdpath("config") .. "/lua/custom/plugins/"

  for _, plugin_file in ipairs(vim.fn.readdir(plugins_path)) do
    if string.match(plugin_file, "%.lua$") then
      local plugin_name = string.match(plugin_file, "(.-)%.lua")
      local plugin_path = plugins_path .. plugin_file

      local plugin_config = load_config(plugin_path)

      -- Sprawdzamy, czy użytkownik włączył plugin
      if config.plugins and config.plugins[plugin_name] then
        if plugin_config then
          table.insert(plugins, plugin_config)
        else
          print("Błąd: Niepoprawna konfiguracja pluginu: " .. plugin_path)
        end
      end
    end
  end
  return plugins
end

-- Ładujemy i konfigurujemy pluginy
local plugins = load_plugins()

-- Inicjalizacja pakietu lazy
local lazy = require("lazy")
lazy.setup(plugins, {
  install = { missing = true }, -- Automatically install missing plugins
  checker = { enabled = false }, -- Disable automatic plugin updates
  performance = {
    rtp = {
      disabled_plugins = { "tohtml", "gzip", "tarPlugin", "matchit", "zipPlugin", "netrwPlugin" },
    },
  },
})

-- Opcjonalnie, konfiguracja colorscheme
if config.colorscheme then
  vim.cmd("colorscheme " .. config.colorscheme)
end

