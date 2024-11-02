{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    enable = true;
    opts = {
      completeopt = ["menuone" "noselect" "noinsert"];
      cursorcolumn = true;
      cursorline = true;
      expandtab = true;
      ignorecase = true;
      incsearch = true;
      mouse = "a";
      number = true;
      relativenumber = true;
      ruler = false;
      scrolloff = 7;
      shiftwidth = 4;
      showmode = false;
      signcolumn = "yes";
      smartcase = true;
      softtabstop = 4;
      swapfile = false;
      tabstop = 4;
      termguicolors = true;
      undofile = true;
      updatetime = 50;
      wrap = false;
      writebackup = false;
    };

    viAlias = true;
    luaLoader.enable = true;
    globals = {
      mapleader = " ";
    };
    colorschemes.onedark = {
      enable = true;
      settings.style = "darker";
    };

    plugins = {
      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          nix = ["alejandra"];
          python = ["ruff_format"];
          "*" = ["trim_whitespace"];
        };
      };
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "gl" = "open_float";
          };
          lspBuf = {
            "K" = "hover";
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "go" = "type_definition";
            "gr" = "references";
            "gs" = "signature_help";

            "<leader>rn" = "rename";
            "<leader>ra" = "code_action";
            "<leader>rr" = "references";
          };
        };
        onAttach = ''vim.keymap.set("n", "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end) '';
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          cssls.enable = true;
          html.enable = true;
          java_language_server.enable = true;
          jsonls.enable = true;
          ltex.enable = true;
          marksman.enable = true;
          nixd.enable = true;
          pyright.enable = true;
          typst_lsp.enable = true;
        };
      };
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };
      typst-vim.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-visual-multi
      (pkgs.vimUtils.buildVimPlugin
        {
          pname = "typst-preview.nvim";
          version = "0.3.3";
          src = pkgs.fetchFromGitHub {
            owner = "chomosuke";
            repo = "typst-preview.nvim";
            rev = "0354cc1a7a5174a2e69cdc21c4db9a3ee18bb20a";
            sha256 = "sha256-n0TfcXJLlRXdS6S9dwYHN688IipVSDLVXEqyYs+ROG8=";
          };
        })
    ];
  };
}
