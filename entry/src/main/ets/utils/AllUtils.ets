import axios, { AxiosResponse } from '@ohos/axios'
import Constants from '../common/Constants'
import { itemsInter, translateInter } from '../model/DataContent'

// 向外暴露一个函数: 拿到一个英文标记，返回一个对应的中文名称
export function getLanguageText(lang: string): string {
  let obj = Constants.languageItem.find((item: itemsInter) => item.lang === lang)
  return obj?.chinese + ''
}

// 向外暴露一个获取翻译结果的函数
export async function getTranslated(text: string, lang: string = 'zh') {
  let uri: string = Constants.txTranslateParams.uri
  let key: string = Constants.txTranslateParams.key
  let url: string = `${uri}?key=${key}&text=${text}&to=${lang}`
  let req: AxiosResponse = await axios.get(url)
  let generalObj: translateInter = {
    src: req.data.result.src,
    dst: req.data.result.dst,
    from: req.data.result.from,
    to: req.data.result.to,
    target: Constants.txButton
  }
  return generalObj
}

// 向外暴露一个保存翻译记录的函数
export function saveTranslateRecord(historyRecord: translateInter) {
  // 获取 AppStorage 对象中存过的数组，可能是空数组，也可能是有数据的数组
  let historyArr: translateInter[] = getHistoryRecord()
  // 进行去重,判断存数据的数组中是否已经有当前的这条记录
  let flag = historyArr.some((item) => {
    return item.src === historyRecord.src && item.target === historyRecord.target && item.to === historyRecord.to
  })
  // 如果当前数组中没有这条数据，就将这条数据 push 进去
  if (!flag) {
    historyArr.push(historyRecord)
  }
  // 将整个数组存储到全局中
  AppStorage.setOrCreate('HistoryRecord', historyArr)
}

// 向外暴露一个取出历史记录的函数
export function getHistoryRecord(): translateInter[] {
  return AppStorage.get('HistoryRecord') || []
}

