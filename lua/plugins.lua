-- Bootstrap de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lista de plugins
require("lazy").setup({
  { "nvim-lua/plenary.nvim" },

--------------------------------------------------------------------------------python Plugins
---------------------------------------Gestion de servidores LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
      })

      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})
    end,
  },
-------------------------------------------------Autocompletado
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- fuente de autocompletado desde LSP
      "hrsh7th/cmp-buffer",   -- autocompletado desde el buffer actual
      "hrsh7th/cmp-path",     -- autocompletado de rutas
      "L3MON4D3/LuaSnip",     -- snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter confirma
          ["<Tab>"] = cmp.mapping.select_next_item(),        -- Tab avanza
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),      -- Shift+Tab retrocede
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
-----------------------------------------------Conform.nvim
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" }, -- usa black para Python
        },
      })

    -- Formatear automáticamente al guardar
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
-----------------------------------------------------------------nvim-lint
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "flake8" }, -- usa flake8 para Python
      }

    -- Ejecutar linting al guardar o salir de inserción
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
-----------------------------------------------------------------nvim-Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- integración con treesitter
        fast_wrap = {},  -- envoltura rápida con teclas
      })

    -- Integración con nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

------------------------------------------------------------------------------------------PLugins Java(Proximamente)




------------------------------------------------------------------------------------------Plugins C++


------------------------------------------------------------------------------------------Plugins Leche(Proximo lenguaje), Bases de datos






-------------------------En el menu el de buscar esta aqui (Necesita arreglos | carpeta no dirige al homeo)
   {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          cwd = "/home/leche", -- inicia en tu carpeta personal
          hidden = false,      -- no mostrar ocultos
          file_ignore_patterns = {
            "^%.config/",   -- oculta la carpeta .config
            "^%.local/",    -- oculta la carpeta .local
            "^%.icons/",    -- oculta la carpeta .icons
            "%.git/",       -- oculta repos git
            "node_modules", -- oculta node_modules
            "__pycache__",  -- oculta caches de Python
          },
        },
      })

      vim.keymap.set("n", "<leader>ff", function()
        require("telescope.builtin").find_files({
          cwd = "/home/leche",
          hidden = false,
        })
      end, { desc = "Buscar archivos en /home/leche" })
    end,
  },


-----------------------------------------------------------------Actualizaciones automáticamente (Si lo quitas, GG)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if ok then
        ts.setup({
          ensure_installed = { "lua", "python", "javascript" },
          highlight = { enable = true },
        })
      end
    end,
  },
-----------------------------------------------------------------------Temas
  --{
    --"folke/tokyonight.nvim",
    --config = function()
      --vim.cmd.colorscheme("tokyonight")
    --end,
  --},
----------------------------------------------
  {
    "Mofiqul/dracula.nvim",
    config = function()
      require("dracula").setup({
        colors = {
          bg = "#1a0f1f", -- tu violeta oscuro personalizado
        },
        transparent_bg = false,
        italic_comment = true,
      })
      vim.cmd.colorscheme("dracula")
    end,
  },
