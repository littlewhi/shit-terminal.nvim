# Intro
This is a very basic plugin for opening terminal below in nvim.
Because it is so basic that it is real shit.

# Install
Like any other nvim plugin

# Usage
After the installment, it needs to use the setup() to begin.
`require(shit-terminal).setup({})`

# config
The default config like this:
```lua
{
	high = 0.25,  -- the terminal buffer window height, which is the percentage of current window
	shells = { "bash", "fish", "zsh" }, -- the available shells, which are for complete in commandline
	default_shell = "bash", -- the default shell
	enable_map = true, -- whether using default map keys
	leader = "<Leader>vi" -- the default startup keys in terminal mode
}
```

# map
default map:
The <shit_leader> is the leader in config.
```
# return back to normal mode from terminal mode
tmode   	<shit_leader><ESC> -> <C-\><C-N>
tmode   	<shit_leader>m -> <C-\><C-N>

# open terminal and run default shell below current window
vmode nmode <C-E> -> <cmd>OpenShitTermDef<CR>

# return back to original window from terminal window in terminal mode
tmode 		<shit_leader>q -> <cmd>q<CR>
```

# command
```
# open terminal and run default shell below current window
OpenShitTermDef

# open terminal by the argument below current window
OpenShitTerm <shellname> <height_percentage>
```

# note
When we open a terminal window, only if we press the i, a, I, A... character we go into terminal mode. When we don't press one of these keys, we are in the normal mode which means we can run the nvim command as we want and remember that the tmode keysmap ara not useful.  And in tmode, the normal command of nvim are not useful, you need <C-\><C-N> to go back to normal mode or <C-\><C-O> to execute normal mode command. Please to loop up `:h terminal-emulator`
