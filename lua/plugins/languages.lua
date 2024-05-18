local is_not_nixos = not (vim.uv or vim.loop).fs_stat("/run/current-system/sw/bin")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nushell/tree-sitter-nu" },
    },
    opts = {
      ensure_installed = {
        "nix",
        "hyprlang",
        "ini",
        "nu",
        "ruby",
        "groovy",
        "puppet",
        "html",
        "css",
        "rasi",
        "proto",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "shellcheck",
        "hadolint", -- Dockerfile linter
        "npm-groovy-lint",
        "puppet-editor-services", -- Puppet language server
        "html-lsp",
        "css-lsp",
        "emmet-language-server",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>cg", vim.cmd.ConformInfo, desc = "Conform Info" },
    },
    opts = {
      formatters_by_ft = {
        groovy = { "npm-groovy-lint" },
        puppet = { "puppet-lint" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", vim.opt.shiftwidth:get(), "--case-indent", "--space-redirects" },
        },
        ["npm-groovy-lint"] = {
          command = "npm-groovy-lint",
          args = { "--format", "$FILENAME" },
          stdin = false,
        },
        ["puppet-lint"] = {
          command = "puppet-lint",
          args = { "--fix", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        -- groovy = { "npm-groovy-lint" }, -- FIXME temp stopped
      },
      linters = {
        ["npm-groovy-lint"] = {
          ignore_exitcode = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nu_ls = {}, -- Required
        nil_ls = {
          mason = false, -- NOTE Installed manually
          settings = {
            ["nil"] = {
              formatting = {
                command = { "alejandra" }, -- NOTE Installed manually
              },
            },
          },
        },
        gopls = {
          mason = is_not_nixos,
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                unusedvariable = true,
                shadow = true,
              },
            },
          },
        },
        marksman = {
          mason = is_not_nixos,
        },
        taplo = {
          keys = {
            { mode = { "n" }, "<leader>K", require("crates").show_popup, desc = "Show Crate Documentation" },
            { mode = { "n" }, "<leader>cct", require("crates").toggle, desc = "Toggle Crates" },
            { mode = { "n" }, "<leader>ccr", require("crates").reload, desc = "Reload crates" },

            { mode = { "n" }, "<leader>ccv", require("crates").show_versions_popup, desc = "Show Versions Popup" },
            { mode = { "n" }, "<leader>ccf", require("crates").show_features_popup, desc = "Show Features Popup" },
            {
              mode = { "n" },
              "<leader>ccd",
              require("crates").show_dependencies_popup,
              desc = "Show Dependencies Popup",
            },

            { mode = { "n" }, "<leader>ccu", require("crates").update_crate, desc = "Update Crate" },
            { mode = { "v" }, "<leader>ccu", require("crates").update_crates, desc = "Update Crates" },
            { mode = { "n" }, "<leader>cca", require("crates").update_all_crates, desc = "Update All Crates" },
            { mode = { "n" }, "<leader>ccU", require("crates").upgrade_crate, desc = "Upgrade Crate" },
            { mode = { "v" }, "<leader>ccU", require("crates").upgrade_crates, desc = "Upgrade Crates" },
            { mode = { "n" }, "<leader>ccA", require("crates").upgrade_all_crates, desc = "Upgrade All Crates" },

            {
              mode = { "n" },
              "<leader>ccx",
              require("crates").expand_plain_crate_to_inline_table,
              desc = "Expand Plain Crate To Inline Table",
            },
            {
              mode = { "n" },
              "<leader>ccX",
              require("crates").extract_crate_into_table,
              desc = "Extract Crate Into Table",
            },

            { mode = { "n" }, "<leader>ccH", require("crates").open_homepage, desc = "Open Homepage" },
            { mode = { "n" }, "<leader>ccR", require("crates").open_repository, desc = "Open Repository" },
            { mode = { "n" }, "<leader>ccD", require("crates").open_documentation, desc = "Open Documentation" },
            { mode = { "n" }, "<leader>ccC", require("crates").open_crates_io, desc = "Open Crates io" },
          },
        },
        puppet = {
          cmd = { "puppet-languageserver", "--stdio" },
        },
      },
      setup = {
        nu_ls = function()
          local configs = require("lspconfig.configs")

          -- Check if the config is already defined (useful when reloading this file)
          if not configs.nu_ls then
            configs.nu_ls = {
              default_config = {
                cmd = { "nu", "--lsp" },
                filetypes = { "nu" },
                root_dir = require("lspconfig.util").find_git_ancestor,
                single_file_support = true,
                settings = {},
              },
            }
          end

          require("lspconfig").nu_ls.setup({})
        end,
      },
    },
  },
  -- rust_analyzer handled separately
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set(
            "n",
            "<leader>ce",
            "<cmd>RustLsp renderDiagnostic<cr>",
            { desc = "Render Diagnostic", buffer = bufnr }
          )
          vim.keymap.set("n", "<leader>cE", "<cmd>RustLsp explainError<cr>", { desc = "Explain Error", buffer = bufnr })
          vim.keymap.set("n", "<leader>cM", "<cmd>RustLsp expandMacro<cr>", { desc = "Expand Macro", buffer = bufnr })
          vim.keymap.set("n", "<leader>cD", "<cmd>RustLsp openDocs<cr>", { desc = "Open Docs", buffer = bufnr })
          vim.keymap.set("n", "<leader>cL", "<cmd>RustLsp logFile<cr>", { desc = "Open LSP log file" })
          vim.keymap.set("n", "<leader>cR", "<cmd>RustAnalyzer restart<cr>", { desc = "Restart rust analyzer" })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                enforce = true,
              },
            },
            inlayHints = {
              bindingModeHints = {
                enable = true,
              },
            },
            typing = {
              autoClosingAngleBrackets = {
                enable = true,
              },
            },
            completion = {
              snippets = {
                custom = {
                  PrettyPrintln = {
                    body = 'println!("{:#?}", ${receiver});',
                    description = "Wrap expression in a pretty println!",
                    postfix = "pln",
                    scope = "expr",
                  },
                  Ok = {
                    body = "Ok(${receiver})",
                    description = "Wrap the expression in a `Result::Ok`",
                    postfix = "ok",
                    scope = "expr",
                  },
                  Err = {
                    body = "Err(${receiver})",
                    description = "Wrap the expression in a `Result::Err`",
                    postfix = "err",
                    scope = "expr",
                  },
                  Some = {
                    body = "Some(${receiver})",
                    description = "Wrap the expression in an `Option::Some`",
                    postfix = "some",
                    scope = "expr",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "towolf/vim-helm", -- Helm syntax highlighting
  },
}

-- Puppet manual setup:
-- Follow instructions: https://github.com/puppetlabs/puppet-editor-services?tab=readme-ov-file#setting-up-editor-services-for-development
-- gem install puppet-lint puppet-lint-strict_indent-check puppet-lint-manifest_whitespace-check puppet-lint-unquoted_string-check puppet-lint-leading_zero-check puppet-lint-absolute_classname-check puppet-lint-trailing_comma-check puppet-lint-file_ensure-check puppet-lint-legacy_facts-check
