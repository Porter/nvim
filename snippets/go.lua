return {
    s("app", fmt( [[{} = append({}, {})]], {i(1), rep(1), i(2)})),

    s("for", fmt( [[
        for _, {} := range {} {{
        	{}
        }}
    ]], {i(2), i(1), i(3)})),

    s("pack",
        fmt("// Package {} {}\npackage {}", {i(1, "name"), i(2, "comment"), rep(1)})
    ),

    s("ie",
        fmt("if err != nil {{\n	return {}err\n}}", {i(1)})
    ),
}, {
    }
