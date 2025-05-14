// 3rd_party_lib:mime4cj/target/release/mime

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import mime.*

@Test
public class TestMime04 {
    @TestCase
    func test_Mime_04_01(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_01,false)
        @Assert(mime_02.getType("h"),"text/plain")
    }
    @TestCase
    func test_Mime_04_02(): Unit {
        var mime_02=Mime(Array<TypeMap>())
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        mime_02.define(typeMap_02,false)
        @Assert(mime_02.getType("h").isNone(),true)
    }
    @TestCase
    func test_Mime_04_03(): Unit {
        var typeMap_03:TypeMap=HashMap<String, Array<String>>()
        typeMap_03.add("123",["1","2","3"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_03,false)
        @Assert(mime_02.getType("1"),"123")
    }
    @TestCase
    func test_Mime_04_04(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_01,false)
        mime_02.define(typeMap_01,false)
        @Assert(mime_02.getType("h"),"text/plain")
    }
    @TestCase
    func test_Mime_04_05(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        typeMap_02.add("text/plain",["h"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_01,false)
        @Assert(mime_02.getType("h"),"text/plain")
        mime_02.define(typeMap_02,false)
        @Assert(mime_02.getType("h"),"text/plain")
        @Assert(mime_02.getType("txt"),"text/plain")
    }
    @TestCase
    func test_Mime_04_06(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        typeMap_02.add("text/pl",["h"])
        var mime_02=Mime([typeMap_01])
        let e1:IllegalStateException=@AssertThrows[IllegalStateException](mime_02.define(typeMap_02,false))
        @Assert(e1.toString(),"IllegalStateException: \"text/pl -> h\" conflicts with \"Some(text/plain) -> h\". Pass `force=true` to override this definition.")
        typeMap_02.add("text/plain",["h"])
        @Assert(mime_02.getType("h"),"text/plain")
    }
    @TestCase
    func test_Mime_04_07(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","abcf","bas","c"])
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        typeMap_02.add("text/plain",["h"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_02,false)
        mime_02.define(typeMap_01,false)
        @Assert(mime_02.getType("h"),"text/plain")
        @Assert(mime_02.getType("abcf"),"text/plain")
    }
}