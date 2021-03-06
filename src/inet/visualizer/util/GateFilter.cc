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

#include "inet/visualizer/util/GateFilter.h"

namespace inet {

namespace visualizer {

void GateFilter::setPattern(const char *pattern)
{
    matchExpression.setPattern(pattern, true, true, true);
}

bool GateFilter::matches(const queueing::IPacketGate *gate) const
{
    MatchableObject matchableObject(MatchableObject::ATTRIBUTE_FULLPATH, check_and_cast<const cObject *>(gate));
    // TODO eliminate const_cast when cMatchExpression::matches becomes const
    return const_cast<GateFilter *>(this)->matchExpression.matches(&matchableObject);
}

} // namespace visualizer

} // namespace inet

