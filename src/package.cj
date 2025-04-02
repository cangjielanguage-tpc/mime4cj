/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package mime

internal import std.collection.*
internal import std.regex.*

extend Regex {
    func replaceSafe(input: String, replacement: String): String {
        if (input == "") {
            return ""
        }
        this.replace(input, replacement)
    }
}
