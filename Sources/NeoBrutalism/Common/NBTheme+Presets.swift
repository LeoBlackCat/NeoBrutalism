import SwiftUI

public extension NBTheme {
    static let red: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.000, 0.300, 0.312),
            dark: .rgb(1.000, 0.400, 0.410)
        ),
        background: Color(
            light: .rgb(1.000, 0.880, 0.880),
            dark: .rgb(0.210, 0.090, 0.092)
        )
    )

    static let orange: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.000, 0.477, 0.020),
            dark: .rgb(0.920, 0.429, 0.000)
        ),
        background: Color(
            light: .rgb(1.000, 0.928, 0.840),
            dark: .rgb(0.196, 0.134, 0.084)
        )
    )

    static let amber: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.000, 0.750, 0.001),
            dark: .rgb(0.900, 0.675, 0.000)
        ),
        background: Color(
            light: .rgb(0.996, 0.953, 0.784),
            dark: .rgb(0.196, 0.166, 0.084)
        )
    )

    static let yellow: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.980, 0.800, 0.001),
            dark: .rgb(0.880, 0.719, 0.000)
        ),
        background: Color(
            light: .rgb(0.990, 0.968, 0.770),
            dark: .rgb(0.196, 0.172, 0.084)
        )
    )

    static let lime: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.540, 0.900, 0.001),
            dark: .rgb(0.480, 0.800, 0.000)
        ),
        background: Color(
            light: .rgb(0.906, 0.968, 0.812),
            dark: .rgb(0.097, 0.126, 0.054)
        )
    )

    static let green: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.018, 0.882, 0.479),
            dark: .rgb(0.015, 0.784, 0.426)
        ),
        background: Color(
            light: .rgb(0.871, 0.989, 0.914),
            dark: .rgb(0.054, 0.126, 0.086)
        )
    )

    static let emerald: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.000, 0.840, 0.588),
            dark: .rgb(0.000, 0.740, 0.518)
        ),
        background: Color(
            light: .rgb(0.816, 0.984, 0.917),
            dark: .rgb(0.054, 0.126, 0.114)
        )
    )

    static let teal: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.000, 0.840, 0.742),
            dark: .rgb(0.000, 0.740, 0.654)
        ),
        background: Color(
            light: .rgb(0.800, 0.980, 0.950),
            dark: .rgb(0.054, 0.124, 0.126)
        )
    )

    static let cyan: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.000, 0.783, 0.940),
            dark: .rgb(0.000, 0.617, 0.740)
        ),
        background: Color(
            light: .rgb(0.805, 0.963, 0.995),
            dark: .rgb(0.084, 0.164, 0.196)
        )
    )

    static let sky: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.000, 0.600, 1.000),
            dark: .rgb(0.000, 0.540, 0.900)
        ),
        background: Color(
            light: .rgb(0.868, 0.936, 0.992),
            dark: .rgb(0.090, 0.160, 0.210)
        )
    )

    static let blue: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.320, 0.581, 1.000),
            dark: .rgb(0.320, 0.581, 1.000)
        ),
        background: Color(
            light: .rgb(0.863, 0.921, 0.997),
            dark: .rgb(0.126, 0.162, 0.294)
        )
    )

    static let indigo: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.480, 0.515, 1.000),
            dark: .rgb(0.480, 0.515, 1.000)
        ),
        background: Color(
            light: .rgb(0.880, 0.888, 1.000),
            dark: .rgb(0.133, 0.120, 0.280)
        )
    )

    static let violet: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.664, 0.520, 1.000),
            dark: .rgb(0.664, 0.520, 1.000)
        ),
        background: Color(
            light: .rgb(0.933, 0.903, 0.997),
            dark: .rgb(0.199, 0.138, 0.322)
        )
    )

    static let purple: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.792, 0.480, 1.000),
            dark: .rgb(0.752, 0.380, 1.000)
        ),
        background: Color(
            light: .rgb(0.950, 0.900, 1.000),
            dark: .rgb(0.235, 0.120, 0.280)
        )
    )

    static let fuchsia: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.913, 0.420, 1.000),
            dark: .rgb(0.782, 0.000, 0.920)
        ),
        background: Color(
            light: .rgb(0.983, 0.900, 1.000),
            dark: .rgb(0.210, 0.090, 0.210)
        )
    )

    static let pink: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(0.988, 0.392, 0.670),
            dark: .rgb(0.984, 0.196, 0.564)
        ),
        background: Color(
            light: .rgb(0.987, 0.914, 0.954),
            dark: .rgb(0.224, 0.096, 0.143)
        )
    )

    static let rose: NBTheme = NBTheme.default.updateBy(
        main: Color(
            light: .rgb(1.000, 0.400, 0.470),
            dark: .rgb(1.000, 0.300, 0.382)
        ),
        background: Color(
            light: .rgb(1.000, 0.880, 0.890),
            dark: .rgb(0.210, 0.090, 0.116)
        )
    )
}
