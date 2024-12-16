{
  pkgs,
  config,
inputs,
  ...
}: {
imports = [inputs.nixvim.nixosModules.nixvim];
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
     luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };
      cmp-nvim-lsp.enable = true; # lsp
      cmp-calc.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true; # file system paths
      cmp_luasnip.enable = true; # snippets
      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          snippet.expand = "luasnip";
          experimental.ghost_text = true;
          preselect = "cmp.PreselectMode.Item";
          formatting.fields = ["kind" "abbr" "menu"];

          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "nvim_lua";}
            {name = "calc";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-p>" = "cmp.mapping(function() if cmp.visible() then cmp.select_prev_item({behavior = 'select'}) else cmp.complete() end end)";
            "<C-n>" = "cmp.mapping(function() if cmp.visible() then cmp.select_next_item({behavior = 'select'}) else cmp.complete() end end)";
          };
        };
      };
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
          tinymist.enable = true;
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
           extraConfigLua = ''
        require("typst-preview").setup()
    '';
 
    extraPlugins = with pkgs.vimPlugins; [
      vim-visual-multi
      (pkgs.vimUtils.buildVimPlugin
        {
          pname = "typst-preview.nvim";
          version = "1.2.0";
          src = pkgs.fetchFromGitHub {
            owner = "chomosuke";
            repo = "typst-preview.nvim";
            rev = "ebf10fabde7406848d165b1ef13bce5d046195be";
            sha256 = "sha256-J3/xxtTk+NyD/98kBoDFy/Zx0fLht0ILRskKZR6HHUI=";
          };
        })
    ];
  };
}
