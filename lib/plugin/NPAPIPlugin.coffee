#
# Copyright (C) 2013-2014, The OpenFlint Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# TODO: change plugin's name
PLUGIN_NAME = 'sockit'
PLUGIN_MIME_TYPE = 'application/x-sockit'
PLUGIN_LOCATION = 'http://sockit.github.com/downloads.html'

class NPAPIPlugin

    @plugin = null

    @getPlugin: ->
        if not NPAPIPlugin.plugin
            pluginAvailable = false

            if navigator.mimeTypes
                for index, mime of navigator.mimeTypes
                    if mime is NPAPIPlugin.PLUGIN_MIME_TYPE
                        pluginAvailable = true
            else
                console.warn 'navigator.mimeTypes is null'

            if not pluginAvailable
                redirect = confirm PLUGIN_NAME + ' plugin is not currently installed, would you like to be redirected to the SockIt plugin download page?'
                if redirect
                    window.location = NPAPIPlugin.PLUGIN_LOCATION
            else
                plugin = document.createElement 'object'
                plugin.setAttribute 'type', NPAPIPlugin.PLUGIN_MIME_TYPE
                plugin.setAttribute 'style', 'width: 0; height: 0;'
                document.documentElement.appendChild plugin
#                window[NPAPIPlugin.PLUGIN_NAME] = plugin
                NPAPIPlugin.plugin = plugin
        return NPAPIPlugin.plugin

    constructor: ->
        null

module.exports = NPAPIPlugin
