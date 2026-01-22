return {
  "nvim-mini/mini.base16",
  lazy = false,
  priority = 1000, -- load colorscheme early during startup.
  opts = {
    palette = {
      base00 = os.getenv("base00"), base01 = os.getenv("base01"), base02 = os.getenv("base02"), base03 = os.getenv("base03"), 
      base04 = os.getenv("base04"), base05 = os.getenv("base05"), base06 = os.getenv("base06"), base07 = os.getenv("base07"),

      base08 = os.getenv("base08"), base09 = os.getenv("base09"), base0A = os.getenv("base0A"), base0B = os.getenv("base0B"), 
      base0C = os.getenv("base0C"), base0D = os.getenv("base0D"), base0E = os.getenv("base0E"), base0F = os.getenv("base0F"),
    },
  },
}
