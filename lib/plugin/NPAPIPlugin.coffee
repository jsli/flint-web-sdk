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
PLUGIN_NAME = 'flintplugin'
PLUGIN_MIME_TYPE = 'application/x-flintplugin'
PLUGIN_LOCATION = 'http://sockit.github.com/downloads.html'

class NPAPIPlugin

    @plugin = null

    @getPlugin: ->
        if not NPAPIPlugin.plugin
            if navigator.mimeTypes
                for index, mime of navigator.mimeTypes
                    if mime.type is PLUGIN_MIME_TYPE
                        console.log 'create NPAPI plugin'
                        plugin = document.createElement 'object'
                        plugin.setAttribute 'type', PLUGIN_MIME_TYPE
                        plugin.setAttribute 'style', 'width: 0; height: 0;'
                        document.documentElement.appendChild plugin
                        window[PLUGIN_NAME] = plugin
                        NPAPIPlugin.plugin = plugin
                        return NPAPIPlugin.plugin
            else
                console.warn 'navigator.mimeTypes is null'
                return null
            console.warn 'cannot load NPAPI plugin'
            return null
        else
            return NPAPIPlugin.plugin

    @getName: ->
        return 'NPAPI'

module.exports = NPAPIPlugin
