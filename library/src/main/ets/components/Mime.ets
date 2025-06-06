import { requireCJLib } from "libark_interop_loader.so";
import { register_hsp_api } from 'cjhyapiregister';

register_hsp_api()

interface CJLib {
  mimeAll(): Object

  mimeLite(): Object
}

export declare class MimeArk {
  define1(typeMap: Map<string, Array<string>>, force: boolean): Object

  define(typeMap: Map<string, Array<string>>): Object

  getType(path: string): string | undefined

  getExtension(typ: string): string | undefined

  getAllExtensions(typ: string): Array<string> | undefined
}

interface CustomLib {
  MimeArk: Object
}

export class Mime {
  lib = requireCJLib("libmime.so") as CustomLib
  mime: MimeArk

  constructor(args: Array<Map<string, Array<string>>>) {
    this.mime = new (this.lib.MimeArk as (args: Array<Map<string, Array<string>>>) => void)(args) as MimeArk
  }

  define1(typeMap: Map<string, Array<string>>, force: boolean): MimeArk {
    return this.mime.define1(typeMap, force) as MimeArk
  }

  define(typeMap: Map<string, Array<string>>): MimeArk {
    return this.mime.define(typeMap) as MimeArk
  }

  getType(path: string): string | undefined {
    return this.mime.getType(path)
  }

  getExtension(typ: string): string | undefined {
    return this.mime.getExtension(typ)
  }

  getAllExtensions(typ: string): Array<string> | undefined {
    return this.mime.getAllExtensions(typ)
  }
}

export function mimeAll(): MimeArk {
  let lib = requireCJLib("libmime.so") as CJLib
  return lib.mimeAll() as MimeArk
}

export function mimeLite(): MimeArk {
  let lib = requireCJLib("libmime.so") as CJLib
  return lib.mimeLite() as MimeArk
}