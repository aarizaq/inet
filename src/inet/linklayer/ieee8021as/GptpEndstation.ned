//
// @authors: Enkhtuvshin Janchivnyambuu
//           Henning Puttnies
//           Peter Danielis
//           University of Rostock, Germany
// 

package inet.linklayer.ieee8021as;

import inet.node.inet.StandardHost;


module GptpEndstation extends StandardHost
{
    parameters:
        clock.typename = default("SettableClock");
    submodules:
        gptp: Gptp {
            @display("p=700.11755,75.166");
        }
    connections:
        gptp.socketOut --> at.in++;
        at.out++ --> gptp.socketIn;
}

