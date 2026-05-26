return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
        },
        appearance = {
          nerd_font_variant = "mono",
        },
      })
    end,
  },
}
