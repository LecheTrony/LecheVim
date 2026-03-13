<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  
</head>
<body>
  <h1>🥛 LecheVim</h1>
  <p>
    <strong>LecheVim</strong> es mi configuración personalizada de <strong>Neovim</strong>, pensada para ser modular, reproducible y divertida.  
    Incluye un dashboard con arte ASCII, temas personalizables (Tokyonight y Dracula), y una selección de plugins esenciales para productividad, LSP y estética.
  </p>

  <h2>🚀 Instalación</h2>
  <pre><code>git clone https://github.com/LecheTrony/LecheVim.git ~/.config/nvim
nvim
:Lazy sync
</code></pre>

  <h2>📦 Plugins principales</h2>
  <ul>
    <li><strong>Gestor de plugins</strong>: lazy.nvim</li>
    <li><strong>Temas</strong>: tokyonight.nvim, dracula.nvim</li>
    <li><strong>Dashboard</strong>: alpha-nvim</li>
    <li><strong>Navegación</strong>: telescope.nvim</li>
    <li><strong>LSP</strong>: nvim-lspconfig</li>
    <li><strong>Autocompletado</strong>: nvim-cmp</li>
    <li><strong>Snippets</strong>: LuaSnip</li>
    <li><strong>Git</strong>: gitsigns.nvim</li>
    <li><strong>Árbol de archivos</strong>: nvim-tree.lua</li>
  </ul>

  <h2>🛠️ Estructura del proyecto</h2>
  <pre><code>~/.config/nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   ├── plugins.lua
│   └── ui.lua
└── README.md
</code></pre>

  <h2>🎨 Personalización</h2>
  <ul>
    <li>Alterna entre <strong>Tokyonight</strong> y <strong>Dracula</strong> con atajos:</li>
    <ul>
      <li><code>&lt;leader&gt;tt</code> → Tokyonight</li>
      <li><code>&lt;leader&gt;td</code> → Dracula</li>
    </ul>
    <li>Fondo de Dracula ajustado a violeta oscuro para un look único.</li>
    <li>Dashboard con ASCII banners personalizados.</li>
  </ul>

  <h2>📸 Screenshots</h2>
  <p>Menu de inicio</p>
  <img scr="screenshots/screenshot_20260310_174330.webp" alt="Menu LecheVim" width="600">
  <p>Gestor de archivos</p>
  <img scr="screenshots/screenshot_20260312_172740.webp" alt="Gestor LecheVim" width="600">
  <p>Codificando</p>
  <img scr="screenshots/screenshot_20260312_172810.webp" alt="Gestor LecheVim" width="600">
  <h2>✨ Créditos</h2>
  <p>
    Inspirado en la comunidad de Neovim y adaptado con cariño para un flujo de trabajo productivo y estético.  
    Hecho con ☕ y 🥛 por <a href="https://github.com/LecheTrony">LecheTrony</a>.
  </p>
</body>
</html>
