//
// Copyright (C) 2016 OpenSim Ltd.
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

#ifndef __INET_IRECIPIENTACKPROCEDURE_H
#define __INET_IRECIPIENTACKPROCEDURE_H

#include "inet/linklayer/ieee80211/mac/Ieee80211Frame_m.h"
#include "inet/linklayer/ieee80211/mac/contract/IProcedureCallback.h"
#include "inet/linklayer/ieee80211/mac/contract/IRecipientAckPolicy.h"

namespace inet {
namespace ieee80211 {

class INET_API IRecipientAckProcedure
{
  public:
    virtual ~IRecipientAckProcedure() {}

    virtual void processReceivedFrame(Packet *packet, const Ptr<const Ieee80211DataOrMgmtHeader>& dataOrMgmtHeader, IRecipientAckPolicy *ackPolicy, IProcedureCallback *callback) = 0;
    virtual void processTransmittedAck(const Ptr<const Ieee80211AckFrame>& ack) = 0;
};

} // namespace ieee80211
} // namespace inet

#endif

