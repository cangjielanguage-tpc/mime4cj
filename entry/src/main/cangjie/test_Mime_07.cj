package ohos_app_cangjie_entry

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import mime.*
@Test
public class TestMime07 {
    @TestCase
    func test_Mime_07_01(): Unit {
        testLogic(content_type)
    }
    @TestCase
    func test_Mime_07_02(): Unit {
        testLogic(mime_base)
    }
    @TestCase
    func test_Mime_07_03(): Unit {
        testLogic(mime_content)
    }
    @TestCase
    func test_Mime_07_04(): Unit {
        testLogic(mime_file)
    }
    func testLogic(arr:Array<(String,String)>){
        var mime_01=Mime(Array<TypeMap>())
        var typeMap_01:TypeMap=HashMap<String, Array<String>>()
        var exts:Set<String>=HashSet<String>()
        var typeMime="null"
        var ext="null"
        var extOri="null"
        for (ele in arr){
            mime_01=Mime(Array<TypeMap>())
            typeMime=ele[0]
            extOri=ele[1]
            var tmp:Array<String>=[extOri]
            typeMap_01=HashMap<String, Array<String>>()
            typeMap_01.add(typeMime,tmp)
            mime_01.define(typeMap_01)
            exts= mime_01.getAllExtensions(typeMime).getOrThrow()
            if(extOri.startsWith("*")){
                ext=extOri[1..extOri.size].toAsciiLower()
            }else{
                ext=extOri.toAsciiLower()
            }
            @Assert(exts.contains(ext),true)
        }
    }
}

