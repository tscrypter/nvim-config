return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
	        "williamboman/mason-lspconfig.nvim",
        	"hrsh7th/cmp-nvim-lsp",
	        "hrsh7th/cmp-buffer",
        	"hrsh7th/cmp-path",
	        "hrsh7th/cmp-cmdline",
        	"hrsh7th/nvim-cmp",
        	"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require('cmp')
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities())

		require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "markdown_oxide",
		"angularls",
		"apex_ls",
		"bashls",
		"omnisharp",
		"cucumber_language_server",
		"dockerls",
		"docker_compose_language_service",
		"html",
		"eslint",
		"ts_ls",
		"jsonls",
		"vacuum",
		"powershell_es",
		"vuels",
		"yamlls",
		"clangd"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0

                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
		["apex_ls"] = function()
		    local lspconfig = require("lspconfig")
		    lspconfig.apex_ls.setup {
		      apex_jar_path = '/home/tomd/.config/salesforce/apex-jorje-lsp.jar',
			  apex_enable_semantic_errors = false, -- weather to allow Apex Language Server to surface semantic errors
			  apex_enable_completion_statistics = false, -- weather to allow Apex Language Server to collect completion statistics
		    }
		end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' },
            })
        })
    end
}
