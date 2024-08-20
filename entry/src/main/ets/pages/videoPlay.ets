import { router } from '@kit.ArkUI'
// 定义图片接口
interface imageInter{
  url:string,
  count:number
}
// 生肖抽奖页面样式
@Extend(Column) function videoPlay_column1(){
  .width('100%')
  .height('100%')
}
// 抽奖卡片弹层页面样式
@Extend(Column) function videoPlay_column2(scOpacity:number,scZIndex:number){
  .videoPlay_column1()
  .backgroundColor('#d91f1e1e')
  .justifyContent(FlexAlign.Center)
  .zIndex(scZIndex)
  .opacity(scOpacity)
  .animation({
    duration:200
  })
}
// 抽奖奖品弹层页面样式
@Extend(Column) function videoPlay_column3(){
  .videoPlay_column1()
  .opacity(1)
  .backgroundColor('#d91f1e1e')
  .justifyContent(FlexAlign.Center)
  .animation({
    duration:200
  })
}

@Entry
@Component
struct videoPlay{
  // 标识当前按钮为 立即抽卡 还是 立即抽奖
  @State flagBtn:boolean = true
  // 生肖抽卡图片数组
  @State img:imageInter[] = [
    {url:'bg_00',count:0},
    {url:'bg_01',count:0},
    {url:'bg_02',count:0},
    {url:'bg_03',count:0},
    {url:'bg_04',count:0},
    {url:'bg_05',count:0}
  ]
  // 大奖奖池
  @State awardArr:string[] = ['pg','hw','xm']
  // 获得的大奖的名称
  @State awardName:string = ''
  // 设置当前抽奖卡片弹层的透明度
  @State maskOpacity:number = 0
  // 设置当前抽奖卡片弹层的层级
  @State maskZIndex:number = -1
  // 设置抽奖卡片弹层中图片缩放的 x 轴大小
  @State imgX:number = 0
  // 设置抽奖卡片弹层中图片缩放的 y 轴大小
  @State imgY:number = 0
  // 设置当前抽奖卡片中是哪张图片 默认从1开始
  @State imgIndex:number = 1
  // 设置抽奖奖品中图片缩放的 x 轴大小
  @State awardImgX:number = 0
  // 设置抽奖奖品中图片缩放的 y 轴大小
  @State awardImgY:number = 0
  // 用来设置中大奖页面的显示与隐藏
  @State isShow:boolean = false
  build() {
    Stack(){
      // 抽奖的页面
      Column(){
        Text('生肖抽卡').fontSize(20).margin({top:30})
          .onClick(() => {
            router.back()
          })
        Grid(){
          ForEach(this.img,(item:imageInter) => {
            GridItem(){
              Badge({
                count:item.count,
                position:BadgePosition.RightTop,
                style:{
                  fontSize:12
                }
              }){
                Image($r(`app.media.${item.url}`)).width(80).height(110)
              }
            }
          })
        }
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .width('100%')
        .height(300)
        .margin({top:20})
        if(this.flagBtn){
          Button('立即抽卡').width('60%').margin({top:20}).backgroundColor('#ff2796e5')
            .onClick(() => {
              // 点击时，让抽奖卡片弹层显示
              this.maskOpacity = 1
              this.maskZIndex = 99
              // 点击时，让抽奖卡片弹层中的图片实现缩放效果
              this.imgX = 1
              this.imgY = 1
              // 点击时，随机得到1~6之间的任意一个值
              this.imgIndex = Math.floor(Math.random() * 6)
            })
        }else {
          Button('立即抽奖').width('60%').margin({top:20}).backgroundColor('#fffda203')
            .onClick(() => {
              this.isShow = true
              // 设置获奖图片缩放显示
              this.awardImgX = 1
              this.awardImgY = 1
              // 点击抽奖的时候，获取一个随机的奖品
              const randomIndex:number = Math.floor(Math.random() * 3)
              this.awardName = this.awardArr[randomIndex]
            })
        }
      }
      .videoPlay_column1()
      // 抽奖卡片弹层页面
      Column({space:40}){
        Text('获得生肖卡').fontSize(20).fontColor(Color.White).fontWeight(700)
        Image($r(`app.media.img_0${this.imgIndex}`)).width(200)
          .scale({
            x:this.imgX,
            y:this.imgY
          })
          .animation({duration:200})
        Button('开心收下').width('60%').backgroundColor(Color.Transparent).border({width:1,color:'#fff9e0'})
          .onClick(() => {
            // 控制弹层显示与隐藏
            this.maskOpacity = 0
            this.maskZIndex = -1
            // 将抽奖卡片弹层中的图片缩放还原
            this.imgX = 0
            this.imgY = 0
            // 点击开心收下的时候，将对应索引的图片和数量进行添加和展示
            // this.img[this.imgIndex].count = this.img[this.imgIndex].count + 1
            this.img[this.imgIndex] = {
              url: `app.media.img_0${this.imgIndex}`,
              count: this.img[this.imgIndex].count + 1
            }
            // 点击开心收下的时候，需要检索，判断是否集齐
            const result = this.img.find((item:imageInter) => {
               return item.count <= 0
            })
            // 判断如果 result 的值为 undefined ，说明都集齐，将按钮变为抽奖按钮
            if(!result){
              this.flagBtn = false
            }
          })
      }
      .videoPlay_column2(this.maskOpacity,this.maskZIndex)
      // 抽奖奖品弹层页面
     if(this.isShow){
       Column({space:40}){
         Text('恭喜获得手机一部').fontSize(20).fontColor(Color.White).fontWeight(700)
         Image($r(`app.media.${this.awardName}`)).width(300)
           .scale({
             x:this.awardImgX,
             y:this.awardImgY
           })
           .animation({ duration:200 })
         Button('再来一次').width('60%').backgroundColor(Color.Transparent).border({width:1,color:'#fff9e0'})
           .onClick(() => {
             // 将中奖页面关闭
             this.isShow = false
             // 将按钮改为立即抽卡
             this.flagBtn = true
             // 将生肖卡片数据重置 如果卡片数量大于1，就将卡片数量减一，如果卡片数量少于1，就不用变化
             const count0 = this.img[0].count >= 1 ? this.img[0].count - 1 : this.img[0].count
             const count1 = this.img[1].count >= 1 ? this.img[1].count - 1 : this.img[1].count
             const count2 = this.img[2].count >= 1 ? this.img[2].count - 1 : this.img[2].count
             const count3 = this.img[3].count >= 1 ? this.img[3].count - 1 : this.img[3].count
             const count4 = this.img[4].count >= 1 ? this.img[4].count - 1 : this.img[4].count
             const count5 = this.img[5].count >= 1 ? this.img[5].count - 1 : this.img[5].count
             // 重置卡片，如果卡片数量大于1，就显示生肖图片，如果卡片数量小于1，就显示文字图片
             this.img = [
               {url:count0 > 0 ? 'img_00' : 'bg_00',count:count0},
               {url:count1 > 0 ? 'img_01' : 'bg_01',count:count1},
               {url:count2 > 0 ? 'img_02' : 'bg_02',count:count2},
               {url:count3 > 0 ? 'img_03' : 'bg_03',count:count3},
               {url:count4 > 0 ? 'img_04' : 'bg_04',count:count4},
               {url:count5 > 0 ? 'img_05' : 'bg_05',count:count5},
             ]
           })
       }
       .videoPlay_column3()
     }
    }
  }
}