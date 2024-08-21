import { itemsInter } from '../model/DataContent'

@Component
export default struct LanguageItem {
  item: itemsInter = {
    lang: 'en',
    chinese: '英文'
  }

  build() {
    Row() {
      Text(this.item.chinese)
    }
    .LanguageItem_row()
  }
}

@Extend(Row)
function LanguageItem_row() {
  .justifyContent(FlexAlign.Center)
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .margin({
    left: 5
  })
  .shadow({
    radius: 6,
    color: '#1F000000',
    offsetX: 2,
    offsetY: 4
  })
}
