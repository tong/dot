#!/usr/bin/env python

import os
import random
import sys
import yaml

# Theme switch utility for alacritty

CFG_DIR = os.path.expanduser("~/.config/alacritty")
THEME_DIR = os.path.join(CFG_DIR, "theme")
THEME_LINK = os.path.join(CFG_DIR,"theme.yml")

if not os.path.exists(THEME_DIR):
    print('theme directory not found')
    exit(1)

if not os.path.exists(THEME_LINK):
    print('no active theme linked')

def get_available_themes():
    themes = list()
    with os.scandir(THEME_DIR) as entries:
        for e in entries:
            if e.is_file():
                t = os.path.splitext(e.name)
                if t[1] == '.yml': themes.append(t[0])
    themes.sort()
    return themes

def get_active_theme():
    return os.path.splitext(os.path.basename(os.readlink(THEME_LINK)))[0]

def get_theme_index(name:str):
    return get_available_themes().index(name)

def set_active_theme(theme:str):
    os.remove(THEME_LINK)
    os.symlink(os.path.join(THEME_DIR, theme+'.yml'), THEME_LINK) 

if len(sys.argv) == 1:
    print(get_active_theme())
else:
    cmd = sys.argv.pop()
    themes = get_available_themes()
    if cmd == "get":
        print(get_active_theme())
    elif cmd == "next":
        i = themes.index(get_active_theme())
        set_active_theme(themes[0 if i==len(themes)-1 else i+1])
    elif cmd == "prev":
        i = themes.index(get_active_theme())
        set_active_theme(themes[ len(themes)-1 if i==0 else i-1])
    elif cmd == "random":
        ic = themes.index(get_active_theme())
        while True:
            ir = random.randint(0, len(themes)-1)
            if ir != ic:
                set_active_theme(themes[ir])
                break
    elif cmd == "list":
        ta = get_active_theme()
        for t in themes: print( '*'+t if t==ta else t)
    elif cmd == "preview":
        for t in themes:
            with open(os.path.join(THEME_DIR, t+'.yml' )) as f:
                theme = yaml.safe_load(f)
                print(t)
                for group in theme["colors"]:
                    print("  "+group)
                    for color in theme["colors"][group]:
                        print("    "+color+": "+theme["colors"][group][color])
    elif cmd == "dump":
        for t in themes:
            with open(os.path.join(THEME_DIR, t+'.yml' )) as f:
                print('\n# '+t+'\n'+f.read().strip()) 
                #theme = yaml.safe_load(f)
    else:
        try:
            nindex = themes.index(cmd)
        except:
            print('Theme not found')
            exit(1)
        set_active_theme(themes[nindex])

