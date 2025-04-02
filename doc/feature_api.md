# mime

## API

```cj
MIME // 不可更改的全局全量MIME对象
MIME_LITE // 不可更改的全局liteMIME对象

/**
 * mime信息 type-extensions键值对
 */
public type TypeMap = HashMap<String, Array<String>>

/**
 * 可自定义的MIME对象
 */
public class Mime{
    /*
     * 构造函数
     * @param args mime信息
     */
    public init(args: Array<TypeMap>)
    /**
     * 定义 MIME 类型 -> 文件扩展名映射。每个键为 MIME 类型，映射到该类型关联的扩展名数组。
     * 数组第一个扩展名将作为该类型的默认扩展名。
     *
     * 示例：mime.define({'audio/ogg': ['oga', 'ogg', 'spx']})
     *
     * 若扩展名映射已存在，将抛出错误。设置 `force` 参数为 `true` 可强制覆盖。
     *
     * 示例：mime.define({'audio/wav': ['wav']}, {'audio/x-wav': ['*wav']})
     *
     * @param typeMap mime信息
     * @param force 覆盖
     */
    public func define(typeMap: TypeMap, force: Bool): Mime
    /*
     * 定义mime 默认不覆盖
     * @param typeMap mime信息
     */
    public func define(typeMap: TypeMap): Mime
    /*
     * 根据extension获取type
     * @param path 包含extension信息的path
     */
    public func getType(path: String): ?String
    /*
     * 根据type获取默认extension
     * @param typ type
     */
    public func getExtension(typ: String): ?String
    /*
     * 根据type获取所有extension
     * @param typ type
     */
    public func getAllExtensions(typ: String): ?Set<String>
}
```
