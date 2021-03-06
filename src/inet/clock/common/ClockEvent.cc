//
// Copyright (C) 2021 OpenSim Ltd.
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

#include "inet/clock/common/ClockEvent.h"

#include "inet/clock/contract/IClock.h"

namespace inet {

Register_Class(ClockEvent)

void ClockEvent::execute()
{
    if (clock != nullptr)
        clock->handleClockEvent(this);
    else {
        // TODO: this should be part of setArrival if clock is nullptr
        arrivalClockTime = SIMTIME_AS_CLOCKTIME(getArrivalTime());
        cMessage::execute();
    }
}

} // namespace inet

