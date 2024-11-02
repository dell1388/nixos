{pkgs, config, ...}:	
{
  nixvim = { enable = true;
  	
	colorschemes.onedark = {
	enable = true;
	style = 'darker';

	}

  	plugins = {
	conform-nvim = {
		enable = true;
			formatters_by_ft = {
         		   nix = ["alejandra"];
         		   python = [ "ruff_format"];
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
	vim-visual-multi(pkgs.vimUtils.buildVimPlugin
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
