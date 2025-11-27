package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

@Entry
@Component
class EntryView {
    @State
    var message: String = "Hello World"
    func build() {
        Column {
            Flex(FlexParams(alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap)){
                Button("TestMime01_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime01().test_Mime_01_01()}
                Button("TestMime01_2").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime01().test_Mime_01_02()}
                Button("TestMime01_3").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime01().test_Mime_01_03()}
                Button("TestMime01_4").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime01().test_Mime_01_04()}
                Button("TestMime01_5").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime01().test_Mime_01_05()}
                Button("TestMime02_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_01()}
                Button("TestMime02_2").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_02()}
                Button("TestMime02_3").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_03()}
                Button("TestMime02_4").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_04()}
                Button("TestMime02_5").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_05()}
                Button("TestMime02_6").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_06()}
                Button("TestMime02_7").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime02().test_Mime_02_07()}
                Button("TestMime03_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_01()}
                Button("TestMime03_2").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_02()}
                Button("TestMime03_3").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_03()}
                Button("TestMime03_4").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_04()}
                Button("TestMime03_5").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_05()}
                Button("TestMime03_6").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_06()}
                Button("TestMime03_7").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime03().test_Mime_03_07()}
                Button("TestMime04_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_01()}
                Button("TestMime04_2").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_02()}
                Button("TestMime04_3").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_03()}
                Button("TestMime04_4").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_04()}
                Button("TestMime04_5").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_05()}
                Button("TestMime04_6").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_06()}
                Button("TestMime04_7").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime04().test_Mime_04_07()}

                Button("TestMime05_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime05().test_Mime_05_01()}
                Button("TestMime06_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime06().test_Mime_06_01()}
                Button("TestMime07_1").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime07().test_Mime_07_01()}
                Button("TestMime07_2").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime07().test_Mime_07_02()}
                Button("TestMime07_3").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime07().test_Mime_07_03()}
                Button("TestMime07_4").height(25).margin(2).fontColor(Color.BLACK).backgroundColor(0x87CEEB).onClick{ evt => TestMime07().test_Mime_07_04()}
            }


        }.width(100.percent)
    }
}
