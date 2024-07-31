@Component
export struct Feedback{
  @State rating: number[] = [3,3,3] //每个问题的评分
  @State indicator: boolean = false
  @Link totalScore: number //总评分
  build(){
    Column() {
      ForEach(['课程设置','任课教师','条件设施'],(item, index) => {
        //评价条项
        Row(){
          Text(`${item}`)
            .fontSize(20)
          Text(`${this.rating[index]}分`)
            .fontSize(20)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        //星星评价
        Rating({rating:this.rating[index], indicator: this.indicator})
          .stars(5)
          .stepSize(0.5)
          .onChange((value) => {
            this.rating[index] = value
            this.totalScore = 0
            for(const score of this.rating){
              this.totalScore += score
            }
          })
          .margin({top: 5, bottom: 20})
      })

    }
    .width('100%')
  }

}