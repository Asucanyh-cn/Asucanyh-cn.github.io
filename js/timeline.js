// 不知道为什么，读取的时间字符串是准确时间，但是转变成日期格式之后，就出现，时间减了8个小时
// 网上搜了很多方法都不行，后来搜到这个函数，就是将时间格式转变成东八区时间。
function GetTimeByTimeStr(dateString) {
    let timeArr = dateString.split(" ");
    let d = timeArr[0].split("-");
    let t = timeArr[1].split(":");
    return new Date(d[0], d[1] - 1, d[2], parseInt(t[0]) + 8, t[1], t[2], '+0800');
}

hexo.extend.generator.register('timeline', function(locals) {
    let timelineData = [];
    for(let i = 0; i < locals.pages.data.length; i++) {
        // 通过locals获得本地json文件，然后读取该文件内容，转变成json格式的变量
        let pageInfo = locals.pages.data[i];
        if(pageInfo.source == "timeline/timeline.json") {
            timelineData = JSON.parse(pageInfo.content);
            break;
        }
    }
    // 这里是修改时间格式
    for(let i = 0; i < timelineData.length; i++) {
        timelineData[i].date = GetTimeByTimeStr(timelineData[i].date);
    }
    
    return {
        path: 'timeline/index.html', // 将生成的网页放置该文件夹下
        data: {posts: timelineData}, // 传递参数给swig文件
        layout: ['timeline', 'timeline'] // 调用swig文件
    }
});
