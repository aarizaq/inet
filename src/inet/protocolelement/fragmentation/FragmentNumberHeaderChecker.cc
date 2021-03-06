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

#include "inet/protocolelement/fragmentation/FragmentNumberHeaderChecker.h"

#include "inet/common/IProtocolRegistrationListener.h"
#include "inet/protocolelement/common/AccessoryProtocol.h"
#include "inet/protocolelement/fragmentation/header/FragmentNumberHeader_m.h"
#include "inet/protocolelement/fragmentation/tag/FragmentTag_m.h"

namespace inet {

Define_Module(FragmentNumberHeaderChecker);

void FragmentNumberHeaderChecker::initialize(int stage)
{
    PacketFlowBase::initialize(stage);
    if (stage == INITSTAGE_LOCAL) {
        headerPosition = parseHeaderPosition(par("headerPosition"));
        registerService(AccessoryProtocol::fragmentation, nullptr, inputGate);
        registerProtocol(AccessoryProtocol::fragmentation, nullptr, outputGate);
    }
}

void FragmentNumberHeaderChecker::processPacket(Packet *packet)
{
    auto fragmentTag = packet->addTagIfAbsent<FragmentTag>();
    const auto& fragmentHeader = popHeader<FragmentNumberHeader>(packet, headerPosition, B(1));
    fragmentTag->setFirstFragment(fragmentHeader->getFragmentNumber() == 0);
    fragmentTag->setLastFragment(fragmentHeader->getLastFragment());
    fragmentTag->setFragmentNumber(fragmentHeader->getFragmentNumber());
    fragmentTag->setNumFragments(-1);
}

} // namespace inet

