// EXEC: cjc %import-path %L %l %f --test
// EXEC: ./main 
//--bench
//--filter=*.Consistency
import mime.*
import std.collection.*

@Test
public func cold(): Unit {
    let m = MIME
}

@Test
@Bench
public func ext(): Unit {
    MIME.getExtension('image/jpeg')
}

