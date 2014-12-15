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

NormalSSDPResponder = require '../discovery/ssdp/NormalSSDPResponder'

#
# It's not a real plugin, it just create some object like a plugin does.
#
class FakePlugin
    @plugin = null

    @getPlugin: ->
        if not FakePlugin.plugin
            console.log 'create FakePlugin()'
            FakePlugin.plugin = new FakePlugin()
        return FakePlugin.plugin

    constructor: ->
        null

    # TODO: change method name
    createWebSocket: (url) ->
        return new WebSocket(url)

    # TODO: change method name
    createXMLHttpRequest: ->
        return new XMLHttpRequest()

    # TODO: change method name
    # create UdpServer on FFOS
    createUdpServer: (port, options) ->
        return null

    # TODO: change method name
    # create UdpClient on FFOS
    createUdpClient: (ip, port, options) ->
        return null

    createSSDPResponder: (options) ->
        return new NormalSSDPResponder options

    createMDNSResponder: (options) ->
        throw 'Not Implemented'

module.exports = FakePlugin
