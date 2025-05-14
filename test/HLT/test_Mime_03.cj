// 3rd_party_lib:mime4cj/target/release/mime

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import mime.*

@Test
public class TestMime03 {
    @TestCase
    func test_Mime_03_01(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_01,true)
        @Assert(mime_02.getType("h"),"text/plain")
    }
    @TestCase
    func test_Mime_03_02(): Unit {
        var mime_02=Mime(Array<TypeMap>())
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        mime_02.define(typeMap_02,true)
        @Assert(mime_02.getType("h").isNone(),true)
    }
    @TestCase
    func test_Mime_03_03(): Unit {
        var typeMap_03:TypeMap=HashMap<String, Array<String>>()
        typeMap_03.add("123",["1","2","3"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_03,true)
        @Assert(mime_02.getType("1"),"123")
    }
    @TestCase
    func test_Mime_03_04(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_01,true)
        mime_02.define(typeMap_01,true)
        @Assert(mime_02.getType("h"),"text/plain")
    }
    @TestCase
    func test_Mime_03_05(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        typeMap_02.add("text/plain",["h"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_01,true)
        mime_02.define(typeMap_02,true)
        @Assert(mime_02.getType("h"),"text/plain")
        @Assert(mime_02.getType("txt"),"text/plain")
    }
    @TestCase
    func test_Mime_03_06(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        typeMap_02.add("text/pl",["h"])
        var mime_02=Mime([typeMap_01])
        mime_02.define(typeMap_02,true)
        @Assert(mime_02.getType("h"),"text/pl")
    }
    @TestCase
    func test_Mime_03_07(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","abcf","bas","c"])
        var typeMap_02:TypeMap=HashMap<String, Array<String>>()
        typeMap_02.add("text/plain",["h"])
        var mime_02=Mime(Array<TypeMap>())
        mime_02.define(typeMap_02,true)
        mime_02.define(typeMap_01,true)
        @Assert(mime_02.getType("h"),"text/plain")
        @Assert(mime_02.getType("abcf"),"text/plain")
    }
}