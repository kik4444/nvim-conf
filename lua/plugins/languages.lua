local is_not_nixos = not (vim.uv or vim.loop).fs_stat("/run/current-system/sw/bin")

-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
local ts_js_common_settings = {
  referencesCodeLens = {
    enabled = true,
    showOnAllFunctions = true,
  },
  implementationsCodeLens = {
    enabled = true,
    showOnInterfaceMethods = true,
  },
  suggest = {
    completeFunctionCalls = true,
    includeAutomaticOptionalChainCompletions = true,
  },
  inlayHints = {
    parameterNames = { enabled = "all" },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
  },
  format = {
    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
    semicolons = "insert",
  },
  implicitProjectConfig = { checkJs = true },
}
local ts_js_settings = {}

for _, language in ipairs({ "javascript", "typescript" }) do
  ts_js_settings[language] = ts_js_common_settings
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "nix",
        "hyprlang",
        "ini",
        "groovy",
        "puppet",
        "html",
        "css",
        "proto",
        "hcl",
        "zig",
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
        "npm-groovy-lint", -- Mainly used for Jenkinsfile
        "puppet-editor-services", -- Puppet language server
        "html-lsp",
        "css-lsp",
        "emmet-language-server",
        "clang-format", -- Used for protobufs
        "elixir-ls",
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
        proto = { "clang-format" },
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
        ["clang-format"] = {
          command = "clang-format",
          args = {
            "--assume-filename=a.proto",
            "--style",
            "{BasedOnStyle: Google, IndentWidth: " .. vim.opt.shiftwidth:get() .. "}",
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = {
        groovy = { "npm-groovy-lint" },
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
    keys = {
      { mode = { "n" }, "<leader>cL", vim.cmd.LspLog, desc = "Lsp log" },
      { mode = { "n" }, "<leader>cQ", vim.cmd.LspRestart, desc = "Lsp restart" },
    },
    opts = {
      codelens = {
        enabled = true,
      },
      servers = {
        nixd = {
          mason = false,
          settings = {
            nixd = {
              formatting = {
                command = { "alejandra" },
              },
            },
          },
        },
        gopls = {
          mason = is_not_nixos,
          settings = {
            -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            gopls = {
              usePlaceholders = false,
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
                fieldalignment = true,
                unusedvariable = true,
                shadow = true,
              },
            },
          },
        },
        vtsls = {
          settings = ts_js_settings,
        },
        marksman = {
          mason = is_not_nixos,
        },
        taplo = {
          keys = {
            { mode = { "n" }, "<leader>K", require("crates").show_popup, desc = "Show Crate Documentation" },
            { mode = { "n" }, "<leader>ctt", require("crates").toggle, desc = "Toggle Crates" },
            { mode = { "n" }, "<leader>ctr", require("crates").reload, desc = "Reload crates" },

            { mode = { "n" }, "<leader>ctv", require("crates").show_versions_popup, desc = "Show Versions Popup" },
            { mode = { "n" }, "<leader>ctf", require("crates").show_features_popup, desc = "Show Features Popup" },
            {
              mode = { "n" },
              "<leader>ctd",
              require("crates").show_dependencies_popup,
              desc = "Show Dependencies Popup",
            },

            { mode = { "n", "v" }, "<leader>ctu", require("crates").update_crate, desc = "Update Crate" },
            { mode = { "n" }, "<leader>cta", require("crates").update_all_crates, desc = "Update All Crates" },
            { mode = { "n", "v" }, "<leader>ctU", require("crates").upgrade_crate, desc = "Upgrade Crate" },
            { mode = { "n" }, "<leader>ctA", require("crates").upgrade_all_crates, desc = "Upgrade All Crates" },

            {
              mode = { "n" },
              "<leader>ctx",
              require("crates").expand_plain_crate_to_inline_table,
              desc = "Expand Plain Crate To Inline Table",
            },
            {
              mode = { "n" },
              "<leader>ctX",
              require("crates").extract_crate_into_table,
              desc = "Extract Crate Into Table",
            },

            { mode = { "n" }, "<leader>ctH", require("crates").open_homepage, desc = "Open Homepage" },
            { mode = { "n" }, "<leader>ctR", require("crates").open_repository, desc = "Open Repository" },
            { mode = { "n" }, "<leader>ctD", require("crates").open_documentation, desc = "Open Documentation" },
            { mode = { "n" }, "<leader>ctC", require("crates").open_crates_io, desc = "Open Crates io" },
          },
          settings = {
            formatter = {
              alignEntries = false, -- Best to avoid because changing one value or key name cascades into changes on the neighboring lines
              alignComments = true,
              arrayTrailngComma = true,
              arrayAutoCollapse = true,
              arrayAutoExpand = true,
            },
          },
        },
        puppet = {
          cmd = { "puppet-languageserver", "--stdio" },
        },
        pbls = {}, -- Protobuf
        emmet_language_server = {
          filetypes = { "heex", "html", "javascriptreact", "svelte", "typescriptreact" },
        },
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
          vim.keymap.set("n", "<leader>cQ", "<cmd>RustAnalyzer restart<cr>", { desc = "Restart rust analyzer" })
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
