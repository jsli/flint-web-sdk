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

class WsWrapper

    # Websocket connection's state code
    CONNECTING = 0 # The connection is not yet open.
    OPEN = 1 # The connection is open and ready to communicate.
    CLOSING = 2 # The connection is in the process of closing.
    CLOSED = 3 # The connection is closed or couldn't be opened.

    constructor: (pluginLoader, @url) ->
        @proxy = false

        plugin = pluginLoader.getPlugin()
        @wsObj = plugin.createWebSocket url
        if not @wsObj
            throw 'createWebSocket failed!!!'

        if @wsObj.addEventListener
            @proxy = true

        if @proxy
            @readyState = CONNECTING

            # setup 'open' callback
            openCallback = =>
                @readyState = OPEN
                if @onopen
                    @onopen()
            @wsObj.addEventListener 'open', openCallback

            # setup 'close' callback
            closeCallback = =>
                @readyState = CLOSED
                if @onclose
                    @onclose()
            @wsObj.addEventListener 'close', closeCallback

            # setup 'error' callback
            errorCallback = =>
                @readyState = CLOSED
                if @onerror
                    @onerror()
            @wsObj.addEventListener 'error', errorCallback

            # setup 'message' callback
            messageCallback = (data)=>
                if @onmessage
                    @onmessage
                        data: data
            @wsObj.addEventListener 'message', messageCallback

            # open websocket
            @wsObj.open()

    send: (data) ->
        @wsObj.send (data or '')

    close: ->
        @readyState = CLOSING
        @wsObj.close()

module.exports = WsWrapper
