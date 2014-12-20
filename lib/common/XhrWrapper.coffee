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

#Base64 = require 'js-base64'.Base64
Base64 = require('js-base64').Base64

class XHRWrapper

    constructor: (pluginLoader) ->
        @proxy = false

        @xhrObj = pluginLoader.getPlugin().createXMLHttpRequest()
        if not @xhrObj
            throw 'createXMLHttpRequest failed!!!'

        if @proxy
            callback = =>
                if @xhrObj.onreadystatechange
                    @xhrObj.onreadystatechange()
            callback.bind @
            @xhrObj.setOnReadyStateChangeCallback callback

    open: (method, url) ->
        @xhrObj.open method, url, true

    send: (data) ->
        console.info 'send: ', data
        @xhrObj.send (data or '')

    setRequestHeader: (headerKey, headerValue) ->
        @xhrObj.setRequestHeader headerKey, headerValue

    getResponseHeader: (headerKey) ->
        return @xhrObj.getResponseHeader headerKey

    getResponseText: ->
        return @xhrObj.getResponseText()

    getStatus: ->
        return @xhrObj.getStatus()

    getReadyState: ->
        return @xhrObj.getReadyState()

    getStatusText: ->
        return @xhrObj.getStatusText()

    getAllResponseHeaders: ->
        return @xhrObj.getAllResponseHeaders()

    #
    # callback: (statusCode, responseText) =>
    #
    request: (method, url, headers, data, callback) ->
        @xhrObj.timeout = 3 * 1000
        @open method, url
        if headers
            for key, value of headers
                @setRequestHeader key, value

        @xhrObj.onreadystatechange = =>
            @readyState = @getReadyState()
            if @readyState is 4
                @status = @getStatus()
                @statusText = @getStatusText()
                responseText = @getResponseText()
                @responseText = Base64.decode responseText
                console.info 'received: ', @responseText
                callback? @status, @responseText

        @xhrObj.onerror = =>
            console.error 'XHRWrapper Error: ', method, ' - ', url, ' - ', data
            callback? -1, 'error'

        @send JSON.stringify(data)
#        if data
#            @xhrObj.send JSON.stringify(data)
#        else
#            @xhrObj.send("")

module.exports = XHRWrapper
