import {Feedback} from './StarEvaluation' //引入5星评价组件
import {CustomDialogUser} from './CustomDialog' //引入弹窗组件


//提问问题和问题答案的样式,例如“您的毕业时间”的样式，“2021-1-1”的样式
@Extend(Text) function textStyle(){
  .fontColor(Color.Orange)
  .fontSize(20)
}
//填写问题答案的样式，例如图中填写毕业时间和滑动条的区域
@Styles function questionStyle(){
  .width('100%')
  .backgroundColor('#fff6ce67')
}
//提问问题区域样式
@Extend(Row) function questionAreaStyle(){
  .width('100%')
  .margin({top:15, bottom: 15})
  .padding({top: 10, bottom: 10})
  .justifyContent(FlexAlign.SpaceBetween)
}


//入口组件
@Entry
@Component
struct WorkPage {
  @State year: number = 2024
  @State month: number = 1
  @State day: number = 1
  @State salary: number = 5000
  // @State evaluate: number = 0
  @State totalScore: number = 6//总评分

  build(){
    Column() {
      // 1. 标题 -- 毕业生满意度调查表
      Row(){
        Text('毕业生满意度调查表')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#fff')
      }
      .width('100%')
      .backgroundColor(Color.Black)
      .padding({top: 20, bottom: 20})



      //2. 毕业时间 -- 填写毕业时间
      Row(){
        this.QuestionNaire('您的毕业时间？')
        Text(`${this.year}-${this.month}-${this.day}`)
          .textStyle()
      }
      .questionAreaStyle()
      this.Divider()//分隔线
      Row(){
        this.DateComponent(this.year, '年')
        this.DateComponent(this.month, '月')
        this.DateComponent(this.day, '日')
      }
      .questionStyle()
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({top:20, bottom:20})



      //3. 薪资水平 -- 填写薪资水平
      Row(){
        this.QuestionNaire('您的薪资水平？')
        Text(`${this.salary}-${this.salary + 10000}`)
          .textStyle()
      }
      .questionAreaStyle()
      this.Divider()//分隔线
      Row(){
        Slider({
          value: this.salary,
          min: 5000,
          max: 30000
        })
          .width('80%')
          .onChange((value) => {
            this.salary = parseInt(value.toFixed(0))
          })
      }
      .questionStyle()
      .justifyContent(FlexAlign.Center)



      //4. 调查表--总体满意度--五星评价
      Row(){
        this.QuestionNaire('您的总体满意度？')
        Text(`${this.totalScore > 10 ? '满意' : (this.totalScore >=6 ? '一般' : '差评' )}`)
          .textStyle()
      }
      .questionAreaStyle()
      this.Divider()
      Feedback({totalScore: $totalScore})


      //5.提交按钮
      CustomDialogUser({year: $year, month: $month, day: $day, salary: $salary, totalScore: $totalScore})


    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fff6f1dd')
  }




  //一、询问问题组件
  @Builder QuestionNaire(question: string){
    Row(){
      Text(`${question}`)
        .textStyle()
    }
  }

  //二、分割线组件
  @Builder Divider(){
    Divider()
      .questionStyle()
      .strokeWidth(5)
      .margin({bottom: 15})
  }


  //三、日期组件
  @Builder DateComponent(date: number, cdate: string) {
    TextInput({
      text: date.toString(),
    })
      .width('20%')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor('#cc145579')
      .borderRadius(0)
      .onChange((value) => {
        if(cdate === '年'){
          this.year = parseInt(value)
        } else if(cdate === '月') {
          this.month = parseInt(value)
        } else {
          this.day = parseInt(value)
        }
      })
    Text(`${cdate}`)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
  }


}