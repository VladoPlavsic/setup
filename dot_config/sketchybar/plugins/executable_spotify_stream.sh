#!/bin/bash
# Streams media-control output and updates sketchybar on every change
media-control stream | python3 -u -c "
import json, sys, subprocess

state = {'title': '', 'artist': '', 'playing': False}

def update():
    if not state['title']:
        subprocess.run(['sketchybar',
            '--set', 'media.prev',     'drawing=off',
            '--set', 'media.play',     'drawing=off',
            '--set', 'media.next',     'drawing=off',
            '--set', 'spotify',        'drawing=off',
            '--set', 'media_bracket',  'background.drawing=off'])
    else:
        icon  = '\uf04c' if state['playing'] else '\uf04b'
        MAX = 35
        full  = f\"{state['artist']} \u2014 {state['title']}\" if state['artist'] else state['title']
        label = full[:MAX] + '\u2026' if len(full) > MAX else full
        subprocess.run(['sketchybar',
            '--set', 'media.prev',     'drawing=on',
            '--set', 'media.play',     f'drawing=on', f'icon={icon}',
            '--set', 'media.next',     'drawing=on',
            '--set', 'spotify',        f'drawing=on', f'label={label}',
            '--set', 'media_bracket',  'background.drawing=on'])

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    try:
        d = json.loads(line)
        payload = d.get('payload', {})
        is_diff = d.get('diff', False)

        if not is_diff and not payload:
            # Full update with empty payload = nothing playing
            state.update({'title': '', 'artist': '', 'playing': False})
        else:
            if 'title'        in payload: state['title']   = payload['title']
            if 'artist'       in payload: state['artist']  = payload['artist']
            if 'playing'      in payload: state['playing'] = payload['playing']
            elif 'playbackRate' in payload: state['playing'] = payload['playbackRate'] == 1

        update()
    except Exception:
        pass
"
