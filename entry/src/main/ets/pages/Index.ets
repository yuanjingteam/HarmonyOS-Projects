import Constants from '../common/Constants';
import History from '../view/History';
import Translate from '../view/Translate';

@Entry
@Component
struct Index {
  // 用来标记当前使用的是什么语言进行翻译
  @State lang: string = Constants.lang;
  // 用来标记当前点击的是哪个 tab 栏
  @State currentIndex: number = 0

  // index 页面重新展示的时候，修改 lang
  onPageShow() {
    this.lang = AppStorage.get('lang') || Constants.lang
  }

  build() {
    Column() {
      Text($r('app.string.EntryAbility_label')).Index_text()
      Tabs() {
        // 翻译栏
        TabContent() {
          Translate({ lang: this.lang })
        }.tabBar($r('app.string.tab1'))

        // 历史栏
        TabContent() {
          History({ curIndex: this.currentIndex })
        }.tabBar($r('app.string.tab2'))
      }
      .backgroundColor('#eee')
      .onChange((index) => {
        this.currentIndex = index
      })
    }
    .Index_column()
  }
}

// 设置整个页面的样式
@Extend(Column)
function Index_column() {
  .width('100%')
  .height('100%')
  .backgroundColor($r('app.color.app_theme'))
}

// 设置文本的样式
@Extend(Text)
function Index_text() {
  .fontColor($r('app.color.main_text'))
  .fontWeight(FontWeight.Bold)
  .fontSize(30)
  .margin({
    top: 15,
    bottom: 10
  })
}
