
#include "Concentration.h"
#include "Utils.h"
#include "EmissionOperator.h"
#include "Parameters.h" // MODPARAMS namespace
#include <string>

EmissionOperator::EmissionOperator(MODPARAMS::FULLCHEMMAP *Emis, int active) {
  this->applied = false;
  this->E = *Emis;
  this->active = active;
}

void EmissionOperator::check() {
  if (active and not applied)
    Utils::Error("Failed to apply Emissions");
  if (not active and applied)
    Utils::Error("Unintended Emission Application");
}

void EmissionOperator::apply(Concentrations *C) {
    std::string label;
    if (active)
      for (int n=0; n<MODPARAMS::NCHEM; n++)
            for (int i=0; i<MODPARAMS::N; i++) {
              // molecules/cm^3 =  E (molec cm^-3 s^-1) * dt (hr) * 3600s/hr
              label = C->names[n];
              (C->values)[label](i) += E[label](i) * MODPARAMS::time_step * 3600;
            }
      applied = true;
    check();
}

EmissionOperator::~EmissionOperator(){};
