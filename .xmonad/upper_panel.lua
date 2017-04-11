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

function to_bits(num)
	-- return table of bits, least significant first
	local t = {} -- will contain the bits
	while tonumber(num) > 0 do
		rest = num % 2
		table.insert(t, 1, rest)
		num = (num - rest)/2
	end
	if not next(t) then
		table.insert(t, 1, 0)
	end
	return t
end

function draw_cpu_load()

	cairo_set_source_rgba(cr, 1, 1, 1, 1)
	cairo_set_line_width(cr,2)

	cpu_start=0
	for cpu_num=1,4,1 do
		cairo_move_to(cr,cpu_start,2)
		cpu_end = (conky_parse("${cpu cpu" .. cpu_num .. "}"));
		cairo_line_to(cr,cpu_start+cpu_end,2)
		cairo_close_path(cr)
		cairo_stroke(cr)
		cpu_start = cpu_start+108
	end
end

function draw_seconds(start_x, start_y)
	secs = os.date("%S")
	sec_bits = to_bits(secs)

	local cur_x = start_x
	local cur_y = start_y

	local size = 0
	for _ in pairs(sec_bits) do
		size = size + 1
	end
	while size < 5 do
		cairo_move_to(cr, cur_x, cur_y)
		cairo_line_to(cr, cur_x, cur_y + 1)
		cur_x = cur_x + 2
		size = size + 1
	end

	for bit in pairs(sec_bits) do
		cairo_move_to(cr, cur_x, cur_y)
		if tonumber(sec_bits[bit]) > 0 then
			cairo_line_to(cr, cur_x, cur_y + 5)
		else
			cairo_line_to(cr, cur_x, cur_y + 1)
		end
		cairo_close_path(cr)
		cairo_stroke(cr)

		cur_x = cur_x + 2
	end

	return cur_x
end

function draw_minutes(start_x, start_y)
	mins = os.date("%M")
	min_bits = to_bits(mins)

	local cur_x = start_x
	local cur_y = start_y

	local size = 0
	for _ in pairs(min_bits) do
		size = size + 1
	end
	while size < 5 do
		cairo_move_to(cr, cur_x, cur_y)
		cairo_rectangle(cr, cur_x, cur_y, 4, 4)
		cairo_stroke(cr)
		cur_x = cur_x + 6
		size = size + 1
	end

	for bit in pairs(min_bits) do
		cairo_move_to(cr, cur_x, cur_y)

		cairo_rectangle(cr, cur_x, cur_y, 4, 4)
		if tonumber(min_bits[bit]) > 0 then
			cairo_fill_preserve(cr)
		end
		cairo_stroke(cr)
		cur_x = cur_x + 6
	end

	return cur_x
end

function draw_hours(start_x, start_y)
	hours = os.date("%I")
	hours_bits = to_bits(hours)

	local cur_x = start_x
	local cur_y = start_y

	-- show am/pm
	cairo_move_to(cr, cur_x, cur_y)
	cairo_rectangle(cr, cur_x, cur_y, 4, 4)
	if os.date("%p") == "PM" then
		cairo_fill_preserve(cr)
	end
	cairo_stroke(cr)
	cur_x = cur_x + 8

	local size = 0
	for _ in pairs(hours_bits) do
		size = size + 1
	end
	while size < 4 do
		cairo_move_to(cr, cur_x, cur_y)
		cairo_rectangle(cr, cur_x, cur_y, 8, 4)
		cairo_stroke(cr)
		cur_x = cur_x + 10
		size = size + 1
	end

	for bit in pairs(hours_bits) do
		cairo_move_to(cr, cur_x, cur_y)

		cairo_rectangle(cr, cur_x, cur_y, 8, 4)
		if tonumber(hours_bits[bit]) > 0 then
			cairo_fill_preserve(cr)
		end
		cairo_stroke(cr)
		cur_x = cur_x + 10
	end

	return cur_x
end

function draw_clock()

	local start_x = 1815
	local start_y = 2
	cairo_set_source_rgba(cr, 1, 1, 1, 1)
	cairo_set_antialias(cr, 1)
	cairo_set_line_width(cr, 1)

	local cur_x = start_x
	cur_x = draw_hours(cur_x, 3) + 4
	cur_x = draw_minutes(cur_x, 3) + 4
	cur_x = draw_seconds(cur_x, 2)


end


function conky_main()
	if conky_window == nil then
		return
	end

	cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	cr = cairo_create(cs)

	cairo_select_font_face(cr, "Terminus", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
	draw_workspace()
	draw_mcabber_messages()
	draw_cpu_load()
	draw_clock()

	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cr = nil
end
