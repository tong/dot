#!/usr/bin/env python2

# Terminator haxelib url handler

import re
import terminatorlib.plugin as plugin

AVAILABLE = ['HaxelibURLHandler']


class HaxelibURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'haxelib'
    match = '\\b(haxelib):?\s?([A-Za-z]+[a-z0-9\._]*)\\b'

    def callback(self, url):
        if url.startswith('haxelib:'):
            url = url[8:]
            return('https://lib.haxe.org/p/%s' % url)
