export declare class MimeArkts {
    define1(typeMap: Map<string, Array<string>>, force: boolean): MimeArkts
    define(typeMap: Map<string, Array<string>>): MimeArkts
    getType(path: string): string | undefined
    getExtension(typ: string): string | undefined
    getAllExtensions(typ: string): Array<string> | undefined
}

export declare interface CustomLib {
    mimeAll(): MimeArkts
    mimeLite(): MimeArkts
    MimeArkts: {new (args: Array<Map<string, Array<string>>>): MimeArkts}
}