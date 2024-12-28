return {
        {
                "hrsh7th/nvim-cmp",
                opts = function (plugin, opts)
                        local cmp = R('cmp')
                        local luasnip = R('luasnip')

                        local defaults = {
                                snippet = {
                                        expand = function(args) 
                                                luasnip.lsp_expand(args.body)
                                        end
                                },
                                window = {},
                                mapping = {
                                        ['<c-j>'] = cmp.mapping(function (fallback)
                                                if cmp.visible() then
                                                        cmp.select_next_item()
                                                elseif luasnip.jumpable(1) then
                                                        luasnip.jump(1)
                                                else
                                                        fallback()
                                                end
                                        end, {'i', 's'}),

                                        ['<c-k>'] = cmp.mapping(function (fallback)
                                                if cmp.visible() then
                                                        cmp.select_prev_item()
                                                elseif luasnip.jumpable(-1) then
                                                        luasnip.jump(-1)
                                                else
                                                        fallback()
                                                end
                                        end, {'i', 's'}),


                                        ['<cr>'] = cmp.mapping(function (fallback)
                                                if luasnip.expandable() then
                                                        luasnip.expand()
                                                elseif cmp.visible() then
                                                        cmp.confirm()
                                                else
                                                        fallback()
                                                end
                                        end, {'i', 's'}),

                                        ['<c-s>'] = cmp.mapping(function (fallback)
                                                if luasnip.expand_or_jumpable() then
                                                        luasnip.expand_or_jump()
                                                else
                                                        fallback()
                                                end
                                        end, { "i", "c" }),

                                        ['<c-space>'] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
                                },
                                experimental = {
                                        ghost_text = true,
                                },

                                formatting = {
                                        format = function(entry, item)
                                                item.menu = entry.source.name
                                                return item
                                        end
                                },

                                sorting = {
                                        comparators = {
                                                function (entry1, entry2)
                                                        local t = {
                                                                nvim_ciderlsp = 1,
                                                                nvim_lsp = 2,
                                                                nvim_lua = 3,
                                                                luasnip = 4,
                                                        }
                                                        local big = 9999
                                                        local v1 = t[entry1.source.name] or big
                                                        local v2 = t[entry2.source.name] or big
                                                        -- If equal, go to next comparator.
                                                        if v1 == v2 then return nil end
                                                        return v1 < v2
                                                end,
                                                function (entry1, entry2)
                                                        local ci1, ci2 = entry1.completion_item, entry2.completion_item
                                                        if ci1 == nil or ci2 == nil then return nil end
                                                        local st1, st2 = ci1.sortText, ci2.sortText
                                                        if st1 == nil or st2 == nil then return nil end
                                                        return st1 < st2
                                                end
                                        },
                                },

                        }
                        for k, v in pairs(defaults) do opts[k] = v end

                        local sources = {
                                { name = 'nvim_lsp' },
                                { name = 'nvim_lua' },
                                { name = 'luasnip' }, -- For luasnip users.
                        }
                        local existingSources = opts.sources or {}
                        for _, source in ipairs(sources) do 
                                table.insert(existingSources, source)
                        end
                        opts["sources"] = cmp.config.sources(existingSources)
                end,
                keys = {
                        {'<leader>ls', "<cmd>lua lsp()<cr>", mode ='n'},
                        {'<leader>lh', "<cmd>lua vim.lsp.buf.hover()<cr>", mode ='n'},
                        {'<leader>gd', "<cmd>lua vim.lsp.buf.definition()<cr>", mode ='n'},
                        {'<leader>gr', "<cmd>lua vim.lsp.buf.references()<cr>", mode ='n'},
                        {'<leader>gh', "<cmd>lua vim.lsp.buf.hover()<cr>", mode ='n'},
                        {'<leader>r', "<cmd>lua vim.lsp.buf.rename()<cr>", mode ='n'},
                        {'<m-c>', "<cmd>lua vim.lsp.buf.completion()<cr>", mode ='i'},
                        {'<m-j>', "<cmd>lua require('cmp').complete()<cr>", mode ='i'},
                        -- On Mac OS Alt-J gives ∆
                        {'∆', "<cmd>lua require('cmp').complete()<cr>", mode ='i'},
                        {'<m-l>', "<esc>F{a<cr><cr><esc>kS", mode ='i'}, -- }
                        {'<m-k>', "<cmd>lua vim.lsp.buf.signature_help()<cr>", mode ='i'},
                },
        },
        {"hrsh7th/cmp-nvim-lsp", opts = {}},
        { "hrsh7th/cmp-nvim-lua" },
        {
                "L3MON4D3/LuaSnip",
                config = function ()
                        R("luasnip.config").setup({ enable_autosnippets = true }) 
                        R("luasnip.loaders.from_snipmate").load()
                        R("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})
                end
        },
        {"saadparwaiz1/cmp_luasnip"},
}
