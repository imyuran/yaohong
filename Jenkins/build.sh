
#!/bin/sh
refs=refs/haad/release-99.99


project=lpvipthink
token=d926aee0ab9d2663d03ec8698327c8f131cbc7c43f804f7f635e5db9884c27a1
curl 'https://oapi.dingtalk.com/robot/send?access_token='"${token}"'' \
   -H 'Content-Type: application/json' \
   -d '{"msgtype": "text", "text": 
        {
            "content": "'"${refs}   ${project}"'构建成功"
        }
      }'

      