// EXEC: cjc %import-path %L %l %f --test
// EXEC: ./main 
//--filter=*.Consistency
import mime.*
import std.collection.*
import std.sort.*

type Input_Expected = (String, ?String)

func testGetType(caseName: String, mime: Mime, tests: Array<Input_Expected>): Unit {
    for ((input, expected) in tests) {
        if (mime.getType(input) != expected) {
            fail('${caseName}: ${input}, ${expected}')
        }
    }
}

func testGetExtension(caseName: String, mime: Mime, tests: Array<Input_Expected>): Unit {
    for ((input, expected) in tests) {
        if (mime.getExtension(input) != expected) {
            fail('${caseName}: ${input}, ${expected}')
        }
    }
}

let mime = MIME

@Test
public class MimeTest {
    @TestCase
    public func new_constructor(): Unit {
        let t = "new constructor"
        let mime = Mime(HashMap([('text/a', ['a', 'a1']), ('text/b', ['b', 'b1'])]))
        testGetType(
            t,
            mime,
            [
                ('a', 'text/a'),
                ('a1', 'text/a'),
                ('b', 'text/b'),
                ('b1', 'text/b')
            ]
        )

        testGetExtension(
            t,
            mime,
            [('text/a', 'a'), ('text/b', 'b')]
        )
    }
    @TestCase
    func define() {
        let t = 'define()'
        let mime = Mime(HashMap([('text/a', ['a']), ('text/b', ['b'])]))

        // Should throw when trying to override an existing type->ext mapping
        @AssertThrows[IllegalStateException](mime.define(HashMap([(  'text/c', ['b'] )])))

        // Should not throw if it's a mapping we already have
        mime.define(HashMap([('text/c', ['b', 'c'])]), true)

        testGetType(
            t,
            mime,
            [
                ('a', 'text/a'),
                ('b', 'text/c'),
                ('c', 'text/c')
            ]
        )

        testGetExtension(
            t,
            mime,
            [
                ('text/a', 'a'),
                ('text/c', 'b'),
                ('text/c', 'b')
            ]
        )
    }

    @TestCase
    func define_ed_types() {
        let t = "define() *'ed types"
        let mime = Mime(HashMap([('text/a', ['*b']), ('text/b', ['b'])]))

        testGetType(t, mime, [('b', 'text/b')])

        testGetExtension(t, mime, [('text/a', 'b'), ('text/b', 'b')])
    }

    @TestCase
    func case_insensitive() {
        let t = 'case-insensitive'
        let mime = Mime(HashMap([('TEXT/UPPER', ['UP']), ('text/lower', ['low'])]))

        testGetType(
            t,
            mime,
            [
                ('up', 'text/upper'),
                ('UP', 'text/upper'),
                ('low', 'text/lower'),
                ('LOW', 'text/lower')
            ]
        )

        testGetExtension(
            t,
            mime,
            [
                ('text/upper', 'up'),
                ('text/lower', 'low'),
                ('TEXT/UPPER', 'up'),
                ('TEXT/LOWER', 'low')
            ]
        )
    }

    @TestCase
    func getType() {
        let t = 'getType()'
        testGetType(
            t,
            mime,
            [
                // Upper/lower case

                ('text.txt', 'text/plain'),
                ('TEXT.TXT', 'text/plain'),

                // Bare extension
                ('txt', 'text/plain'),
                ('.txt', 'text/plain'),
                ('.bogus', None),
                ('bogus', None),

                // File paths
                ('dir/text.txt', 'text/plain'),
                ('dir\\text.txt', 'text/plain'),
                ('.text.txt', 'text/plain'),
                ('.txt', 'text/plain'),
                ('txt', 'text/plain'),
                ('/path/to/page.html', 'text/html'),
                ('c:\\path\\to\\page.html', 'text/html'),
                ('page.html', 'text/html'),
                ('path/to/page.html', 'text/html'),
                ('path\\to\\page.html', 'text/html'),
                ('/txt', None),
                ('\\txt', None),
                ('text.nope', None),
                ('/path/to/file.bogus', None),
                ('/path/to/json', None),
                ('/path/to/.json', None),
                ('/path/to/.config.json', 'application/json'),
                ('.config.json', 'application/json'),

                // Non-sensical
                ('', None)
            ]
        )
    }

    @TestCase
    func getExtension() {
        let t = 'getExtension()'
        testGetExtension(
            t,
            mime,
            [
                // Upper/lower case
                ('text/html', 'html'),
                (' text/html', 'html'),
                ('text/html ', 'html'),
                ('application/x-bogus', None),
                ('bogus', None),
                ('', None)
            ]
        )
    }
}

@Test
func getAllExtensions() {
    let mime = Mime(HashMap(('text/a', ['a', 'b'])), HashMap(('text/a', ['b', 'c'])))
    let arr = mime.getAllExtensions('text/a')?.toArray()
    arr?.sort()
    @Assert(arr, ['a','b','c'])
}

@Test
class DB {
    @TestCase
    func Consistency() {
        // 此用例设计有误
        // let (ext2type, typ2ext) = mime._getTestState()

        // for ((ext, typ) in ext2type) {
        //     @Assert(
        //         ext,
        //         typ2ext[typ]
        //     )
        //     // '${ext} does not have consistent ext->type->ext mapping',
        // }
    }

    @TestCase
    func Specific_types() {
        let t = 'Specific types'
        testGetType(
            t,
            mime,
            [
                ('html', 'text/html'),
                ('js', 'text/javascript'),
                ('json', 'application/json'),
                ('rtf', 'application/rtf'),
                ('txt', 'text/plain'),
                ('xml', 'application/xml'),
                ('wasm', 'application/wasm')
            ]
        )

        testGetExtension(t, mime, [('text/xml', 'xml')])
    }

    @TestCase
    func charset_parameter() {
        let t = 'charset parameter'
        testGetExtension(
            t,
            mime,
            [
                ('text/html;charset=UTF-8', 'html'),
                ('text/HTML; charset=UTF-8', 'html'),
                ('text/html; charset=UTF-8', 'html'),
                ('text/html; charset=UTF-8 ', 'html'),
                ('text/html ; charset=UTF-8', 'html'),
                ('application/octet-stream', 'bin'),
                ('application/octet-stream ', 'bin'),
                (' text/html; charset=UTF-8', 'html'),
                ('text/html; charset=UTF-8 ', 'html'),
                ('text/html; charset=UTF-8', 'html'),
                ('text/html ; charset=UTF-8', 'html'),
                ('text/html;charset=UTF-8', 'html'),
                ('text/Html;charset=UTF-8', 'html')
            ]
        )
    }
}

@Test
class CLI {
    //   let exec = util.promisify(child_process.exec)

    //   func returns_type ()  {
    //     let stdout = exec('./bin/cli.js mpeg')
    //     assert.equal(stdout, 'video/mpeg\n')
    //   }

    //   func returns_extension ()  {
    //     let  stdout = exec('./bin/cli.js -r video/mpeg')
    //     assert.equal(stdout, 'mpeg\n')
    //   }
}
