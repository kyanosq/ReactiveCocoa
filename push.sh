#!/bin/bash

# 确保脚本在发生错误时停止运行
set -e

# 配置变量
PODSPEC_FILE="ReactiveCocoa.podspec"
REPO_NAME="rcmtm-ios-yolanspec"
SOURCE_URLS="http://gitlab.rcmtm.com/iOS/YolanSpec.git,https://github.com/CocoaPods/Specs.git"
BRANCH_NAME="master"  # 或者你的默认分支名称

# 函数：从 .podspec 文件中提取当前版本号
get_current_version() {
    # 修改正则表达式来更精确地匹配版本号
    grep -E "s\.version\s*=\s*['\"]([0-9]+\.[0-9]+\.[0-9]+)['\"]" "$PODSPEC_FILE" | sed -E "s/.*['\"]([0-9]+\.[0-9]+\.[0-9]+)['\"].*/\1/"
}

# 提取当前版本号
CURRENT_VERSION=$(get_current_version)

# 打印信息
echo "📦 当前版本：$CURRENT_VERSION"

# 检查版本号是否符合预期格式
if [[ "$CURRENT_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "✅ 版本号格式正确"
else
    echo "❌ 错误：版本号格式不正确"
    exit 1
fi

# Git 操作：添加更改
echo "🚀 添加文件并提交更改"
git add .
git commit -m "Release $CURRENT_VERSION"

# 创建并推送标签
echo "🏷 创建标签"
git tag "$CURRENT_VERSION"

# 推送到远程仓库
echo "🚀 推送到远程仓库"
git push origin "$BRANCH_NAME"
git push origin "$CURRENT_VERSION"

# Pod 发布
echo "📦 开始发布到私有仓库"
pod repo push "$REPO_NAME" "$PODSPEC_FILE" --sources="$SOURCE_URLS" --allow-warnings

# 完成提示
echo "🎉 发布成功！版本号：$CURRENT_VERSION"
