/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package mime

import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.ark_interop_helper.*
import ohos.pasteboard.MIMETYPE_PIXELMAP

var allMimeArkts: Option<MimeArkts> = None
var liteMimeArkts: Option<MimeArkts> = None

@Interop[ArkTS]
public func mimeAll(): MimeArkts {
    if (let Some(v) <- allMimeArkts) {
        return v
    }
    let mimeArkts = MimeArkts(MIME)
    allMimeArkts = mimeArkts
    return mimeArkts
}

@Interop[ArkTS]
public func mimeLite(): MimeArkts {
    if (let Some(v) <- liteMimeArkts) {
        return v
    }
    let mimeArkts = MimeArkts(MIME_LITE)
    liteMimeArkts = mimeArkts
    return mimeArkts
}
