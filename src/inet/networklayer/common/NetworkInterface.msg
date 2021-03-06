//
// Copyright (C) 2020 OpenSim Ltd.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import inet.common.INETDefs;
import inet.linklayer.common.MacAddress;
import inet.networklayer.contract.ipv4.Ipv4Address;

cplusplus {{
#include "inet/networklayer/common/NetworkInterface.h"
}}

namespace inet;

class NetworkInterface extends cSimpleModule
{
    @existingClass;
    @implements(cIListener);
    @descriptor(readonly);
    bool up @getter("isUp");
    bool broadcast @getter("isBroadcast");
    bool multicast @getter("isMulticast");
    bool pointToPoint @getter("isPointToPoint");
    bool loopback @getter("isLoopback");
    int mtu;
    MacAddress macAddress;
    Ipv4Address ipv4Address @byValue;
    Ipv4Address ipv4Netmask @byValue;
    cObject *protocolData[] @getter(getProtocolData) @sizeGetter(getNumProtocolData);
}

