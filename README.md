# 项目案例介绍 --> 翻译软件
  本节是用鸿蒙完成一个简单的翻译功能案例，支持多个翻译语种的选择，保留了历史翻译记录，以及支持接入多种翻译接口。
  
## 目录
- [文件目录说明](#文件目录说明)
- [案例涉及知识点](#案例涉及知识点)
- [案例效果展示](#案例效果展示)
- [案例主要负责人](#案例主要负责人)
- [其他说明](#其他说明)

### 文件目录说明
eg:
```

TranslateApp
├── AppScope
├── entry
│  ├── src  
│  │  ├── main
│  │  │  ├── ets
│  │  │  │  ├── common
│  │  │  │  ├── model
│  │  │  │  ├── pages
│  │  │  │  ├── utils
│  │  │  │  └── view
│  │  │  ├── resources
│  │  │  └── module.json5
├── hvigor
├── TranslateImg
├── .gitignore
├── build-profile.json5
├── hvigorfile.ts
├── oh-package.json5
├── oh-package-lock.json5
├── README.md

```

### 案例涉及知识点
- 容器组件: `Tabs` `TextInput` `List` `ListItem`
- 装饰器: `Extend` `Props` `State`
- 循环渲染: `ForEach`
- 路由: `router`

### 案例效果展示
![翻译首页](https://github.com/yuanjingteam/HarmonyOS-Projects/blob/translateApp/TranslateImg/translateImg1.png)
![翻译语种选择](https://github.com/yuanjingteam/HarmonyOS-Projects/blob/translateApp/TranslateImg/translateImg2.png)
![翻译效果展示](https://github.com/yuanjingteam/HarmonyOS-Projects/blob/translateApp/TranslateImg/translateImg3.png)
![翻译记录](https://github.com/yuanjingteam/HarmonyOS-Projects/blob/translateApp/TranslateImg/translateImg4.png)

### 案例主要负责人
[https://github.com/Memory159](https://github.com/Memory159)

### 其他说明
本案例只完成了最基本的功能，后续可以添加新的翻译接口以及翻译按钮，以及后续可以新增其他语种翻译
后续其他的功能可以自己探索增加

    





























