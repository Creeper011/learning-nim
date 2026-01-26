# a simple conversion from the fetch_sys.nim file to fetch_sys.py 
# (i could add more information but i want to keep it indentical to nim version)
import os
import platform
from dataclasses import dataclass

@dataclass
class SystemData():
    os_type: str
    shell_name: str
    graphical_backend: str
    system_envronment: str
    username: str

def get_system_info() -> SystemData:
    return SystemData(
        os_type=platform.system(),
        shell_name=os.environ.get('SHELL', 'Unknown'),
        graphical_backend=os.environ.get('XDG_SESSION_TYPE', 'Unknown'),
        system_envronment=os.environ.get('XDG_CURRENT_DESKTOP', 'Unknown'),
        username=os.environ.get('USER', 'Unknown')
    )

if __name__ == "__main__":
    sys_info = get_system_info()
    print(f"OS Type: {sys_info.os_type}")
    print(f"Shell: {sys_info.shell_name}")
    print(f"Session: {sys_info.graphical_backend}")
    print(f"DE: {sys_info.system_envronment}")
    print(f"User: {sys_info.username}")