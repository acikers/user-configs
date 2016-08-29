require 'cairo'

function update_xmonad_status()
	-- XXX: rewrite to read from pipe
	local f = io.open("/home/acikers/.xmonad/conky_urgent")
	if f then
		xmonad_status_string = f:read()
		f:close()
	end
end

function update_mcabber_status()
	local f = io.open("/home/acikers/.mcabber/eventlog")
	if f then
		local buf = f:read("*line")
		while buf do
			buf = f:read("*line")
			if buf then mcabber_status_string = buf end
		end
		--mcabber_status_string = f:read("*line")
		f:close()
	end
end

function calc_text_pos(fs)
	return conky_window.height - ((conky_window.height - fs) / 2)
end

function draw_workspace()
	update_xmonad_status()
	cairo_set_source_rgba(cr, 1, 1, 1, 1)
	cairo_set_font_size(cr, 12)
	cairo_move_to(cr, 10, calc_text_pos(12))
	cairo_show_text(cr, xmonad_status_string)
end

function draw_mcabber_messages()
	update_mcabber_status()
	cairo_set_source_rgba(cr, 1, 1, 1, 1)
	cairo_set_font_size(cr, 12)
	cairo_move_to(cr, 1200, calc_text_pos(12))
	cairo_show_text(cr, mcabber_status_string)
end

function conky_main()

	cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)

	cairo_select_font_face(cr, "Terminus", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
	draw_workspace()
	draw_mcabber_messages()

	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cr = nil
end
