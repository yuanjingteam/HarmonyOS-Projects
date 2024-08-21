// 定义语言选择属性的接口
export interface itemsInter {
  lang: string,
  chinese: string
}

// 定义翻译接口所用参数的接口
export interface paramsInter {
  uri: string,
  key: string
}

// 定义请求返回数据
export interface translateInter {
  src: string,
  dst: string,
  from: string,
  to: string,
  target: string
}