------------------------------------------------------------------------Porta 

  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Banner personalizado (No quiten el Banner)
      dashboard.section.header.val = {
        "██╗     ███████╗ ██████╗██╗  ██╗███████╗██╗   ██╗██╗███╗   ███╗",
        "██║     ██╔════╝██╔════╝██║  ██║██╔════╝██║   ██║██║████╗ ████║",
        "██║     █████╗  ██║     ███████║█████╗  ██║   ██║██║██╔████╔██║",
        "██║     ██╔══╝  ██║     ██╔══██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
        "███████╗███████╗╚██████╗██║  ██║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚══════╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                         Version 0.2 🚀",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣛⣥⣮⣭⣛⡛⠿⣿⣿⣿⣿⡙⢿⣿⡿⢟⣣⣴⣶⣭⡻⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣛⣭⣶⣿⠿⣛⣛⣛⣛⣛⣓⣂⣻⠿⠿⠿⠆⣩⣴⣿⣿⣿⣿⣿⣿⣌⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣴⣿⣿⣿⣿⣿⠈⡻⣿⣿⣿⣿⣿⣿⣿⡛⠂⠟⠃⣉⡙⠛⣛⡛⠿⣛⣛⣁⣒⡲⠦⢭⣙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣴⣿⣿⣿⣿⣿⡿⢟⣡⣬⣿⣿⣭⣭⣭⣉⡁⢂⣋⣭⣭⣌⣛⣃⣴⣶⣿⣿⣿⣿⣿⣿⣿⣶⣦⣝⡲⢌⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⣾⣿⣿⣿⣿⠟⣩⣴⣿⣿⣿⣿⣿⣿⡿⢟⣥⣾⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣯⣭⣝⣛⠻⠿⣿⣿⣷⣮⣤⣀⣀⠉⠉⠛⠛⠛⠛⣡⣾⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣱⣿⣿⣿⣿⠟⣡⣾⣿⣿⣿⣿⣿⣿⡿⢛⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣷⣦⣙⠻⣷⡍⠻⠿⠿⠿⢛⠋⢥⣾⣿⣿⣿⣿",
        "⣿⣿⣏⠻⢿⣿⣿⡿⠟⣴⣿⣿⣿⡿⢡⣾⣿⣿⣿⣿⣿⣿⣿⠟⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⢿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡙⢶⡦⡘⢿⣿⣿⣶⣬⣝⣛⢻⣿",
        "⣿⣿⣿⣷⢢⣤⣽⢃⣸⣿⢞⣿⠏⣴⣿⣿⣿⣿⣿⣿⣿⣿⠇⢊⣿⣿⣿⣿⣿⣿⣿⡟⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⡿⢿⣿⣿⡿⢿⣦⡙⢮⡢⡙⢿⣿⣿⠟⣋⣼⣿",
        "⣿⣿⣿⣿⣧⠛⠡⣲⣿⣷⡾⢃⣼⣿⣿⣿⣿⣿⣿⣿⡿⠁⣰⢿⡿⣿⣿⣿⣿⣿⡿⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠙⠁⠹⣿⣿⡎⠜⣇⢻⡌⠌⣿⣿⡌⢿⣮⡲⠄⠰⣾⣿⣿⣿",
        "⣿⣿⣿⡋⠁⡐⣱⠿⢛⣩⣴⣿⣿⣿⣿⣿⣿⣿⠿⡋⡀⣰⣿⢏⣾⡿⣿⣿⣿⣿⢁⣿⢡⣿⣿⠛⣿⣿⣿⣿⣿⡇⣤⡴⢆⢹⠘⣷⣶⣿⠘⣿⡆⣿⣿⣿⡌⢿⣿⣷⣤⣈⠙⠛⠿",
        "⣿⣿⣿⡥⡐⣸⠀⢤⣶⣶⣶⣶⣶⣶⠠⢶⣶⣶⠏⡔⣴⣿⣿⣾⡿⢡⣿⣿⣿⡇⣼⣿⢀⣿⡏⢰⢿⣿⣿⣿⣿⡇⣿⣿⣌⡘⡇⢹⣿⣿⡇⣿⣿⠸⣿⣿⣷⠸⣿⣿⣿⣿⣿⡿⠟",
        "⣿⣿⣿⠐⢰⣿⣿⣶⣬⣭⣭⣍⢋⣩⠉⡅⣡⠈⠌⣼⣿⣿⣿⣿⢃⣿⣿⣿⣿⢁⣿⣿⢸⣿⠁⠘⠈⣿⣿⣿⠏⡇⣿⣿⣿⣇⠃⠀⣛⡉⠀⠙⣿⢠⢹⡟⢿⡇⡉⣍⢡⣤⣴⣶⣿",
        "⣿⣿⢇⣴⣿⣿⣿⣿⣿⣿⣿⢃⣾⠏⠀⣷⢀⣠⣾⣿⣿⣿⣿⡏⣼⣿⣿⣿⣿⢸⣿⣿⠘⡿⠀⠀⢀⢨⣿⣿⢀⠁⣿⣿⣿⣿⢠⠀⣿⠃⢀⡆⣿⠸⢸⣿⢸⡇⡇⠘⣆⢻⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡿⢰⡏⣾⢃⡆⡆⣡⣾⣿⣿⣿⣿⣿⣿⢰⣿⣿⣿⣿⣿⠘⣿⢹⢀⢰⡀⣧⠸⣦⠹⣿⠸⡄⢻⣿⣿⣿⣾⡇⡟⠀⣼⠃⢃⠀⠀⡇⠈⠇⣿⡄⠹⡌⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⡿⠁⡜⣸⢃⡾⢃⣼⣿⣿⣿⣿⣿⣿⣿⡏⣼⣿⣿⣿⣿⣿⠀⠹⠘⢸⣀⠃⡿⣦⣿⣷⣌⣃⢹⣾⣿⣿⣿⣿⡇⠀⠊⠀⠀⠈⠘⠀⢡⡇⢸⣿⣷⠀⢳⠘⣿⣿",
        "⣿⣿⣿⣿⡿⢿⡿⢡⡇⠇⢉⣠⣾⣿⣿⠿⠿⠟⠛⡋⣭⢸⡇⣿⣿⣿⣿⣿⣿⢠⡁⢰⣌⣿⠗⠁⠃⠒⠶⠄⢹⣿⣿⣿⣿⣿⣿⣷⠀⠀⠸⢿⢦⠀⠀⢘⣧⣿⣿⣿⣇⠈⣧⢹⣿",
        "⣿⣿⣿⣿⢡⣿⢇⣾⣷⡆⣰⣶⣷⢂⢲⡆⣿⣿⢀⢱⡇⣾⡇⣿⣿⣿⣿⣿⣿⢸⠟⡶⠋⠀⠀⠀⢀⣶⣦⣘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠐⡆⢸⢀⡄⢸⣿⣿⣿⣿⣿⡆⢹⡆⣿",
        "⣿⣿⣿⠇⣾⡏⣼⣿⡏⢰⣿⣿⢃⣾⡈⣷⢸⡏⠈⣾⡇⣿⣧⣿⣿⣿⣿⣿⣿⠀⡭⠁⢠⠀⣠⠄⠀⣭⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢰⣴⡇⢸⣿⡇⢸⣿⣿⣿⣿⡿⣇⠘⣿⣾",
        "⣿⣿⡟⢸⡿⢰⣿⡿⢡⣿⡿⠁⣾⣿⢁⠸⣧⡃⢱⣿⡇⣿⢿⣿⣿⣿⣿⣿⣿⡇⠀⠀⣿⡄⢒⡄⣀⣶⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣭⣴⣿⣿⡇⢸⠏⣽⣿⣿⡇⢿⡃⢿⣧",
        "⣿⣿⡷⢸⠇⣿⣿⢃⣿⣿⠁⣰⣿⡏⢸⣧⠹⢡⢸⡟⣷⢸⠸⣿⣿⣿⣿⡏⢫⣴⡐⣦⡘⢷⣌⣑⣛⣃⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠈⢸⣿⣿⣿⡇⠸⣿⠈⣿",
        "⣿⣿⡇⣾⢸⣿⠇⣼⣿⢇⣼⣿⣿⡇⣿⣿⣷⠈⣸⠁⣿⠈⠆⣿⣿⣿⣿⣿⡌⢻⣧⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⠏⣠⢸⢸⣿⣿⣿⠃⡇⣿⡇⣾",
        "⣿⣿⡇⠛⣾⡏⣸⣿⠃⣸⣿⣿⣿⡇⣿⣿⣿⢸⣿⢸⢸⡄⠀⣿⣿⣿⣿⣿⣿⣎⠻⣆⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢸⢸⡿⢿⣿⢸⣇⢿⣧⣿",
        "⣿⣿⡇⠀⠿⢰⣿⢃⣾⣿⣿⣿⣿⡇⢻⣿⣿⢸⡇⣾⡌⣇⢀⢹⣿⣿⣿⣿⡟⣿⣷⡄⣅⣙⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢋⣾⠸⢸⡇⢸⡏⣼⣿⣿⣿⣿",
        "⡘⣿⡇⢰⠆⣾⢃⣾⣿⣿⣿⣿⣿⣿⢸⣿⣿⠸⡇⢻⡇⢹⡘⠆⢻⣿⣿⣿⡇⡘⣿⣿⡜⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣍⣿⣿⣿⣟⣰⣿⣿⠟⢡⣾⣿⠀⣼⢡⣧⢇⣿⣿⣿⣿⣿",
        "⣧⢹⡇⠘⢸⠃⢸⣿⣿⢿⣿⣿⣿⣿⡆⢿⣿⡇⢿⢸⣿⠈⢧⠘⣶⣿⣿⣿⡇⣷⡌⢿⣷⡘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣡⣴⣿⣿⣿⢀⡏⣼⣿⣿⣿⢻⣿⣿⣿",
        "⣿⣆⠳⠀⠎⡄⣼⣿⣿⠸⣿⣿⣿⣿⣷⡘⣿⣿⡘⡘⣿⠀⠀⢳⡘⣿⣿⣿⣷⣿⣿⡀⡙⣯⡄⢭⣛⡻⠿⢿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⡿⢹⣿⣿⡏⠈⣰⣿⣿⣿⡏⢸⣿⢹⣿",
        "⣿⣿⣦⠀⢰⡇⢿⣿⣿⡄⠙⣿⣿⣿⣿⣷⠸⣿⣇⠀⢻⡄⣇⠰⡝⢿⣿⣿⣿⢻⣿⣇⢻⠀⠙⢦⡙⢿⣿⣿⠶⠶⠦⠉⣭⣭⣭⣾⠁⠀⠁⠈⣿⡟⠀⢰⣿⣿⣿⡇⠀⢸⡏⣼⡿",
        "⣿⣿⣿⢀⣿⡇⣦⠹⢿⣇⢺⣮⡛⢿⣿⣿⣷⣽⡟⠐⣌⠣⢹⣧⡙⢦⣝⠻⣿⢸⣿⣿⡆⠀⣿⣶⣬⣀⠐⢠⣤⣤⡤⠁⠛⣛⠻⠃⣼⣤⠀⢀⣟⣠⠆⢸⣿⡟⠏⣰⡇⠸⣰⣿⣇",
        "⣿⣿⣿⢸⣿⡇⣿⣿⣦⡙⠌⢿⣿⣦⣍⠛⢿⣿⣿⡆⠈⢳⡈⢿⣿⣦⡙⢷⣮⣈⣿⣿⣿⣄⢙⠻⠿⠿⢠⠸⠿⠿⠇⠄⠷⢊⡑⣀⢠⢀⡀⢸⠟⠁⢠⠿⢛⡀⢸⣿⠀⣡⣿⣿⡗",
        "⣿⣿⣿⣾⣿⡇⣿⣿⣿⣿⣶⣤⣿⣿⣿⣿⣶⣬⣍⣙⡈⢦⠀⠀⢛⣋⣭⣴⣌⡛⢿⣿⣿⣿⣦⠻⣿⣿⣶⣤⠄⣁⣤⢠⡅⡘⠃⠿⠂⠦⠉⢠⣦⡁⣄⠲⡝⢱⠈⠉⠄⣿⣿⣿⠁",
        "⣿⣿⣿⣿⣿⡇⣯⣿⣿⣿⣿⣿⣿⣿⣿⡏⢭⠉⠿⠦⣐⢶⣦⡹⣎⠻⣿⣿⣿⣿⣷⣦⡉⢉⣛⣓⣊⠉⠛⠋⠼⠟⣡⢀⠔⣵⢟⣤⠻⣠⡞⣸⣿⣿⡌⢦⠹⡄⢷⡐⣄⢻⣿⣿⣡",
        "⣿⣿⣿⣿⣿⡇⠛⠛⠉⠉⠉⠉⣿⣿⣿⠏⣔⣛⠿⢷⣦⡁⡙⠳⣌⠳⡙⢿⣿⣿⣿⣿⣿⣦⡹⢿⣿⣿⣿⡆⠂⠚⢡⢣⣾⢣⣾⠟⣴⡟⣡⡘⢿⣿⣿⣌⢧⠹⡈⣽⡸⣆⠻⠿⣾",
      }
        ----Aqui el arte ascii se puede cambiar
        -- Botones útiles
      dashboard.section.buttons.val = {
        dashboard.button("e", "  Nuevo archivo", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Buscar archivo", ":Telescope find_files<CR>"), --- Buscar icono de lupa
        dashboard.button("r", "  Archivos recientes", ":Telescope oldfiles<CR>"), 
        dashboard.button("q", "  Salir", ":qa<CR>"), --Buscar icono de puerta
      }

      alpha.setup(dashboard.opts)
    end,
  },


})

