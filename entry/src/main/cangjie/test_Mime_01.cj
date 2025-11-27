package ohos_app_cangjie_entry

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import mime.*

@Test
public class TestMime01 {

    @TestCase
    func test_Mime_01_01(): Unit {
        var mime_01=Mime(Array<TypeMap>())
        @Assert(mime_01.getType("h").isNone(),true)
    }
    @TestCase
    func test_Mime_01_02(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var arrs:Array<TypeMap>=[typeMap_01]
        var mime_02=Mime(arrs)
        @Assert(mime_02.getType("h"),"text/plain")
        @Assert(mime_02.getType("txt"),"text/plain")
        @Assert(mime_02.getType("ras").isNone(),true)
    }
    @TestCase
    func test_Mime_01_03(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var arrs:Array<TypeMap>=[typeMap_01]
        var mime_02=Mime(arrs)
        @Assert(mime_02.getType("./ext.txt"),"text/plain")
        @Assert(mime_02.getType("./ext.bas"),"text/plain")
        @Assert(mime_02.getType("./ext.c"),"text/plain")
        @Assert(mime_02.getType("./ext.h"),"text/plain")
    }
    @TestCase
    func test_Mime_01_04(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var arrs:Array<TypeMap>=[typeMap_01]
        var mime_02=Mime(arrs)
        @Assert(mime_02.getType("./ext.ras").isNone(),true)
    }
    @TestCase
    func test_Mime_01_05(): Unit {
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        typeMap_01.add("text/plain",["h","txt","bas","c"])
        var arrs:Array<TypeMap>=[typeMap_01]
        var mime_02=Mime(arrs)
        @Assert(mime_02.getType("../../ext.cj").isNone(),true)
    }
}