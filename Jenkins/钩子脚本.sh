#!/bin/bash
refs=$1
echo ${refs}
project=shf_lp
project_dir=/data/repos/${project}
project_url=https://gz-gitlab.vipthink.cn/sh-lp/shf_lp.git
cd  ${project_dir}


if [[ "${refs}" == refs/heads/master ]];then
    cd /data/wwwroot/master/${project}
    git reset --hard
    git pull
    # 切换构建目录处理
else
    echo Ignore the build
fi
cd  ${project_dir}
if [[ "${refs}" == refs/heads/dev-* ]];then

    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`
    [ -d ${project} ] && rm -rf ${project}

    if [ ! -d ${branch_tag} ];then
        echo echo "开始拉取代码......."
        git clone   ${project_url}
        mv ${project} ${branch_tag}
        cd ${branch_tag}
    else
        cd ${branch_tag}
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    npm run prod
    echo ${branch_tag} > ./dist/version.log
    rsync -avz -e 'ssh -p 22' --exclude=.git  ./dist/  shop@106.54.66.104:/data/wwwroot/shd-lp.vipthink.cn/static/
else
    echo Ignore the build
fi

if [[ "${refs}" == refs/heads/shd-* ]];then

    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`
    [ -d ${project} ] && rm -rf ${project}

    if [ ! -d ${branch_tag} ];then
        echo echo "开始拉取代码......."
        git clone   ${project_url}
        mv ${project} ${branch_tag}
        cd ${branch_tag}
    else
        cd ${branch_tag}
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    npm run prod
    echo ${branch_tag} > ./dist/version.log
    rsync -avz -e 'ssh -p 22' --exclude=.git  ./dist/  shop@106.54.66.104:/data/wwwroot/shd-lp.vipthink.cn/static/
else
    echo Ignore the build
fi


if [[ "${refs}" == refs/tags/sht-* ]];then

    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`

    [ -d ${project} ] && rm -rf ${project}

    echo echo "开始拉取代码......."
    git clone  ${project_url}

    if [ ! -d ${branch_tag} ];then
        mv ${project}  ${branch_tag}
        cd ${branch_tag}
    else
        echo "${branch_tag}已经发布......."
        rm  -rf ${project}
        exit 0
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    npm run prod
    rm -rf babel.config.js build config static node_modules package.json README.md src yarn-error.log
    echo ${branch_tag} > ./dist/version.log
    rsync -avz -e 'ssh -p 22' --exclude=.git  ./dist/  shop@49.234.220.191:/data/wwwroot/sht-lp.vipthink.cn/static/
else
    echo Ignore the build
fi


if [[ "${refs}" == refs/tags/shp-* ]];then

    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`

    [ -d ${project} ] && rm -rf ${project}

    echo echo "开始拉取代码......."
    git clone  ${project_url}

    if [ ! -d ${branch_tag} ];then
        mv ${project}  ${branch_tag}
        cd ${branch_tag}
    else
        echo "${branch_tag}已经发布......."
        rm  -rf ${project}
        exit 0
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    npm run prod
    rm -rf babel.config.js build config static node_modules package.json README.md src yarn-error.log
    echo ${branch_tag} > ./dist/version.log
    rsync -avz -e 'ssh -p 22' --exclude=.git  ./dist/  shop@10.104.10.92:/data/wwwroot/shp-lp.vipthink.cn/static/
else
    echo Ignore the build
fi

if [[ "${refs}" == refs/tags/sho-* ]];then
    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`
    [ -d ${project} ] && rm -rf ${project}

    echo echo "开始拉取代码......."
    git clone  ${project_url}

    if [ ! -d ${branch_tag} ];then
    	mv ${project}  ${branch_tag}
        cd ${branch_tag}
        git checkout ${branch_tag}
        git pull
    else
        echo "${branch_tag}已经发布......."
        rm  -rf ${project}
        exit 0
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    npm run prod
    echo ${branch_tag} > ./dist/version.log
    rm -rf babel.config.js build config static node_modules package.json README.md src yarn-error.log
    rsync -avz -e 'ssh -p 22' --exclude=.git  ./dist/  shop@10.104.10.92:/data/wwwroot/sho-lp.vipthink.cn/static/
else
    echo Ignore the build
fi
[sh_devops-10.104.40.58]:shop:/data/tools/jenkins$
[sh_devops-10.104.40.58]:shop:/data/tools/jenkins$ ll
总用量 36K
3427893 -rwxrwxr-x 1 shop shop 1.9K 2019-10-29 12:16 go_tars_core_jenkins.sh
3416523 -rwxr-xr-x 1 shop shop 6.3K 2019-11-18 19:17 new_admin_thinkphp.sh
3484341 -rwxr-xr-x 1 shop shop 4.0K 2019-11-18 11:54 new_edu_vue.sh
3454120 -rwxr-xr-x 1 shop shop 5.2K 2019-11-19 21:07 new_LPVipthink_jenkins.sh
3464289 -rwxr-xr-x 1 shop shop 4.6K 2019-11-13 18:53 new_vipthink_core_jenkins.sh
3416517 -rwxr-xr-x 1 shop shop 4.0K 2019-11-19 14:12 shf_lp_jenkins.sh
[sh_devops-10.104.40.58]:shop:/data/tools/jenkins$ cat new_LPVipthink_jenkins.sh
#!/bin/bash
refs=$1
echo ${refs}
project=lpvipthink
project_dir=/data/repos/${project}
project_url=https://gz-gitlab.vipthink.cn/mll/lpvipthink.git
cd  ${project_dir}

############# dev- ###############################
if [[ "${refs}" == refs/heads/dev-* ]];then
    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`
    [ -d ${project} ] && rm -rf ${project}
    if [ ! -d ${branch_tag} ];then
        echo echo "开始拉取代码......."
        git clone   ${project_url}
        mv ${project} ${branch_tag}
        cd ${branch_tag}
    else
        cd ${branch_tag}
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    cp /data/repos/lpvipthink/dev-env .env
    echo ${branch_tag} >version.log
    curl "http://127.0.0.1:7001/server/restart?Bpro=lpvipthink&Bver=dev-3.0"
    rsync -avz -e 'ssh -p 22' --exclude=.git --exclude=test.conf --exclude=.env  ./  shop@106.54.66.104:/data/wwwroot/shd-lp.vipthink.cn/lpvipthink/
    ansible-playbook -vv /etc/ansible/sh_op_jenkins.yml --extra-vars "hosts=sh_dev"  -t LPVipthink-dev
    curl "http://core-admin.vipthink.cn/common/error_report?var_session_id=&project_name=lpvipthink&title=开发环境&content=lpcore构建成功&account_list=hong,abner"
