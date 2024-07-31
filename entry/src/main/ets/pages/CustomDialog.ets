//调查问题样式
@Extend(Text) function questionStyle(){
  .width('100%')
  .fontSize(16)
  .margin({ bottom: 10 ,left: 80})
}


//弹窗组件
@CustomDialog
export struct CustomDialogExample {
  @Link year: number
  @Link month: number
  @Link day: number
  @Link salary: number
  @Link totalScore: number //总评分

  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  build() {
    Column() {
      Text('反馈结果')
        .width('100%')
        .fontSize(20)
        .margin({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
        .fontColor(Color.Orange)

      Text(`您的毕业时间：${this.year}-${this.month}-${this.day}`)
        .questionStyle()
      Text(`您的薪资水平：${this.salary}-${this.salary + 10000}`)
        .questionStyle()
      Text(`您的总体满意度：${this.totalScore > 10 ? '满意' : (this.totalScore >=6 ? '一般' : '差评' )}`)
        .questionStyle()

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Orange)
        Button('确认')
          .onClick(() => {
            this.controller.close()
            this.confirm()
          })
          .backgroundColor(0xffffff)
          .fontColor(Color.Orange)
      }.margin({ bottom: 10 })
    }
  }
}


@Component
export struct CustomDialogUser {
  @Link year: number
  @Link month: number
  @Link day: number
  @Link salary: number
  @Link totalScore: number //总评分

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({ cancel: this.onCancel, confirm: this.onAccept, year: $year, month: $month, day: $day, salary: $salary, totalScore: $totalScore }),
    cancel: this.existApp,
    autoCancel: true,       //点击空白处退出弹窗 false不退出，true退出
    alignment: DialogAlignment.Bottom ,  //垂直底部对齐
    offset:{dx:0,dy:-30}                 //需要注意的是弹窗从底部往上移取负值
  })

  onCancel() {
    console.info('点击取消按钮时的回调')
  }
  onAccept() {
    console.info('单击确认按钮时的回调')
  }
  existApp() {
    console.info('点击空白处的回调')
  }

  build() {
    Column() {
      Button('提交')
        .onClick(() => {
          //open() 打开自定义弹窗
          this.dialogController.open()
        })
        .width('100%')
        .backgroundColor('#fff6ce67')
        .fontColor('#36D')
    }
    .width('100%')
    .margin({ top: 5 })
  }
}