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

Base64 = require('js-base64').Base64

class WsWrapper

    constructor: (pluginLoader, @url) ->
        @proxy = false

        plugin = pluginLoader.getPlugin()
        console.error plugin
        console.error plugin.createWebSocket
        console.error plugin.createXMLHttpRequest
        @wsObj = plugin.createWebSocket(url)
        if not @wsObj
            throw 'createWebSocket failed!!!'

        if @wsObj.addEventListener
            console.error '#############'
            @proxy = true
        else
            console.error '@@@@@@@@@@@@@@@@@'

        if @proxy
            # setup 'open' callback
            openCallback = =>
                if @onopen
                    @onopen()
            openCallback.bind @
            @wsObj.addEventListener 'open', openCallback

            # setup 'close' callback
            closeCallback = =>
                if @onclose
                    @onclose()
            closeCallback.bind @
            @wsObj.addEventListener 'close', closeCallback

            # setup 'message' callback
            messageCallback = (data)=>
                if @onmessage
                    @onmessage
                        data: data
            messageCallback.bind @
            @wsObj.addEventListener 'message', messageCallback

            # open websocket
            @wsObj.open()

    send: (data) ->
        @wsObj.send data

    close: ->
        @wsObj.close()

module.exports = WsWrapper
