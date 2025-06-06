import hilog from '@ohos.hilog';
import { mimeAll } from 'library/src/main/ets/components/Mime';
import { systemDateTime } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  MIME = mimeAll()

  build() {
    Column() {
      Button("getType10").onClick(() => {
        let startTime = systemDateTime.getTime(true)
        for (let i = 0; i < 10; i++) {
          this.MIME.getType("dir/text.txt")
        }
        for (let j = 0; j < 10; j++) {
          this.MIME.getType("local/textPng.png")
        }
        let endTime = systemDateTime.getTime(true)
        console.error(`mime parse 10 函数执行时间: ${(endTime - startTime) / 10} ns/op`)
      })

      Button("getType100").onClick(() => {
        let startTime = systemDateTime.getTime(true)
        for (let i = 0; i < 100; i++) {
          this.MIME.getType("dir/text.txt")
        }
        for (let j = 0; j < 100; j++) {
          this.MIME.getType("local/textPng.png")
        }
        let endTime = systemDateTime.getTime(true)
        console.error(`mime parse 100 函数执行时间: ${(endTime - startTime) / 100} ns/op`)
      })

      Button("getType1000").onClick(() => {
        let startTime = systemDateTime.getTime(true)
        for (let i = 0; i < 1000; i++) {
          this.MIME.getType("dir/text.txt")
        }
        for (let j = 0; j < 1000; j++) {
          this.MIME.getType("local/textPng.png")
        }
        let endTime = systemDateTime.getTime(true)
        console.error(`mime parse 1000 函数执行时间: ${(endTime - startTime) / 1000} ns/op`)
      })

      Button("getType10000").onClick(() => {
        let startTime = systemDateTime.getTime(true)
        for (let i = 0; i < 10000; i++) {
          this.MIME.getType("dir/text.txt")
        }
        for (let j = 0; j < 10000; j++) {
          this.MIME.getType("local/textPng.png")
        }
        let endTime = systemDateTime.getTime(true)
        console.error(`mime parse 10000 函数执行时间: ${(endTime - startTime) / 10000} ns/op`)
      })
    }
    .height('100%')
    .width('100%')
  }
}
