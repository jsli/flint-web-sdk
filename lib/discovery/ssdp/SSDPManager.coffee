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

EventEmitter = require 'eventemitter3'
PluginLoader = require '../../plugin/PluginLoader'

class SSDPManager extends EventEmitter

    constructor: ->
        options =
            st: 'urn:dial-multiscreen-org:service:dial:1'
        @ssdp = PluginLoader.getPlugin().createSSDPResponder options
        @ssdp.addEventListener 'serviceFound', (data) =>
            console.error 'ssdp found: -> ', data
        @ssdp.addEventListener 'serviceLost', (data) =>
            console.error 'ssdp lost: -> ', data
        @ssdp.search "urn:dial-multiscreen-org:service:dial:1"

#        @ssdp.on 'devicealive', (device) =>
#            @emit 'adddevice', device
#        @ssdp.on 'devicebyebye', (uniqueId) =>
#            @emit 'removedevice', uniqueId

    start: ->
        @ssdp.start()

    stop: ->
        @ssdp.stop()

module.exports = SSDPManager