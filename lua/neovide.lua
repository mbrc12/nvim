------- Neovide config ----------------------
-- vim.o.guifont = "Iosevka Extended:h14"
-- vim.o.guifont = "CommitMono Nerd Font:h15"
-- vim.o.guifont = "Hurmit Nerd Font:h14"
-- vim.o.guifont = "JetBrains Mono:h11"
vim.o.guifont = "FiraCode Nerd Font:h16"
-- vim.o.guifont = "Hasklug Nerd Font:h12"
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h12"
-- vim.o.guifont = "IosevkaTerm Nerd Font:h12"
-- vim.o.guifont = "IosevkaTerm Nerd Font:h14"
-- vim.o.guifont = "UbuntuMono Nerd Font:h15"
-- vim.o.guifont = "Adwaita Mono:h13"
-- vim.o.guifont = "Intel One Mono:h13.5"
-- vim.o.guifont = "InputMono Nerd Font:h13.5"

local animation_length = 0.02
vim.g.neovide_scroll_animation_length = animation_length
vim.g.neovide_cursor_animation_length = animation_length
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_vfx_particle_density = 20.0
vim.g.neovide_macos_simple_fullscreen = true
vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

return {
	setup = function()
		function NeovideFullscreen()
			if vim.g.neovide_fullscreen == true then
				vim.g.neovide_fullscreen = false
			else
				vim.g.neovide_fullscreen = true
			end
		end

		local wk = require("which-key")

		wk.add({
			{ "<F11>", NeovideFullscreen, desc = "Toggle fullscreen in neovide", mode = { "i", "n", "t", "v" } },
		})
	end
}
