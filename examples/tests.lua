local g = lvgl.group.get_default()

local focused = lvgl.Style({
    border_width = 5,
    border_color = "#a00",
})

local container = lvgl.Object(nil, {
    w = lvgl.HOR_RES(),
    h = lvgl.VER_RES(),
    bg_color = "#888",
    bg_opa = lvgl.OPA(100),
    border_width = 0,
    radius = 0,
    flex = {
        flex_direction = "row",
        flex_wrap = "wrap"
    }
})

local function createBtn(parent, name)
    local root = parent:Object {
        w = lvgl.SIZE_CONTENT,
        h = lvgl.SIZE_CONTENT,
        bg_color = "#ccc",
        bg_opa = lvgl.OPA(100),
        border_width = 0,
        radius = 10,
        pad_all = 20,
    }

    root:onClicked(function()
        container:delete()
        require(name)
    end)

    root:Label {
        text = name,
        text_color = "#333",
        align = lvgl.ALIGN.CENTER,
    }

    root:add_style(focused, lvgl.STATE.FOCUSED)

    g:add_obj(root)

    return root
end

lvgl.group.focus_obj(createBtn(container, "font"))
createBtn(container, "uservalue")
createBtn(container, "roller")
createBtn(container, "dropdown")
createBtn(container, "extension")
createBtn(container, "fs")
createBtn(container, "indev")
createBtn(container, "group")
createBtn(container, "protectedcall")
