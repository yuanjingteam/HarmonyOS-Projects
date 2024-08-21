import { router } from '@kit.ArkUI'
import { itemsInter } from '../model/DataContent'
import Constants from '../common/Constants'
import LanguageItem from '../view/LanguageItem'

@Entry
@Component
struct LanguageChoice {
  items: itemsInter[] = Constants.languageItem

  build() {
    Column({ space: 30 }) {
      Text('语种选择 : ')
        .LanguageChoice_text()
      List({ space: 10 }) {
        ForEach(this.items, (item: itemsInter) => {
          ListItem() {
            LanguageItem({ item })
              .onClick(() => {
                // 将选择的那个语种存起来
                AppStorage.setOrCreate('lang', item.lang)
                router.back()
              })
          }
        })
      }
      .LanguageChoice_list()
    }
    .LanguageChoice_column()
  }
}


// 设置文本的样式
@Extend(Text)
function LanguageChoice_text() {
  .fontSize(20)
  .fontWeight(FontWeight.Bold)
  .fontColor(Color.Black)
  .margin({
    top: 10
  })
}

// 设置整个页面列的样式
@Extend(Column)
function LanguageChoice_column() {
  .width('100%')
  .height('100%')
  .backgroundColor('#ffe3e7e7')
  .justifyContent(FlexAlign.Center)
}

// 设置每一条的样式
@Extend(List)
function LanguageChoice_list() {
  .layoutWeight(1)
  .width('100%')
  .height('100%')
}