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

package inet.queueing.tokengenerator;

import inet.queueing.base.TokenGeneratorBase;

//
// This module generates tokens for a ~TokenBasedServer repeatedly.
//
simple TimeBasedTokenGenerator extends TokenGeneratorBase
{
    parameters:
        string clockModule = default(""); // relative path of a module that implements IClock; optional
        volatile double generationInterval @unit(s); // time interval between two subsequent token generation events
        volatile double numTokens = default(1); // number of tokens generated repeatedly
        @class(TimeBasedTokenGenerator);
        @display("i=block/control");
        @signal[tokensCreated](type=double);
        @statistic[tokensCreated](title="tokens created"; record=count,sum,vector; interpolationmode=none);
}
