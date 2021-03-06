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

package inet.clock.base;

//
// This is a base module for oscillators that drift relative to the nominal tick
// length over time.
//
simple DriftingOscillatorBase extends OscillatorBase
{
    parameters:
        displayStringTextFormat = default("%c (%n + %d)"); // determines the text that is written on top of the submodule
        double nominalTickLength @unit(s) = default(0s); // 0 means simulation time precision
        double tickOffset @unit(s) = default(0s); // shifts ticks to the past, must be in the range of [0, current tick length)
        @signal[preOscillatorStateChanged];
        @signal[postOscillatorStateChanged];
        @class(DriftingOscillatorBase);
}

