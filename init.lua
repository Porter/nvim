-- Leader is the space bar.
vim.keymap.set('n', '<space>', '<nop>', {noremap = true})
vim.g.mapleader = ' '

function R(p)
        return require(p)
end
function Re(p)
        package.loaded[p] = nil
        return require(p)
end
function P(p)
        print(vim.inspect(p))
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
                vim.api.nvim_echo({
                        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                        { out, "WarningMsg" },
                        { "\nPress any key to exit..." },
                }, true, {})
                vim.fn.getchar()
                os.exit(1)
        end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
                -- lua/plugins/
		{ import = "plugins" },
	},
	install = { colorscheme = { "gruvbox" } },
	checker = { enabled = false },
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])


print("ready")
