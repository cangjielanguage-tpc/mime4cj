// 3rd_party_lib:mime4cj/target/release/mime

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import mime.*

@Test
public class TestMime06 {
    @TestCase
    func test_Mime_06_01(): Unit {
        var mime_01=Mime(Array<TypeMap>())

        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        typeMap_01.add("application/octet-stream",["*","bin","class","dms","exe","lha","lzh"])
        typeMap_01.add("image/gif",["*gif","p*ng","jpeg*"])
        mime_01.define(typeMap_01)

        @Assert(mime_01.getAllExtensions("application").isNone(),true)
        @Assert(mime_01.getAllExtensions("text").isNone(),true)
        @Assert(mime_01.getAllExtensions("text/plain").getOrThrow().toArray(),typeMap_01.get("text/plain"))
        var exp=["","bin","class","dms","exe","lha","lzh"]
        @Assert(mime_01.getAllExtensions("application/octet-stream").getOrThrow().toArray(),exp)
        exp=["gif","p*ng","jpeg*"]
        @Assert(mime_01.getAllExtensions("image/gif").getOrThrow().toArray(),exp)
    }
}