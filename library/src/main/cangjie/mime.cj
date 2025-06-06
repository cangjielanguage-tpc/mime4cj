/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package mime

public type TypeMap = HashMap<String, Array<String>>

public class Mime {
    private let extensionToType = HashMap<String, String>()
    private let typeToExtension = HashMap<String, String>()
    private let typeToExtensions = HashMap<String, Set<String>>()

    public init(args: Array<TypeMap>) {
        for (arg in args) {
            this.define(arg)
        }
    }

    /**
     * Define mimetype -> extension mappings.  Each key is a mime-type that maps
     * to an array of extensions associated with the type.  The first extension is
     * used as the default extension for the type.
     *
     * e.g. mime.define({'audio/ogg', ['oga', 'ogg', 'spx']})
     *
     * If a mapping for an extension has already been defined an error will be
     * thrown unless the `force` argument is set to `true`.
     *
     * e.g. mime.define({'audio/wav', ['wav']}, {'audio/x-wav', ['*wav']})
     */
    public func define(typeMap: TypeMap, force: Bool): Mime {
        check()
        for ((_typ, _extensions) in typeMap) {
            // Lowercase thingz
            var typ = _typ.toAsciiLower()
//            var extensions = _extensions.map {ext => ext.toAsciiLower()}
            var extensions:Array<String> = Array<String>(_extensions.size,item:"")
            for(i in 0.._extensions.size){
                extensions[i] = _extensions[i].toAsciiLower()
            }

            let allExtensions = this.typeToExtensions.get(typ) ??
                {
                =>
                let set = HashSet<String>()
                this.typeToExtensions.put(typ, set)
//                this.typeToExtensions.add(typ, set)
                set
            }()

            var first = true
            for (_extension in extensions) {
                var extension = _extension
                let starred = extension.startsWith('*')

                extension = if (starred) {
                    extension[1..]
                } else {
                    extension
                }

                // Add to list of extensions for the type
//                allExtensions.add(extension)
                allExtensions.put(extension)

                if (first) {
                    // Map type to default extension (first in list)
                    this.typeToExtension.put(typ, extension)
//                    this.typeToExtension.add(typ, extension)
                }
                first = false

                // Starred types are not eligible to be the default extension
                if (starred) {
                    continue
                }

                // Map extension to type
                let currentType = this.extensionToType.get(extension)
                if (currentType.isSome() && currentType != typ && !force) {
                    throw IllegalStateException(
                        '\"${typ} -> ${extension}\" conflicts with \"${currentType} -> ${extension}\". Pass `force=true` to override this definition.'
                    )
                }
//                this.extensionToType.add(extension, typ)
                this.extensionToType.put(extension, typ)
            }
        }

        return this
    }
    public func define(typeMap: TypeMap): Mime {
        define(typeMap, false)
    }

    public func getType(path: String): ?String {
        // 如果 path 为空，直接返回 None
        if (path.size == 0) {
            return None
        }
        // 查找最后一个斜杠或者反斜杠的位置
        var lastSlashIndex: Int64 = -1
        for (i in (path.size -1)..=0 : -1) {
            let byte: Byte = path[i]
            if (byte == b'/' || byte == b'\\') {
                lastSlashIndex = i
                break
            }
        }
        // 提取文件名部分
        let filename: String = if (lastSlashIndex >= 0) {
            path[(lastSlashIndex + 1)..].toAsciiLower()
        } else {
            path.toAsciiLower()
        }
        // 如果文件名为空，返回 None
        if (filename.size == 0) {
            return None
        }
        // 处理以点开头的文件名
        if (filename.size > 0 && filename[0] == b'.') {
            // 如果只有一个点，则返回 None
            if (filename.size == 1) {
                return None
            }
            // 查找第二个点的位置
            let secondDotIndex: ?Int64 = filename[1..].indexOf(".")
            // 如果没有第二个点，视为隐藏文件，返回 None
            if (secondDotIndex.isNone()) {
                // 特殊情况：如果是 .txt 这样的格式，将点后面的部分作为扩展名
                if (lastSlashIndex < 0) {  // 没有路径部分
                    return this.extensionToType.get(filename[1..])
                }
                return None
            }
            // 如果有第二个点（如 .config.json），提取最后一个扩展名
            let lastDotIndex: ?Int64 = filename.lastIndexOf(".")
            if (lastDotIndex.isSome()) {
                let extension: String = filename[(lastDotIndex.getOrThrow() + 1)..]
                return this.extensionToType.get(extension)
            }
        }
        // 处理普通文件名
        let lastDotIndex: ?Int64 = filename.lastIndexOf(".")
        // 如果没有点，则整个filename可能就是扩展名（无路径部分时）
        if (lastDotIndex.isNone()) {
            // 如果有路径部分，则可能是无扩展名的文件
            if (lastSlashIndex >= 0) {
                return None
            }
            // 否则，将整个filename作为扩展名
            return this.extensionToType.get(filename)
        }
        // 如果最后一个点是文件名的最后一个字符，则没有有效的扩展名
        if (lastDotIndex.getOrThrow() == filename.size - 1) {
            return None
        }
        // 提取扩展名
        let extension: String = filename[(lastDotIndex.getOrThrow() + 1)..]
        return this.extensionToType.get(extension)
    }

    /**
     * Get default file extension associated with a mime type
     */
    public func getExtension(typ: String): ?String {
        // Remove http header parameter(s) (specifically, charset)
        var _typ = if (typ == '') {
            typ
        } else {
            typ.split(';')[0]
        }

        return this.typeToExtension.get(_typ.trimAscii().toAsciiLower())
    }

    /**
     * Get all file extensions associated with a mime type
     */
    public func getAllExtensions(typ: String): ?Set<String> {
        return this.typeToExtensions.get(typ.toAsciiLower())
    }

    //
    // Private API, for internal use only.  These APIs may change at any time
    //
    func _freeze() {
        this.freezed = true
        return this
    }

    private var freezed = false
    private func check(): Unit {
        if (freezed) {
            throw IllegalStateException('define() not allowed for built-in Mime objects.')
        }
    }

    // public func _getTestState() {
    //     return (this.extensionToType, this.typeToExtension)
    // }
}

public let MIME = Mime(standardTypes, otherTypes)._freeze()
public let MIME_LITE = Mime(standardTypes)._freeze()
