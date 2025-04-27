// EXEC: cjc %import-path %L %l %f --test
// EXEC: ./main 
//--filter=*.Consistency
import mime.*
import std.collection.*

@Test
public func t1(): Unit {
    MIME.getType('txt') // ⇨ 'text/plain'
    MIME.getExtension('text/plain') // ⇨ 'txt'

    MIME_LITE.getType('txt') // ⇨ 'text/plain'
    MIME_LITE.getExtension('text/plain') // ⇨ 'txt'

    MIME.getType('js') // ⇨ 'text/javascript'
    MIME.getType('json') // ⇨ 'application/json'

    MIME.getType('txt') // ⇨ 'text/plain'
    MIME.getType('dir/text.txt') // ⇨ 'text/plain'
    MIME.getType('dir\\text.txt') // ⇨ 'text/plain'
    MIME.getType('.text.txt') // ⇨ 'text/plain'
    MIME.getType('.txt') // ⇨ 'text/plain'

    MIME.getType('foo/txt') // ⇨ None
    MIME.getType('bogus_type') // ⇨ None

    MIME.getExtension('text/plain') // ⇨ 'txt'
    MIME.getExtension('application/json') // ⇨ 'json'
    MIME.getExtension('text/html; charset=utf8') // ⇨ 'html'

    MIME.getAllExtensions('image/jpeg') // ⇨ [ 'jpeg', 'jpg', 'jpe' ]

    let customTypes: HashMap<String, Array<String>> = HashMap()
    let mime = Mime(customTypes)

    mime.define(HashMap([('text/x-abc', ['abc', 'abcd'])]))

    mime.getType('abcd') // ⇨ 'text/x-abc'
    mime.getExtension('text/x-abc') // ⇨ 'abc'
}
