import os
from pathlib import Path
from typing import Any, Dict

from appdirs import user_config_dir
from box import Box
from yaspin import yaspin

from .constants import CONFIG_DIR, CONFIG_PATH, DEFAULT_CONFIG

CONFIG_DIR.mkdir(parents=True, exist_ok=True)


def load_config() -> Dict[str, Any]:
    if not CONFIG_PATH.is_file():
        return DEFAULT_CONFIG

    with CONFIG_PATH.open() as f:
        config = Box.from_yaml(f)

    # Override config values with environment variables, if they exist
    for key in config:
        env_value = os.getenv(key)
        if env_value is not None:
            config[key] = env_value

    return config


def save_config(config: Dict[str, Any]) -> None:
    with yaspin(text="Saving config", color="yellow"):
        with CONFIG_PATH.open("w") as f:
            f.write(Box(config).to_yaml())


def reset_config() -> None:
    if CONFIG_PATH.is_file():
        CONFIG_PATH.unlink()

    save_config(DEFAULT_CONFIG)


def update_config(config: Dict[str, Any]) -> None:
    current = load_config()
    current.update(config)
    save_config(current)