else
    echo Ignore the build
fi
####
if [[ "${refs}" == refs/heads/shd-* ]];then
    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`
    [ -d ${project} ] && rm -rf ${project}
    if [ ! -d ${branch_tag} ];then
        echo echo "开始拉取代码......."
        git clone   ${project_url}
        mv ${project} ${branch_tag}
        cd ${branch_tag}
    else
        cd ${branch_tag}
    fi
    git pull
    git checkout ${branch_tag}
    git pull
    cp /data/repos/lpvipthink/dev-env .env
    echo ${branch_tag} >version.log
    curl "http://127.0.0.1:7001/server/restart?Bpro=lpvipthink&Bver=dev-3.0"
    rsync -avz -e 'ssh -p 22' --exclude=.git --exclude=test.conf --exclude=.env  ./  shop@106.54.66.104:/data/wwwroot/shd-lp.vipthink.cn/lpvipthink/
    ansible-playbook -vv /etc/ansible/sh_op_jenkins.yml --extra-vars "hosts=sh_dev"  -t LPVipthink-dev
    curl "http://core-admin.vipthink.cn/common/error_report?var_session_id=&project_name=lpvipthink&title=开发环境&content=lpcore构建成功&account_list=hong,abner"
else
    echo Ignore the build
fi
############# bate ###############################

if [[ "${refs}" == refs/tags/sht-* ]];then

    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`

    [ -d ${project} ] && rm -rf ${project}

    echo echo "开始拉取代码......."
    git clone  ${project_url}

    if [ ! -d ${branch_tag} ];then
        mv ${project} ${branch_tag}
        cd ${branch_tag}
        cp /data/repos/lpvipthink/test-env .env
        #cp test.conf.example test.conf
    else
        echo "${branch_tag}已经发布......."
        rm  -rf ${project}
        exit 0
    fi
    git pull
    git checkout  ${branch_tag}
    git pull
    [ $? -eq 0 ] && echo "拉取代码成功"
    echo ${branch_tag} >version.log
    rsync -avz -e 'ssh -p 22' --exclude=.giti --exclude=test.conf  --exclude=.env --exclude=test.conf  ./  shop@49.234.220.191:/data/wwwroot/sht-lp.vipthink.cn/lpvipthink/
    ansible-playbook -vv /etc/ansible/sh_op_jenkins.yml --extra-vars "hosts=sh_test"  -t LPVipthink-test
else
    echo Ignore the build
fi
###################  pre #########################
if [[ "${refs}" == refs/tags/shp-* ]];then

    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`

    [ -d ${project} ] && rm -rf ${project}

    echo echo "开始拉取代码......."
    git clone  ${project_url}

    if [ ! -d ${branch_tag} ];then
        mv ${project} ${branch_tag}
        cd ${branch_tag}
    else
        echo "${branch_tag}已经发布......."
        rm  -rf ${project}
        exit 0
    fi
    git pull
    git checkout  ${branch_tag}
    git pull
    [ $? -eq 0 ] && echo "拉取代码成功"
    echo ${branch_tag} >version.log
    rsync -avz -e 'ssh -p 22' --exclude=test.conf --exclude=.env --exclude=.git --exclude=doc --exclude=docker ./ shop@10.104.10.92:/data/wwwroot/shp-lp.vipthink.cn/lpvipthink/
    ansible-playbook -vv /etc/ansible/sh_op_jenkins.yml --extra-vars "hosts=sh_gr"  -t LPVipthink-shp
else
    echo Ignore the build
fi


############# release ###############################

if [[ "${refs}" == refs/tags/sho-* ]];then
    branch_tag=`echo ${refs}|awk -F '/' '{print $NF}'`
    [ -d ${project} ] && rm -rf ${project}

    echo echo "开始拉取代码......."
    git clone  ${project_url}

    if [ ! -d ${branch_tag} ];then
        mv ${project} ${branch_tag}
        cd ${branch_tag}
        cp /data/repos/lpvipthink/dev-env .env
        #cp test.conf.example test.conf
    else
        echo "${branch_tag}已经发布......."
        rm  -rf ${project}
        exit 0
    fi
    git pull
    git checkout  ${branch_tag}
    git pull
    [ $? -eq 0 ] && echo "拉取代码成功"
    echo ${branch_tag} >version.log
    rsync -avz -e 'ssh -p 22' --exclude=test.conf --exclude=.env --exclude=.git --exclude=doc --exclude=docker ./ shop@10.104.10.92:/data/wwwroot/sho-lp.vipthink.cn/lpvipthink/
    ansible-playbook -vv /etc/ansible/sh_op_jenkins.yml --extra-vars "hosts=sh_gr"  -t LPVipthink-gr
else
    echo Ignore the build
fi