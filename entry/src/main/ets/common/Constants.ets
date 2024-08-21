import { itemsInter, paramsInter } from '../model/DataContent'

// 常量数据
export default class Constants {
  // 可选的语种
  static readonly languageItem: itemsInter[] = [
    {
      lang: 'zh',
      chinese: '中文'
    },
    {
      lang: 'en',
      chinese: '英文'
    },
    {
      lang: 'jp',
      chinese: '日语'
    },
    {
      lang: 'kor',
      chinese: '韩语'
    },
    {
      lang: 'fra',
      chinese: '法语'
    },
    {
      lang: 'spa',
      chinese: '西班牙语'
    },
    {
      lang: 'th',
      chinese: '泰语'
    },
    {
      lang: 'ara',
      chinese: '阿拉伯语'
    },
    {
      lang: 'ru',
      chinese: '俄语'
    },
    {
      lang: 'pt',
      chinese: '葡萄牙语'
    },
    {
      lang: 'de',
      chinese: '德语'
    },
    {
      lang: 'it',
      chinese: '意大利语'
    }
  ]
  // 默认的语种 字母标记
  static readonly lang: string = 'zh'
  // 翻译接口需要用到的参数
  static readonly txTranslateParams: paramsInter = {
    uri: 'https://apis.tianapi.com/fanyi/index',
    key: '31e54ef5cdcfbbba29676d89dfac7183'
  }
  // 翻译按钮
  static readonly txButton: string = 'tianxing'
}