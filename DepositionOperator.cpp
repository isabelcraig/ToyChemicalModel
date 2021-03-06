
#include <iostream>
#include "Parameters.hpp"
#include "Grid.hpp"
#include "DepositionOperator.hpp"
#include "Utils.hpp"
#include <string>

DepositionOperator::DepositionOperator(POINTCHEMMAP *vd){
  this->vd = *vd;
}

void DepositionOperator::apply(Grid *C) {
    std::string label;
      for (int n = 0; n<NCHEM; n++){
        for (int i = 0; i<N; i++){
          label = (C->names)[n];
          C->values[label](i) += C->values[label](i) * vd[label] * \
          (PARAMS_time_step * 3600) * 1/(100*PARAMS_del_z);
        }
      }
  }

DepositionOperator::~DepositionOperator(){};
