local function label(ty)
    return function()
        -- generate random sequence of 4 lowercase letters
        local charset = {}
        for c = 97, 122 do
            table.insert(charset, string.char(c))
        end

        local s = ""
        for _ = 1, 4 do
            s = s .. charset[math.random(1, #charset)]
        end
        return  "\t \\label{" .. ty .. ":" .. s .. "}"
    end
end

--- cannot include a newline in a node, so we have to use multiple strings in a list
--- to do it.
local function env(name, labelprefix)
    local postlabel = labelprefix and t({"", "\t"}) or t("\t")
    return {
        t({"\\begin{" .. name .. "}", ""}),
        labelprefix and f(label(labelprefix)) or t(""),
        postlabel,
        i(1),
        t({"", "\\end{" .. name .. "}", ""})
    }
end

return {
    s("eq", env("equation", "eq")),
    s("al", env("align", "eq")),
    s("thm", env("theorem", "thm")),
    s("lem", env("lemma", "lem")),
    s("def", env("definition", "def")),
    s("rmk", env("remark", "rmk")),
    s("it", env("itemize")),
    s("en", env("enumerate")),
    s("pf", env("proof")),
}
