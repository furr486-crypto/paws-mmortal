#!/usr/bin/env python3

import requests
import yaml
import re

def load_config():
    with open('/etc/immortal/config.yml', 'r') as f:
        return yaml.safe_load(f)

def relogin():
    config = load_config()
    username = config['paws']['username']
    password = config['paws']['password']
    base_url = config['paws']['base_url']
    
    session = requests.Session()
    
    try:
        login_page = session.get(f"{base_url}/hub/login")
        csrf = re.search(r'name="csrf_token".*?value="(.*?)"', login_page.text)
        csrf_token = csrf.group(1) if csrf else None
        
        data = {'username': username, 'password': password}
        if csrf_token:
            data['csrf_token'] = csrf_token
        
        resp = session.post(f"{base_url}/hub/login", data=data)
        
        if resp.status_code == 200 and "lab" in resp.url:
            print(f"[{__import__('time').ctime()}] ✅ Login success")
            return True
        else:
            print(f"[{__import__('time').ctime()}] ❌ Login failed")
            return False
    except Exception as e:
        print(f"[{__import__('time').ctime()}] ❌ Error: {e}")
        return False

if __name__ == "__main__":
    relogin()
