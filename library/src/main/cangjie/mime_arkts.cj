/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package mime

import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.ark_interop_helper.*

@Interop[ArkTS]
public class MimeArkts {
    @Interop[ArkTS, Invisible]
    var mime: Mime = Mime()

    @Interop[ArkTS, Invisible]
    init(mime: Mime) {
        this.mime = mime
    }

    public init(args: JSArrayEx<JSHashMapEx<String, JSArrayEx<String>>>) {
        let size: Int64 = args.size
        let arr: Array<HashMap<String, Array<String>>> = Array<HashMap<String, Array<String>>>(size, item: HashMap<String, Array<String>>())
        for (i in 0..size) {
            var map: HashMap<String, Array<String>> = HashMap<String, Array<String>>()
            let values: Array<JSArrayEx<String>> = args[i].values().toArray()
            let keys: Array<String> = args[i].keys().toArray()
            for (j in 0..values.size) {
                var mapValueArr: Array<String> = Array<String>(values[j].size, item: "")
                for (k in 0..values[j].size) {
                    mapValueArr[k] = values[j][k]
                }
                map.put(keys[j], mapValueArr)
            }
            arr[i] = map
        }
        mime = Mime(arr)
    }

    public func define1(typeMap: JSHashMapEx<String, JSArrayEx<String>>, force: Bool): MimeArkts {
        var map: HashMap<String, Array<String>> = HashMap<String, Array<String>>()
        let values: Array<JSArrayEx<String>> = typeMap.values().toArray()
        let keys: Array<String> = typeMap.keys().toArray()
        for (j in 0..values.size) {
            var mapValueArr: Array<String> = Array<String>(values[j].size, item: "")
            for (k in 0..values[j].size) {
                mapValueArr[k] = values[j][k]
            }
            map.put(keys[j], mapValueArr)
        }
        mime.define(map, force)
        return this
    }

    public func define(typeMap: JSHashMapEx<String, JSArrayEx<String>>): MimeArkts {
        return define1(typeMap, false)
    }

    public func getType(path: String): Option<String> {
        return mime.getType(path)
    }

    public func getExtension(typ: String): Option<String> {
        return mime.getExtension(typ)
    }

    public func getAllExtensions(typ: String): Option<JSArrayEx<String>> {
        let set: Option<Set<String>> = mime.getAllExtensions(typ)
        return if (let Some(v) <- set) {
            var arr: Array<String> = v.toArray()
            JSArrayEx<String>(arr)
        } else {
            None
        }
    }
}
