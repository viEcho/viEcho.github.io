#!/bin/bash
#自定义颜色的变量
RED_COLOR='\033[1;31m'
GREEN_COLOR='\033[1;32m'
RES='\033[0m'
current_path=$(dirname $(readlink -f $0))
echo "${GREEN_COLOR}------------->>>当前所在目录:$current_path<<<-------------${RES}"

echo "${RED_COLOR}------------->>>请确认当前目录是否在viecho.github.io下?<<<-------------${RES}"
read -p "Default continue,Enter your choice [Y/N]: " continueOrExit

case "$continueOrExit" in
    [yY])
    echo "${GREEN_COLOR}------------->>>开始执行【clean】命令...<<<-------------${RES}"
    hexo clean
    echo "${GREEN_COLOR}------------->>>开始执行【generate】命令...<<<-------------${RES}"
    hexo g
    echo "${GREEN_COLOR}------------->>>开始执行【start】命令...<<<-------------${RES}"
    hexo s
    echo "${RED_COLOR}------------->>>访问本地地址，是否符合预期?<<<-------------${RES}"
    read -p "Default continue,Enter your choice [Y/N]: " choise
    if [ $choise == 'Y' ]; then
        echo "${GREEN_COLOR}------------->>>【开始部署】至github的pages<<<-------------${RES}"
        hexo d
        echo "${GREEN_COLOR}------------->>>【开始检查】是否成功部署至github<<<-------------${RES}"
        sleep 10
        echo "${GREEN_COLOR}------------->>>【部署】至github的pages【成功】<<<-------------${RES}"

        echo "${GREEN_COLOR}------------->>>开始将整个项目【上传】至gitee...<<<-------------${RES}"
        git remote add origin https://gitee.com/viEcho/viecho.github.io.git
        git add .
        current_time="commit to gitee time:"+$(date "+%Y-%m-%d %H:%M:%S")
        echo "${RED_COLOR}------>>>${current_time}<<<------${RES}"
        git commit -m "${current_time}"
        git push origin main
        echo "${GREEN_COLOR}------------->>>整个项目上传至gitee【成功】<<<-------------${RES}"
    else
        echo "exit!"
        exit
    fi
    ;;

    [nN])
    echo "exit!"
    exit
    ;;

    *)
    echo "exit!"
    exit
esac

