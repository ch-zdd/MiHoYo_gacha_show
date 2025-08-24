import os
import sys
import shutil
import requests
import time
from datetime import datetime
import logging

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
)

class JSONUpdater:
    def __init__(self):
        # 配置 - 可以根据需要修改这些值
        self.path = {
            "原神":{
                "remote": "https://api.uigf.org/dict/genshin/chs.json",
                "local": "./uigf/genshin-dict.json"
            },
            "崩坏·星穹铁道":{
                "remote": "https://api.uigf.org/dict/starrail/chs.json",
                "local": "./uigf/starrail-dict.json"

            },
            "绝区零":{
                "remote": "https://api.uigf.org/dict/zzz/chs.json",
                "local": "./uigf/zzz-dict.json"
            }
        }
        self.timeout = 10  # 下载超时时间(秒)
    
    def download_remote_json(self, remote_json_url):
        """从远程服务器下载JSON文件"""
        try:
            logging.info(f"开始从 {remote_json_url} 下载JSON文件...")
            response = requests.get(remote_json_url, timeout=self.timeout)
            response.raise_for_status()  # 检查请求是否成功
            
            # 验证内容是否为JSON格式
            try:
                response.json()  # 尝试解析JSON，验证格式
                logging.info("JSON文件下载成功并验证格式正确")
                return response.text
            except ValueError:
                logging.error("下载的文件不是有效的JSON格式")
                return None
                
        except requests.exceptions.RequestException as e:
            logging.error(f"下载JSON文件失败: {str(e)}")
            return None
    
    def replace_local_file(self, new_content, local_json_path):
        """用新内容替换本地文件"""
        try:   
            # 写入新内容
            with open(local_json_path, 'w+', encoding='utf-8') as f:
                f.write(new_content)
            
            logging.info(f"本地文件已更新: {local_json_path}")
            return True
        except Exception as e:
            logging.error(f"替换本地文件失败: {str(e)}")
            return False
    
    def run(self):
        """执行更新流程"""
        logging.info("===== 开始JSON文件自动更新 =====")
        
        for name, path in self.path.items():
            # 下载远程文件
            new_json_content = self.download_remote_json(path["remote"])
            if not new_json_content:
                logging.error(f"更新失败，无法获取有效的远程 {name} 配置文件文件")
                return False
            
            # 替换本地文件
            success = self.replace_local_file(new_json_content, path["local"])
            
            if success:
                logging.info(f"===== {name}配置文件更新成功 =====")
            else:
                logging.error(f"===== {name}配置文件更新失败 =====")

            logging.info("...")        
        return success

if __name__ == "__main__":
    updater = JSONUpdater()
    success = updater.run()
    
    # 让用户有时间查看结果（非控制台运行时）
    if not sys.stdout.isatty():
        logging.info("3秒后自动关闭...")
        time.sleep(3)
    
    sys.exit(0 if success else 1)
