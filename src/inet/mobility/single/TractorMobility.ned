//
// Copyright (C) 2007 Peterpaul Klein Haneveld
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//

package inet.mobility.single;

import inet.mobility.base.MovingMobilityBase;

//
// Moves a tractor through a field with a certain amount of rows.
// Since the tractor also moves around the field, the tractor travels
// the number of rows PLUS one rows. Consider the following piece of
// ascii-art for rows=2.
//
// <pre>
// >>>>>>>>>>>>>>>v
// ^              v
// ^              v
// <<<<<<<<<<<<<<<<
// v              ^
// v              ^
// >>>>>>>>>>>>>>>^
// </pre>
//
// NOTE: Does not yet support 3-dimensional movement.
// @author Peterpaul Klein Haneveld
//
simple TractorMobility extends MovingMobilityBase
{
    parameters:
        double speed @unit(mps);
        double x1 @unit(m);
        double y1 @unit(m);
        double x2 @unit(m);
        double y2 @unit(m);
        int rowCount; // the number of rows on the field
        @class(TractorMobility);
}

