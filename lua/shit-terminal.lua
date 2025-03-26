local te = {}

---@description: open terminal at the below, run the shell by shname, size the pane by high.
---@param shname  string : the shell name you want run.
---@param high  number : the height you want size in percentage of current window, range from 0 -> 1.
function te.openTerminalBelow(shname, high)
	high = high and high or te.high
	shname = shname and shname or te.default_shell
	local buf = vim.api.nvim_create_buf(false, true)
	local h = vim.api.nvim_win_get_height(0)
	local win = vim.api.nvim_open_win(buf, true, { win = 0, split = "below", height = math.floor(h * high) })
	vim.fn.termopen(shname)
	return win
end

local function default_config()
	te.high = 0.25
	te.shells = { "bash", "fish" }
	te.default_shell = "bash"
	te.enable_map = true
	te.leader = "<Leader>vi"
end

---@description: setup
---@param opt table :
function te.setup(opt)
	default_config()
	opt = opt and opt or {}
	for k, v in pairs(opt) do
		te[k] = v
	end

	vim.api.nvim_create_user_command("OpenShitTermDef", function()
		te.openTerminalBelow(te.default_shell, te.high)
	end, { bang = true })
	vim.api.nvim_create_user_command("OpenShitTerm", function(args) te.openTerminalBelow( args[1], tonumber(args[2], 10) ) end, {
		bang = true,
		complete = function(ArgLead, CmdLine, CursorPos)
			if string.match(string.sub(CmdLine, 1, CursorPos), "%s*OpenShitTerm%s*[^%s]+%s+") then
				return { string.format("%.2f", te.high) }
			else
				return te.shells
			end
		end,
		nargs = "*",
	})

	if te.enable_map then
		vim.keymap.set(
			"t",
			te.leader .. "<ESC>",
			"<C-\\><C-N>",
			{ nowait = true, silent = true, desc = "shit_terminal esc" }
		)
		vim.keymap.set("t", te.leader .. "m", "<C-\\><C-N>", { desc = "shit_terminal esc" })
		vim.keymap.set(
			{ "v", "n" },
			"<C-E>",
			"<cmd>OpenShitTermDef<CR>",
			{ nowait = true, silent = true, desc = "shit_terminal open terminal default shell" }
		)
		vim.keymap.set("t", te.leader .. "q", "<cmd>q<CR>", { desc = "shit_terminal quit form terminal buffer" })
	end
end

return te
