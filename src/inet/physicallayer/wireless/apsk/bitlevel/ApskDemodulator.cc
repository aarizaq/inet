//
// Copyright (C) 2014 OpenSim Ltd.
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

#include "inet/physicallayer/wireless/apsk/bitlevel/ApskDemodulator.h"

#include "inet/physicallayer/wireless/apsk/bitlevel/ApskSymbol.h"
#include "inet/physicallayer/wireless/common/modulation/BpskModulation.h"
#include "inet/physicallayer/wireless/common/modulation/Qam16Modulation.h"
#include "inet/physicallayer/wireless/common/modulation/Qam64Modulation.h"
#include "inet/physicallayer/wireless/common/modulation/QpskModulation.h"
#include "inet/physicallayer/wireless/common/radio/bitlevel/SignalBitModel.h"

namespace inet {

namespace physicallayer {

Define_Module(ApskDemodulator);

ApskDemodulator::ApskDemodulator() :
    modulation(nullptr)
{
}

void ApskDemodulator::initialize(int stage)
{
    if (stage == INITSTAGE_LOCAL)
        modulation = ApskModulationBase::findModulation(par("modulation"));
}

std::ostream& ApskDemodulator::printToStream(std::ostream& stream, int level, int evFlags) const
{
    stream << "ApskDemodulator";
    if (level <= PRINT_LEVEL_DETAIL)
        stream << EV_FIELD(modulation, printFieldToString(modulation, level + 1, evFlags));
    return stream;
}

const IReceptionBitModel *ApskDemodulator::demodulate(const IReceptionSymbolModel *symbolModel) const
{
    const std::vector<const ISymbol *> *symbols = symbolModel->getSymbols();
    BitVector *bits = new BitVector();
    for (auto& symbols_i : *symbols) {
        const ApskSymbol *symbol = dynamic_cast<const ApskSymbol *>(symbols_i);
        ShortBitVector symbolBits = modulation->demapToBitRepresentation(symbol);
        for (unsigned int j = 0; j < symbolBits.getSize(); j++)
            bits->appendBit(symbolBits.getBit(j));
    }
    return new ReceptionBitModel(b(-1), bps(NaN), b(-1), bps(NaN), bits, NaN);
}

} // namespace physicallayer

} // namespace inet

