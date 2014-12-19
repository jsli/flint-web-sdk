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

NPAPIPlugin = require './NPAPIPlugin'
FakePlugin = require './FakePlugin'
Platform = require '../common/Platform'

class PluginLoader

    @getPlugin: ->
        # load order:
        #   browser specical
        #   browser plugin
        #   npapi
        #   common
        platform = Platform.getPlatform()
        console.info 'Platform is : ', platform.browser
        plugin = null
        switch platform.browser
            when 'firefox'
                ffos = (window.MozActivity isnt undefined)
                if ffos
                    console.info 'Platform is : FFOS',
                        plugin = FakePlugin.getPlugin()
                else
                    plugin = NPAPIPlugin.getPlugin()
            when 'chrome', 'safari', 'msie'
                plugin = NPAPIPlugin.getPlugin()
            else
                plugin = FakePlugin.getPlugin()

module.exports = PluginLoader
