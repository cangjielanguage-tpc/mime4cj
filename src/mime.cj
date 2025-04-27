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
            var extensions = _extensions.map {ext => ext.toAsciiLower()}

            let allExtensions = this.typeToExtensions.get(typ) ??
                {
                =>
                let set = HashSet<String>()
                this.typeToExtensions.add(typ, set)
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
                allExtensions.add(extension)

                if (first) {
                    // Map type to default extension (first in list)
                    this.typeToExtension.add(typ, extension)
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
                this.extensionToType.add(extension, typ)
            }
        }

        return this
    }
    public func define(typeMap: TypeMap): Mime {
        define(typeMap, false)
    }

    static let r1 = Regex(#"^.*[/\\]"#)
    static let r2 = Regex(#"^.*\."#)
    /**
     * Get mime type associated with an extension
     */
    public func getType(path: String): ?String {
        // Remove chars preceeding `/` or `\`
        let last = r1.replaceSafe(path, "").toAsciiLower()

        // Remove chars preceeding '.'
        let ext = r2.replaceSafe(last, '').toAsciiLower()

        let hasPath = last.size < path.size
        let hasDot = ext.size < last.size - 1

        // Extension-less file?
        if (!hasDot && hasPath) {
            return None
        }

        return this.extensionToType.get(ext)
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
