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
      telescope = {
        # seacrhes for for things recursively in current directory
        enable = true;
        extensions.fzf-native.enable = true;
        keymaps = {
          # NOTE: <leader> = `spacebar`
          "<leader>pf" = "find_files"; # search for files in directory recursively
          "<leader>ps" = "live_grep"; # search for a word inside the files in directory recursively
          "<leader>pr" = "lsp_references"; # when on a variable/method, show everywhere it is used
        };
      };

      harpoon = {
        # lets you quickly save common files and teleport to them
        enable = true;
        menu = {
          width = 100;
          height = 6;
        };
        keymaps = {
          addFile = "<leader>a"; # save current file to list of files
          toggleQuickMenu = "<leader>s"; # show list of files
          navFile = {
            "1" = "<C-A-j>"; # `control alt j` for first file in list
            "2" = "<C-A-k>";
            "3" = "<C-A-l>";
            "4" = "<C-A-;>";
          };
        };
      };

      todo-comments.enable = true; # TODO: lets you do this, # FIX: and this, # BUG: and this

      # opens the current directory inside a vim window, and lets you add files just by going into insert mode and typing a filename amoung other things
      oil.enable = true; # NOTE: the open keybind is `-` and is declared down below
      comment.enable = true; # NOTE: `gcc` to comment a line, or select lines and then `gc`
      web-devicons.enable = true; # cool icons
      nvim-autopairs.enable = true; # matches item when typing an (, [, or {
      markdown-preview.enable = true;
      autoclose.enable = true;
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
          jdtls.enable = true; # NOTE: this is a much better java lsp
          jsonls.enable = true;
          ltex.enable = true;
          marksman.enable = true;
          nixd = {
            enable = true;
            extraOptions.offset_encoding = "utf-8";
          };
          pyright.enable = true;
          matlab_ls.enable = true;
          #  typst-lsp.enable = true;
          tinymist = {
            enable = true;
            extraOptions.offset_encoding = "utf-8";
            settings.exportPdf = "onSave";
          };
        };
      };
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
        };
      };
      typst-vim.enable = true;
    };
    extraConfigLua = ''
      require("typst-preview").setup()
    '';
    keymaps = [
      {
        mode = ["n"];
        key = "<leader>pt";
        action = "<cmd>TodoTelescope<cr>"; # NOTE: opens telescope with all the places you have todo related comments
      }
      {
        mode = ["n"];
        key = "-";
        action = "<cmd>Oil<cr>"; # NOTE: opens telescope with all the places you have todo related comments
      }
      {
        mode = ["n"];
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR><Esc>"; # NOTE: disables highlight from search, after hitting escape
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      vim-visual-multi # NOTE: `control n` to do multi cursor when you are on a word
      typst-preview-nvim # NOTE: they added this to nixpkgs yay!
    ];
  };
}
