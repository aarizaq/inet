//
// Copyright (C) 2020 Opensim Ltd.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//

#ifndef __INET_ETHERHUB_H
#define __INET_ETHERHUB_H

#include "inet/common/INETDefs.h"
#include "inet/physicallayer/common/packetlevel/WireJunction.h"

namespace inet {

using namespace inet::physicallayer;

/**
 * Models an Ethernet hub.
 */
class INET_API EtherHub : public physicallayer::WireJunction
{
  protected:
    virtual const char* getGateName() const override { return "ethg"; }
};

} // namespace inet

#endif

