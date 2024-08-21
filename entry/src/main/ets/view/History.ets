import { translateInter } from '../model/DataContent'
import { getHistoryRecord } from '../utils/AllUtils'

@Component
export default struct History {
  // 用来拿到所有翻译的历史记录
  @State historyList: translateInter[] = []
  // 用来标识当前为哪个页面，index 值为 1 时表示当前在历史记录界面
  @Prop @Watch('changeIndex') curIndex: number

  // 用来监听当前 index 的值，如果为 1 ，再去拿到所有的翻译历史记录
  changeIndex() {
    if (this.curIndex === 1) {
      this.historyList = getHistoryRecord()
    }
  }

  build() {
    Column() {
      Text('翻译记录')
        .History_text()
      List({ space: 10 }) {
        ForEach(this.historyList, (item: translateInter, index: number) => {
          ListItem() {
            Row({ space: 10 }) {
              Text(`${index}`)
              Text(item.src)
              Text(item.dst)
              Text(item.to)
            }
            .History_row()
          }
        })
      }
      .History_list()
    }
  }
}

// 设置顶部翻译记录样式
@Extend(Text)
function History_text() {
  .fontSize(20)
  .fontWeight(FontWeight.Bold)
  .opacity(0.6)
  .margin({
    bottom: 10
  })
}

// 设置 list 列表样式
@Extend(List)
function History_list() {
  .layoutWeight(1)
  .width('90%')
  .height('100%')
}

// 设置 listItem 中 row 的列表样式
@Extend(Row)
function History_row() {
  .width('100%')
  .height(30)
  .justifyContent(FlexAlign.SpaceAround)
  .backgroundColor('#ffe3e2e2')
}
