//
// Copyright (C) 2005 OpenSim Ltd.
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

package inet.linklayer.ppp;

import inet.linklayer.contract.IPppInterface;
import inet.networklayer.common.NetworkInterface;
import inet.queueing.contract.ITrafficConditioner;

//
// This module implements a PPP network interface.
//
module PppInterface extends NetworkInterface like IPppInterface
{
    parameters:
        string interfaceTableModule;
        *.interfaceTableModule = default(absPath(this.interfaceTableModule));
    gates:
        input upperLayerIn;
        output upperLayerOut;
        inout phys @labels(PppFrame);
    submodules:
        ingressTC: <default("OmittedTrafficConditioner")> like ITrafficConditioner {
            parameters:
                @display("p=500,100");
        }
        egressTC: <default("OmittedTrafficConditioner")> like ITrafficConditioner {
            parameters:
                @display("p=300,100");
        }
        ppp: Ppp {
            parameters:
                queue.packetCapacity = default(10000);
                @display("p=400,200");
        }
    connections:
        upperLayerIn --> { @display("m=n"); } --> egressTC.in;
        egressTC.out --> ppp.upperLayerIn;

        phys <--> { @display("m=s"); } <--> ppp.phys;

        ppp.upperLayerOut --> ingressTC.in;
        ingressTC.out --> { @display("m=n"); } --> upperLayerOut;
}

