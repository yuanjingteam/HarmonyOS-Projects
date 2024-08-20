// 设置整个页面的样式
import { router } from '@kit.ArkUI'

@Styles function videoIndex_column(){
  .width('100%')
  .height('100%')
}

@Entry
@Component
struct videoIndex {
  @State msg:string = '阶段案例'
  build() {
    Column(){
      Text(this.msg).fontSize(20).margin({top:20})
      Button('点击进入').width('60%').margin({top:40})
        .onClick(() => {
          router.pushUrl({
            url: "pages/videoPlay"
          })
        })
    }
    .videoIndex_column()
  }
}

