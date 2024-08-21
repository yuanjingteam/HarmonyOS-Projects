import { router } from '@kit.ArkUI'
import { translateInter } from '../model/DataContent'
import { getLanguageText, getTranslated, saveTranslateRecord } from '../utils/AllUtils'

@Component
export default struct Translate {
  // 文本框数据
  @State inputText: string = ''
  // 翻译后的数据
  @State translated: string = ''
  // 父子组件通信
  @Prop lang: string

  build() {
    Column({ space: 15 }) {
      Row() {
        Text('目标语种 : ' + getLanguageText(this.lang))
          .Translate_text()
        Image($r('app.media.down'))
          .Translate_image()
      }
      .onClick(() => {
        router.pushUrl({
          url: "pages/LanguageChoice"
        })
      })

      TextInput({ text: this.inputText, placeholder: '请输入待翻译的文本~' })
        .onChange((value) => {
          this.inputText = value
        })
        .Translate_textInput()

      Row({ space: 10 }) {
        Button('点击翻译')
          .onClick(async () => {
            // 调用工具函数，得到翻译结果
            let result: translateInter = await getTranslated(this.inputText, this.lang)
            this.translated = result.dst
            // 调用工具函数，将数据保存起来，以便在历史记录里面使用
            saveTranslateRecord(result)
          })
        Button('百度翻译')
      }
      .Translate_row()

      TextInput({ text: this.translated, placeholder: '翻译结果' })
        .Translate_textInput()
    }
  }
}

// 设置文本样式
@Extend(Text)
function Translate_text() {
  .fontSize(18)
  .fontColor(Color.Grey)
}

// 设置图标样式
@Extend(Image)
function Translate_image() {
  .width(30)
  .height(30)
  // .fillColor('#ffe91919')  // 可以用来设置 svg 图标的颜色
}

// 设置文本框样式
@Extend(TextInput)
function Translate_textInput() {
  .width('80%')
  .height(200)
}

// 设置按钮整行样式
@Extend(Row)
function Translate_row() {
  .width('85%')
  .padding(20)
  .justifyContent(FlexAlign.SpaceAround)
}