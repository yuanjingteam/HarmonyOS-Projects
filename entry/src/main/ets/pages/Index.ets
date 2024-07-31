
//任务类
@Observed
class Task{
  static id: number = 1
  //任务名称
  name: string = `任务${Task.id++}`
  //任务状态：是否完成
  finished: boolean = false
}

//统一的卡片样式
@Styles function  card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}

//任务完成样式
@Extend(Text) function finishedTask() {
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor('#B1B2B3')
  .fontSize(20)
}




@Entry
@Component
struct  ProPage{
  //总任务数量
  @State totalTask: number = 0
  //已完成任务数量
  @State finishTask: number = 0
  //任务数组
  @State tasks: Task[] = []


  handleTaskChange(){
    //1. 更新任务总数量
    this.totalTask = this.tasks.length
    //2.更新已完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length
  }


  build() {
    Column({space: 10}) {
      //1.任务进度卡片
      // Row(){
      //   Back()
      // }
      Row(){
        Text('任务进度:')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Stack(){
          Progress({
            value: this.finishTask,
            total: this.totalTask,
            type: ProgressType.Ring
          })
            .width(100)
          Row(){
            Text(`${this.finishTask}`)
              .fontSize(24)
              .fontColor('#36D')
            Text(' / ' + this.totalTask.toString())
              .fontSize(24)
          }
        }

      }
      .card()
      .margin({top: 20, bottom: 10})
      .justifyContent(FlexAlign.SpaceEvenly)


      //2.新增任务按钮
      Button(`新增任务`)
        .width(200)
        .onClick(() => {
          //任务数组变化
          this.tasks.push(new Task())
          //任务总量变化
          this.handleTaskChange()
        })
        .margin({bottom: 10})


      //3.任务列表
      List({space: 10}){
        ForEach(this.tasks, (item: Task, index) => {
          ListItem() {
            TaskItem({ item: item ,onTaskChange: this.handleTaskChange.bind(this)})
          }
          .swipeAction({end: this.DeleteButton(index)})
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

  @Builder DeleteButton(index) {
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(25)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      this.tasks.splice(index, 1)
      this.handleTaskChange()
    })
  }


}



@Component
struct TaskItem {
  @ObjectLink item: Task
  onTaskChange: () => void
  build(){
    Row(){
      if(this.item.finished){
        Text(this.item.name)
          .finishedTask()
      } else {
        Text(this.item.name)
          .fontSize(20)
      }

      Checkbox()
        .select(this.item.finished)
        .onChange(value => {
          this.item.finished = value
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}