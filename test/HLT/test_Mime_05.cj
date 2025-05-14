// 3rd_party_lib:mime4cj/target/release/mime

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import mime.*

@Test
public class TestMime05 {
    @TestCase
    func test_Mime_05_01(): Unit {
        var mime_01=Mime(Array<TypeMap>())
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        typeMap_01.add("application/octet-stream",["*","bin","class","dms","exe","lha","lzh"])
        typeMap_01.add("image/gif",["*gif"])
        mime_01.define(typeMap_01)

        @Assert(mime_01.getExtension("application").isNone(),true)
        @Assert(mime_01.getExtension("text").isNone(),true)
        @Assert(mime_01.getExtension("text/plain"),"h")
        @Assert(mime_01.getExtension("image/gif"),"gif")
    }

}