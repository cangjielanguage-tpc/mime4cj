<div align="center">
<h1>mime4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.0.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v1.0.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-99.6%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

用于 MIME 类型信息的 API

### 特性

- 🚀 支持 所有`mime-db`类型
- 🚀 支持 无额外依赖

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 源码目录

```shell
.
├── README.md
├── doc
├── test
└── src
```

- `doc`存放库的设计文档、提案、库的使用文档
- `test`存放用例
- `src`存放库源码目录

### 接口说明

主要是核心类和成员函数说明，详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译（win/linux）

```shell
cjpm build
```

### 示例

#### 完整版（800+ MIME 类型，1,000+ 扩展名）

```cj
import mime.*

MIME.getType('txt')                     // ⇨ 'text/plain'
MIME.getExtension('text/plain')         // ⇨ 'txt'
```

#### 精简版

`MIME_LITE`是轻量级替代版本，移除了非官方类型（如 "prs."、"x-" 和 "vnd.*" 前缀的 MIME 类型）

```cj
import MIME.*

MIME_LITE.getType('txt')                     // ⇨ 'text/plain'
MIME_LITE.getExtension('text/plain')         // ⇨ 'txt'
```

#### `MIME.getType(pathOrExtension)`

使用指定`文件路径`或`extension`获取`mime type`

```cj
MIME.getType('js')             // ⇨ 'text/javascript'
MIME.getType('json')           // ⇨ 'application/json'

MIME.getType('txt')            // ⇨ 'text/plain'
MIME.getType('dir/text.txt')   // ⇨ 'text/plain'
MIME.getType('dir\\text.txt')  // ⇨ 'text/plain'
MIME.getType('.text.txt')      // ⇨ 'text/plain'
MIME.getType('.txt')           // ⇨ 'text/plain'
```

若extension未检测到或未经验证 返回`None`

```cj
MIME.getType('foo/txt')         // ⇨ None
MIME.getType('bogus_type')      // ⇨ None
```

#### `MIME.getExtension(type)`

根据指定的 MIME 类型获取对应的文件扩展名，自动忽略字符集参数（常见于 Content-Type 头信息）

```cj
MIME.getExtension('text/plain')                // ⇨ 'txt'
MIME.getExtension('application/json')          // ⇨ 'json'
MIME.getExtension('text/html; charset=utf8')   // ⇨ 'html'
```

#### `MIME.getAllExtensions(type)`

获取指定 MIME 类型对应的所有文件扩展名

```cj
MIME.getAllExtensions('image/jpeg')  // ⇨ [ 'jpeg', 'jpg', 'jpe' ]
```

#### 自定义`Mime`对象

默认`mime`对象不可更改, 创建自定义`mime`对象.

```cj
let customTypes : HashMap<String,Array<String>> = HashMap()
let mime = Mime(customTypes)
```

每个参数都会被传递给下方的 `define()` 方法。例如，`Mime(standardTypes, otherTypes)` 等同于 `Mime().define(standardTypes).define(otherTypes)`

#### 定义`type->extensions`映射

定义 MIME type -> extensions.

尝试将类型映射到已定义的扩展名时会抛出错误，除非将 force 参数设为 true。

```cj
...
mime.define(HashMap([('text/x-abc', ['abc', 'abcd'])]))

mime.getType('abcd')             // ⇨ 'text/x-abc'
mime.getExtension('text/x-abc')  // ⇨ 'abc'
```

## 开源协议

本项目基于 [MIT License](LICENSE) , 请自由享受和参与开源

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。

Contributor: [@chenyunda218](https://gitcode.com/chenyunda218)
