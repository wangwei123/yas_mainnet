# yas_mainnet
YAS超级节点搭建教程

搭建节点前，请准备一台$20/月或$40/月(推荐)的linux centos服务器，你可以通过如下地址购买服务器，非常便宜：https://www.vultr.com/?ref=8385269

1.登录你的centos服务器，安装git，获取节点搭建脚本：

```shell
#ssh登录centos服务器,IP换成你自己的服务器IP
ssh root@10.127.89.177

#进入/opt目录
cd /opt

#安装git客户端工具
yum install git -y

#从github.com获取搭建bp的自动化脚本
git clone http://www.github.com/wangwei123/yas_mainnet
```

2.安装eosio系统，安装完后才可以使用，执行如下命令：

```shell
#进入yas_mainnet目录
cd yas_mainnet

#执行安装eosio系统
./install.sh
```

3.创建钱包, 这里钱包名称叫mywallet，你也可以自己定义其它名称: 

```shell
cleos wallet create -n mywallet --to-console

#输出如下内容，PW开头的是钱包密码，妥善保存下来，如果你没备份钱包里账号的私钥，丢失钱包密码后果很严重：
Without password imported keys will not be retrievable.
PW5JVNHZJmiapNvNSZM69bGw8z8ayEkSngfCuHzVeiabPnD5SXy4C 
```

4.打开钱包：

```shell
cleos wallet open -n mywallet

# 打开钱包后输出如下信息
Opened: mywallet
```

5.解锁钱包，需要上面步骤3中输出的密码才能解锁：

```shell
cleos wallet unlock -n mywallet --password PW5JVNHZJmiapNvNSZM69bGw8z8ayEkSngfCuHzVeiabPnD5SXy4C

#打印如下内容表示解锁成功
Unlocked: mywallet
```

6.准备一个EOS账号，用于注册节点，例如：yasyaspoolbp

7.生成一对公私钥，用于注册节点，注意注册节点的公钥私钥，不要使用注册节点账号的公钥私钥：

```shell
cleos create key --to-console

#生成结果如下，请妥善保存
Private key: 5Jnsi2kW1XcU2Ee8yoKvtcbGumLt7pcj2AJoopLVsgSDHsbMRNx
Public key: EOS8QNrqooxe62RUgRxNmj3M75ZV8tpgktQ2rCc9tfM57jwfrm1iQ
```

8.将上面步骤5生成的私钥导入钱包：

```shell
cleos wallet import -n mywallet --private-key 5Jnsi2kW1XcU2Ee8yoKvtcbGumLt7pcj2AJoopLVsgSDHsbMRNx

#打印如下内容表示导入成功
imported private key for: EOS8QNrqooxe62RUgRxNmj3M75ZV8tpgktQ2rCc9tfM57jwfrm1iQ
```

9.修改start_node.sh脚本，把你在步骤6准备的节点账号，步骤7准备公钥私钥填写到脚本中:

```shell
#进入yas_mainnet目录
cd yas_mainnet

#使用vim编辑器打开start_node.sh脚本
vim start_node.sh

#键盘按大写字母I，进入vim编辑状态，找到如下内容:
provider_name="节点账号"
provider_publickey="节点公钥"
provider_privatekey="节点私钥"

#把节点账号 改为 你的步骤6节点账号名,例如：yasyaspoolbp
#把节点公钥 改为 你在步骤7生成的公钥，例如:EOS8QNrqooxe62...省略
#把节点公钥 改为 你在步骤7生成的私钥，例如:5Jnsi2kW1XcU2E...省略

#修改完后按ESC键，然后输入:wq回车保存
#可以输入如下命令查看脚本是否修改正和保存成功：
cat start_node.sh
```

10.启动start_node.sh脚本，开始同步区块数据: 

```shell
# 执行命令启动节点运行:
./start_node.sh

#可以通过如下命令查看日志是否在同步：
tail -f nodeos.log

#执行cleos get info命令，查看是否会输出类似内容：
{
  "server_version": "de78b49b",
  "chain_id": "ed8636abfe625d99fc9a759d49a016fd8dcae9193676a020aae2540c9fffe32f",
  "head_block_num": 1,
  "last_irreversible_block_num": 1,
  "last_irreversible_block_id": "00000001b4889f304086b4999740dbad8b2a968144548f8e7eadf91f14167080",
  "head_block_id": "00000001b4889f304086b4999740dbad8b2a968144548f8e7eadf91f14167080",
  "head_block_time": "2020-01-01T00:00:00.000",
  "head_block_producer": "",
  "virtual_block_cpu_limit": 200000,
  "virtual_block_net_limit": 1048576,
  "block_cpu_limit": 200000,
  "block_net_limit": 1048576,
  "server_version_string": "v2.0.5",
  "fork_db_head_block_num": 1,
  "fork_db_head_block_id": "00000001b4889f304086b4999740dbad8b2a968144548f8e7eadf91f14167080",
  "server_full_version_string": "v2.0.5-de78b49b5765c88f4e005046d1489c3905985b94"
}
```

11.注册节点，提供你的节点账号和节点公钥即可：

```shell
#执行如下命令注册bp:
cleos system regproducer yasyaspoolbp EOS8QNrqooxe62RUgRxNmj3M75ZV8tpgktQ2rCc9tfM57jwfrm1iQ
```

