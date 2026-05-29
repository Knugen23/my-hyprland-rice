#!/usr/bin/env python3
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib
import json
import sys

def on_metadata(player, metadata):
    info = {'text': '', 'class': 'custom-media', 'alt': player.props.player_name}
    if player.get_artist() and player.get_title():
        info['text'] = f"{player.get_artist()} - {player.get_title()}"
    else:
        info['text'] = player.get_title()
    sys.stdout.write(json.dumps(info) + '\n')
    sys.stdout.flush()

def on_play(player, status):
    on_metadata(player, player.props.metadata)

manager = Playerctl.PlayerManager()

def init_player(name):
    player = Playerctl.Player.new_from_name(name)
    player.connect('metadata', on_metadata)
    player.connect('playback-status', on_play)
    manager.manage_player(player)
    on_metadata(player, player.props.metadata)

manager.connect('name-appeared', lambda m, name: init_player(name))

for name in manager.props.player_names:
    init_player(name)

GLib.MainLoop().run()
