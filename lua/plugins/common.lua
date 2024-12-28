return {
	-- colorscheme
	{ "ellisonleao/gruvbox.nvim" },
	-- personal
	{
                "Porter/.nvim",
                opts = function (plugin, opts)
                        opts = opts or {}
                        local filetypes = opts['filetypes'] or {}
                        local filetypeOpts = opts['filetypeOpts'] or {}
                        table.insert(filetypes, {
                                filename = {
                                        ['todo.txt'] = "todo"
                                },
                                extension = {
                                        todo = 'todo',
                                },
                        })
                        table.insert(filetypeOpts, {
                                lua = {
                                        spaces = true,
                                        shiftwidth = 4,
                                },
                                todo = {
                                        shiftwidth = 2,
                                },
                        })
                        opts['filetypes'] = filetypes
                        opts['filetypeOpts'] = filetypeOpts
                end
        },
	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{'nvim-lua/plenary.nvim'},
			{ 'camgraff/telescope-tmux.nvim' },
		},
		config = function()
			R('telescope').load_extension("tmux")
		end,
		keys = {
			{'<leader>tm', '<cmd>Telescope tmux windows<cr>', mode = 'n'}
		},
	},
	{ 
		'nvim-lualine/lualine.nvim',
		dependencies = {
                        { "Porter/.nvim" },
		},
		opts = function (plugin, opts)
			local default = {
				options = {
					theme = 'gruvbox',
					component_separators = { left = '', right = ''},
					section_separators = { left = '', right = ''},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {'filename'},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {}
				},
			}
                        local sectionDefaults = {
                                lualine_a = {'mode'},
                                lualine_b = { {function() return vim.fn.expand("%") end} },
                                lualine_x = { {R("porter.lsp").status} },
                                lualine_y = {'filetype'},
                                lualine_z = {'progress'},
                        }
                        for k, v in pairs(default) do opts[k] = v end
                        opts['sections'] = opts['sections'] or {}
                        for k, v in pairs(sectionDefaults) do opts['sections'][k] = v end
                        opts['sections']['lualine_c'] = opts['sections']['lualine_c'] or {}
		end,
	},
	{
		'Porter/bash_history.nvim',
		opts = function(plugin, opts)
                        opts['pastCommandsCount'] = 1000
                        -- Filter out lines starting with #
			opts['filter'] = function(line) return string.match(line, "^[^#]") end
		end,
		keys = {
			{'<leader>k', ':lua R("bash_history").popup(R("porter.term").run)<cr>', mode = "n"}
		},
	},
	-- Treesitter
	{
                "nvim-treesitter/nvim-treesitter",
                main = "nvim-treesitter.configs",
                opts = {
                        ensure_installed = {
                                "go",
                                "gomod",
                                "gosum",
                                "gotmpl",
                                "gowork",
                                "hcl",
                                "lua",
                                "luadoc",
                                "luap",
                                "luau",
                                "python",
                                "query",
                                "rust",
                                "sql",
                        },
                        playground = {
                                enable = true,
                                disable = {},
                                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                                persist_queries = true, -- Whether the query persists across vim sessions
                                keybindings = {
                                        toggle_query_editor = 'o',
                                        toggle_hl_groups = 'i',
                                        toggle_injected_languages = 't',
                                        toggle_anonymous_nodes = 'a',
                                        toggle_language_display = 'I',
                                        focus_language = 'f',
                                        unfocus_language = 'F',
                                        update = 'R',
                                        goto_node = '<cr>',
                                        show_help = '?',
                                },
                        },
                        highlight = {
                                enable = true,
                        },
                        indent = {
                                enable = true,
                        }
                },
        },
}
